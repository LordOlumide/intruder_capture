import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intruder_capture/src/models/surveillance_model.dart';
import 'package:intruder_capture/src/repo/surveillance_repo.dart';
import 'package:intruder_capture/src/widgets/surveillance_pic_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<SurveillanceModel> images = [];

  final SurveillanceRepo _repo = SurveillanceRepo();
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = _repo.imageStream().listen((ImageProvider image) {
      setState(() {
        images.insert(0, SurveillanceModel(time: DateTime.now(), image: image));
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: const Text('Surveillance App'),
      ),
      body: images.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SurveillancePicCard(
                    image: images[index].image,
                    time: images[index].time,
                  ),
                );
              },
            ),
    );
  }
}
