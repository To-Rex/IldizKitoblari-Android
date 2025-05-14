import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';

class OfferPage extends StatelessWidget {
  OfferPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getOffer();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() => _getController.offerModel.value.data != null
          ? SingleChildScrollView(child: Container(margin: EdgeInsets.only(top: 60.h, bottom: 50.h, left: 5.w, right: 5.w), child: Html(data: 'uz_UZ' == _getController.getLocale() ? _getController.offerModel.value.data!.content?.uz : 'oz_UZ' == _getController.getLocale() ? _getController.offerModel.value.data!.content?.oz : _getController.offerModel.value.data!.content?.ru)))
          : const Center(child: CircularProgressIndicator())
      )
    );
  }
}