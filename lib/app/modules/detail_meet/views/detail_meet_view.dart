import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_meet_controller.dart';

class DetailMeetView extends GetView<DetailMeetController> {
  const DetailMeetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailMeetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailMeetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
