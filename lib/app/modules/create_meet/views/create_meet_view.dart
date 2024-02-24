import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_meet_controller.dart';

class CreateMeetView extends GetView<CreateMeetController> {
  const CreateMeetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateMeetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateMeetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
