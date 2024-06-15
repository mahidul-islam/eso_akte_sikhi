import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/editor_page_controller.dart';

class EditorPageView extends GetView<EditorPageController> {
  const EditorPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditorPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditorPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
