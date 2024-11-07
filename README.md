# image_slide_show

A simple show image widget for Flutter.

## Installation
Add `image_slide_show` as a dependency in your pubspec.yaml file.
```yaml
  image_slide_show:
    git: https://github.com/haidzkkk/image_slide_show
```

Import Photo View:
```dart
import 'package:image_slide_show/image_slide_show.dart';
```

## Gallery

To show image, use `ImageSlideWidget`

```dart
ImageSlideWidget(
    scrollController: scrollController,
    child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
    ),
)
```

Read more about the `ImageSlideWidget` widget [here](https://github.com/haidzkkk/image_slide_show/blob/main/lib/image_slide_widget.dart).

## Example

Read more about the example to use the `ImageSlideWidget` and `ImageSlideShow` widget [here](https://github.com/haidzkkk/image_slide_show/blob/main/example/lib/main.dart).

<video src="https://github.com/user-attachments/assets/fba0cb33-82af-4149-ab98-1d2051e830a4" width="300" autoplay
loop>
