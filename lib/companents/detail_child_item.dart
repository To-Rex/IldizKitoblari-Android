import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';
import '../resource/component_size.dart';
import 'filds/text_large.dart';
import 'filds/text_small.dart';

class DetailChildItem extends StatelessWidget {
  final String title;
  final bool check;
  final Function function;

  DetailChildItem({super.key, required this.title, required this.function, required this.check});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _getController.width.value,
        margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
        child:InkWell(
            onTap: () {_getController.fullCheck.value = false;},
            child:Row(
                children: [
                  if (_getController.fullCheck.value == true)
                    Icon(TablerIcons.arrow_left, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)),
                  if (_getController.fullCheck.value == true)
                    SizedBox(width: _getController.width.value * 0.02),
                  TextLarge(text: title, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                  const Expanded(child: SizedBox()),
                  if (check == true)
                    TextButton(onPressed: () {function();}, child: TextSmall(text: 'Barchasi'.tr, color: AppColors.primaryColor, fontWeight: FontWeight.w600))
                ]
            )
        )
    );
  }
}
