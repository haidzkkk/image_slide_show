import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_slide_show/image_slide_show.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HeroImageScrollScreen(),
    );
  }
}

class HeroImageScrollScreen extends StatefulWidget {
  const HeroImageScrollScreen({super.key});

  @override
  State<HeroImageScrollScreen> createState() => _HeroImageScrollScreenState();
}

class _HeroImageScrollScreenState extends State<HeroImageScrollScreen> {
  late ScrollController scrollController = ScrollController();

  List<String> imageUrls = [
    "https://letsenhance.io/static/03620c83508fc72c6d2b218c7e304ba5/11499/UpscalerAfter.jpg",
    "https://imageupscaler.com/wp-content/uploads/2024/07/deblured-cutty-fox.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
    "https://photo.znews.vn/w660/Uploaded/mdf_eioxrd/2021_07_06/2.jpg",
    "https://www.vietnamworks.com/hrinsider/wp-content/uploads/2023/12/hinh-nen-dien-thoai-23.jpg",
    "https://www.vietnamworks.com/hrinsider/wp-content/uploads/2023/12/canh-dong-hoa-khien-cho-nguoi-ta-mo-mong.jpg"
  ];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        controller: scrollController,
        itemCount: 30,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Image.network(
                      imageUrls[Random().nextInt(imageUrls.length)],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Do Thanh Hai",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "30 minutes ago",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              Builder(builder: (context) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ImageSlideWidget(
                    scrollController: scrollController,
                    initShowOverlay: true,
                    overlayWidget: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          right: 10,
                          child: DropdownButton<String>(
                            items: const [
                              DropdownMenuItem(child: Text("Action 1"), value: "1",),
                              DropdownMenuItem(child: Text("Action 2"), value: "2",),
                              DropdownMenuItem(child: Text("Action 3"), value: "3",),
                            ],
                            onChanged: (String? value) {  },
                          ),
                        )
                      ],
                    ),
                    child: Image.network(
                      imageUrls[Random().nextInt(imageUrls.length)],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}


