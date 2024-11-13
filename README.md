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

<img src="https://github-production-user-asset-6210df.s3.amazonaws.com/117186588/385680466-5522f94c-dc98-450e-a76c-595a04a24179.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20241113%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241113T090618Z&X-Amz-Expires=300&X-Amz-Signature=b34e1573b15008ca3ddfc8ffcc3e7b3afed18aa5e344660a2397a7cc28446beb&X-Amz-SignedHeaders=host" height="300" />