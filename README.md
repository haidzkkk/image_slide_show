# image_slide_show

A simple show image widget for Flutter. For this Widget it will to help you show image like other social media app.

## Installation

Add `image_slide_show` as a dependency in your pubspec.yaml file.

```yaml
image_slide_show: ^1.0.5
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

<img src="https://github.com/user-attachments/assets/5522f94c-dc98-450e-a76c-595a04a24179" alt="Example Image" height="400"/>