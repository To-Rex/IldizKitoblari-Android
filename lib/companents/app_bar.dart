import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class MyAppBar extends StatelessWidget {
  String title;

  MyAppBar({Key? key, required this.title}) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: _getController.width.value * 0.025,
        right: _getController.width.value * 0.02,
      ),
      child: Column(
        children: [
          SizedBox(height: _getController.height.value * 0.052),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: _getController.width.value * 0.07,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Text(title.tr, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }
}
