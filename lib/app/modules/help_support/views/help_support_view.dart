import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelpSupportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HelpSupportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
