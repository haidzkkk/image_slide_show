part of 'image_slide_widget.dart';

class ImageSlideShow extends StatefulWidget {
  const ImageSlideShow({
    super.key,
    required this.child,
    required this.animationId,
    this.scrollController,
    this.overlayWidget,
    this.initShowOverlay,
  });

  final String animationId;
  final Widget child;
  final Stack? overlayWidget;
  final ScrollController? scrollController;
  final bool? initShowOverlay;

  static const int shortDuration = 50;
  static const int longDuration = 300;

  @override
  State<ImageSlideShow> createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  late Size sizeScreen = MediaQuery.of(context).size;

  late GlobalKey childKey = GlobalKey();
  ValueNotifier<Size?> sizeChild = ValueNotifier(null);

  Offset initWidgetPosition = Offset.zero;
  ValueNotifier<Offset?> widgetPosition = ValueNotifier(null);

  int durationAnimation = ImageSlideShow.shortDuration;
  int spaceDragDispose = 200;
  Offset? initDragPosition;
  Offset? updateDragPosition;

  double? initScrollPosition;

  late ValueNotifier<bool> showOverlay = ValueNotifier(widget.initShowOverlay ?? false);
  bool? overlayTemp;
  showOverLay([bool? isShow]){
    showOverlay.value = isShow ?? !showOverlay.value;
  }

  onStartDrag(DragDownDetails details) {

    durationAnimation = ImageSlideShow.shortDuration;
    initDragPosition = Offset(
      details.localPosition.dx,
      details.localPosition.dy,
    );
    overlayTemp = showOverlay.value;
  }

  onUpdateDrag(DragUpdateDetails details) {
    showOverLay(false);
    updateDragPosition = Offset(
      details.localPosition.dx,
      details.localPosition.dy,
    );
    widgetPosition.value = Offset(
      initWidgetPosition.dx + (updateDragPosition!.dx - initDragPosition!.dx),
      initWidgetPosition.dy + (updateDragPosition!.dy - initDragPosition!.dy),
    );
  }

  onEndDrag(DragEndDetails details) {
    double spaceDx = initDragPosition!.dx - details.localPosition.dx;
    double spaceDy = initDragPosition!.dy - details.localPosition.dy;
    durationAnimation = ImageSlideShow.longDuration;
    if (spaceDx < -1 * spaceDragDispose ||
        spaceDx > spaceDragDispose ||
        spaceDy < -1 * spaceDragDispose ||
        spaceDy > spaceDragDispose) {
      Navigator.pop(context);
    } else {
      widgetPosition.value = initWidgetPosition;
      initDragPosition = null;
      updateDragPosition = null;
    }

    showOverLay(overlayTemp);
  }

  scrollParentToDragPosition() {
    if (widget.scrollController != null && initDragPosition != null && updateDragPosition != null) {
      initScrollPosition ??= widget.scrollController!.offset;
      double spaceDrag = initDragPosition!.dy - updateDragPosition!.dy;
      widget.scrollController!.animateTo(
        initScrollPosition! + spaceDrag,
        duration: const Duration(milliseconds: 10),
        curve: Curves.ease,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) async {
      sizeChild.value = childKey.currentContext!.size!;
      initWidgetPosition = Offset(1, (sizeScreen.height - sizeChild.value!.height) / 2);
      widgetPosition.value = initWidgetPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: showOverLay,
        onPanDown: onStartDrag,
        onPanUpdate: onUpdateDrag,
        onPanEnd: onEndDrag,
        child: Stack(
          children: [
            Positioned.fill(
              child: ValueListenableBuilder(
                valueListenable: widgetPosition,
                builder: (context, position, child) {
                  bool isOpacity = initWidgetPosition.dy != position?.dy || initWidgetPosition.dy == 0;
                  return AnimatedOpacity(
                      duration: const Duration(milliseconds: ImageSlideShow.longDuration),
                      opacity: isOpacity ? 0.5 : 1,
                      child: const Material(color: Colors.black));
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: widgetPosition,
              builder: (context, position, child) {
                scrollParentToDragPosition();

                return AnimatedPositioned(
                  duration: Duration(milliseconds: durationAnimation),
                  left: position?.dx,
                  top: position?.dy,
                  child: ValueListenableBuilder(
                      valueListenable: sizeChild,
                      builder: (context, size, child) {
                        return SizedBox(
                          key: childKey,
                          height: size?.height,
                          width: size?.width,
                          child: Hero(
                            tag: widget.animationId,
                            child: widget.child,
                          ),
                        );
                      }),
                );
              },
            ),
            if(widget.overlayWidget != null)
              SafeArea(
                child: ValueListenableBuilder(
                    valueListenable: showOverlay,
                    builder: (context, isShow, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: ImageSlideShow.longDuration),
                      child: isShow ? widget.overlayWidget! : null,
                    );
                  }
                ),
              )
          ],
        ),
      ),
    );
  }
}
