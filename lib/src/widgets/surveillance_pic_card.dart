import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intruder_capture/src/screens/image_viewing_screen.dart';

class SurveillancePicCard extends StatelessWidget {
  final ImageProvider image;
  final DateTime time;

  const SurveillancePicCard({
    super.key,
    required this.image,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedTime = '${DateFormat.yMMMd().format(time)}  '
        '${DateFormat.jm().format(time)}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageViewingScreen(
              title: formattedTime,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Column(
          children: [
            Image(
              image: image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                formattedTime,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
