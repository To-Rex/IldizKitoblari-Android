import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import 'filds/text_large.dart';

class AppBarSheets extends StatelessWidget {
  final String title;
  AppBarSheets({super.key, required this.title});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getController.height.value * 0.085,
      width: _getController.width.value * 0.95,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {Get.back();},
            child: Icon(TablerIcons.arrow_left, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).iconTheme.fill)
          ),
          SizedBox(width: _getController.width.value * 0.02),
          TextLarge(text: title, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500)
        ]
      )
    );
  }
}
