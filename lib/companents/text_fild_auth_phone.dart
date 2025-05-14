import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../controllers/get_controller.dart';

class TextFieldPhoneAuth extends StatelessWidget {
  final TextInputAction? next;
  final bool? enabled;
  final TextEditingController nameController;

  TextFieldPhoneAuth({super.key, required this.nameController, this.next, this.enabled});

  final GetController _getController = Get.put(GetController());

  final mackFormater = MaskTextInputFormatter(mask: '+998 (##) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {

    return Container(
        width: Get.width,
        margin: EdgeInsets.only(left: 15.w, right: 15.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
        child:  TextField(
            enabled: enabled ,
            controller: nameController,
            keyboardType: TextInputType.phone,
            textInputAction: next,
            focusNode: FocusNode(),
            style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, color: Theme.of(context).colorScheme.onSurface),
            maxLength: 19,
            buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
            inputFormatters: [mackFormater],
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'Kiriting'.tr,
                filled: true,
                isDense: true,
                fillColor: Theme.of(context).colorScheme.surface,
                hintStyle: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,              // No border
                    borderRadius: BorderRadius.circular(12.r)
                )
            )
        )
    );
  }
}