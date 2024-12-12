import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageViewingScreen extends StatefulWidget {
  final String title;
  final ImageProvider image;

  const ImageViewingScreen(
      {super.key, required this.title, required this.image});

  @override
  State<ImageViewingScreen> createState() => _ImageViewingScreenState();
}

class _ImageViewingScreenState extends State<ImageViewingScreen> {
  bool appbarIsShowing = true;
  Color backgroundColor = Colors.grey.shade800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              appbarIsShowing = !appbarIsShowing;
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: backgroundColor,
                width: double.infinity,
                height: double.infinity,
              ),
              Hero(
                tag: 'picture',
                child: Center(
                  child: InteractiveViewer(
                    maxScale: 3.2,
                    minScale: 1.0,
                    clipBehavior: Clip.none,
                    child: Image(image: widget.image, fit: BoxFit.contain),
                  ),
                ),
              ),
              appbarIsShowing
                  ? Positioned(
                      top: 0,
                      // width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        color: backgroundColor.withOpacity(0.15),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: Navigator.of(context).pop,
                            ),
                            const SizedBox(width: 5),
                            FittedBox(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
