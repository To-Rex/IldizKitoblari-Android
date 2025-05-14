import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import 'filds/text_small.dart';

class TextFieldHints extends StatelessWidget {
  final String hintText;
  TextFieldHints({super.key, required this.hintText});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: _getController.height.value * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16.w),
          TextSmall(text: hintText, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}
