import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/object_editor_controller.dart';

class ObjectEditorView extends GetView<ObjectEditorController> {
  const ObjectEditorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectEditorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ObjectEditorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
