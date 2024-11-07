import 'package:flutter/material.dart';
part 'image_slide_show_view.dart';

class ImageSlideWidget extends StatefulWidget {
  const ImageSlideWidget({
    super.key,
    required this.child,
    this.scrollController,
    this.overlayWidget,
    this.initShowOverlay,
  });
  final ScrollController? scrollController;
  final Widget child;
  final Stack? overlayWidget;
  final bool? initShowOverlay;
  @override
  State<ImageSlideWidget> createState() => _ImageSlideWidgetState();
}

class _ImageSlideWidgetState extends State<ImageSlideWidget> {
  final GlobalKey itemKey = GlobalKey();
  String id = "${DateTime.now().microsecondsSinceEpoch}-image-slide";

  scrollParentToCenter() {
    BuildContext? currentContext = itemKey.currentContext;
    if (widget.scrollController == null || currentContext == null) return;

    var screenSize = MediaQuery.sizeOf(context);
    var imageSize = currentContext.size!;

    var imagePosition = (currentContext.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
    var toPosition = Offset(0, (screenSize.height - imageSize.height) / 2);

    double spaceToCenter = imagePosition.dy - toPosition.dy;

    widget.scrollController!.animateTo(
      widget.scrollController!.offset + spaceToCenter,
      duration: const Duration(milliseconds: ImageSlideShow.longDuration),
      curve: Curves.ease,
    );
  }

  void slideChild() {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) => ImageSlideShow(
          scrollController: widget.scrollController,
          animationId: id,
          overlayWidget: widget.overlayWidget,
          initShowOverlay: widget.initShowOverlay,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        scrollParentToCenter();
        slideChild();
      },
      child: Hero(
        key: itemKey,
        tag: id,
        child: widget.child,
      ),
    );
  }
}
