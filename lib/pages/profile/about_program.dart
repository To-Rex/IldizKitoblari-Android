import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/component_size.dart';

class AboutProgram extends StatelessWidget{
  AboutProgram({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getAbout();
    return Scaffold(
        appBar: AppBar(
            title: TextLarge(text: 'Dastur haqida'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)),
              onPressed: () {
                Get.back();
              }
            )
        ),
        body: Obx(() =>
            SingleChildScrollView(
                child: Column(
                    children: [
                      if (_getController.aboutModel.value.data?.content?.uz != null)
                        Container(
                            margin: EdgeInsets.only(top: Get.width * 0.04, left: Get.width * 0.03,right: Get.width * 0.03),
                            child: Html(
                                style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(ComponentSize.textSmall(context)!.toDouble()), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)},
                                data: 'uz_UZ' == _getController.getLocale() ? _getController.aboutModel.value.data?.content?.uz ?? '' : 'ru_RU' == _getController.getLocale() ? _getController.aboutModel.value.data?.content?.ru ?? '' : 'oz_OZ' == _getController.getLocale() ? _getController.aboutModel.value.data?.content?.oz ?? '' :  ''
                            )
                        )
                      else
                        if (!_getController.onLoading.value)
                          SizedBox(
                            height: Get.height * 0.8,
                            width: Get.width,
                            child: Center(child: TextSmall(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400))
                          )
                        else
                          Skeletonizer(
                            child: Container(
                              margin: EdgeInsets.only(top: Get.width * 0.04, left: Get.width * 0.03,right: Get.width * 0.03),
                              child: Column(
                                  children: [
                                    for(int i = 0; i < 2; i++)
                                      TextSmall(text: '"uz":"<p>&nbsp; &nbsp;Siz \"Ildiz kitoblari\"ni bilasizmi?</p>\n<p>&nbsp; \"Ildiz kitoblari\" 2023-yil 1-oktabrdan boshlab faoliyat ko\'rsatib kelmoqda.\"Ildiz kitoblari\"ni siz \"Azon kitoblari\" nomi orqali yaxshi bilasiz.\"Ildiz kitoblari\" bir necha yildir nafaqat xalqimiz, balki dunyoning ko\'p go\'shalarida istiqomat qilayotgan millatdoshlarimizning diniy-ma\'rifiy, axloqiy, ilmiy, huquqiy saviyasini oshirish yo\'lida baqadri imkon xizmat qilib kelmoqda.\"Ildiz kitoblari\" faoliyat olib borayotganiga uncha ko\'p vaqt bo\'lmasa-da,bu sohada mijozlar ishonchini qozonib,ularni mamnun etib kelmoqda.</p>\n<p>&nbsp; &nbsp;Biz 3 yildan ziyod vaqt mobaynida mijozlarga xizmat ko\'rsatib kelmoqdamiz. Do\'konlarimizdagi keng janr va turli nomlardagi sara asarlar orasidan o\'zin', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400)
                                  ]
                              )
                            )
                          )
                    ]
                )
            )
        )
    );
  }
}