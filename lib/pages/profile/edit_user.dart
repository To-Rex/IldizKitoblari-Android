import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/insturment/bottom_sheets.dart';
import '../../companents/text_fild_auth.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../../resource/component_size.dart';
import 'orders_page.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GetController _getController = Get.put(GetController());
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _getController.fullNameController.text = _getController.meModel.value.data!.result!.fullName.toString();
      ApiController().editUser(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLarge(text: 'Shaxsiy ma‘lumotlar',color: Theme.of(context).colorScheme.onSurface),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: Get.width * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {Get.back();}),
        actions: [
          PopupMenuButton<int>(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)),
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  onTap: () => Get.to(OrdersPage()),
                  child: Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)),
                        SizedBox(width: Get.width * 0.02),
                        TextSmall(text: 'Buyurtmalar', color: Theme.of(context).colorScheme.onSurface),
                        SizedBox(width: Get.width * 0.02)
                      ]
                  )
              ),
              PopupMenuItem(
                  value: 1,
                  onTap: () => BottomSheets().showLogOut(context),
                  child: Row(
                      children: [
                        Icon(Icons.logout, color: AppColors.secondaryColor, size: ComponentSize.backIcons(context)),
                        SizedBox(width: Get.width * 0.02),
                        const TextSmall(text: 'Ilovadan chiqish', color: AppColors.secondaryColor),
                        SizedBox(width: Get.width * 0.02),
                      ]
                  )
              )
            ]
          )
        ]
      ),
      body: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100.w,
                  margin: EdgeInsets.only(left: Get.width * 0.04, top: Get.width * 0.04, bottom: Get.width * 0.04),
                  child: Stack(
                    children: [
                      _getController.meModel.value.data!.result!.avatar == null || _getController.meModel.value.data!.result!.avatar == ''
                          ? CircleAvatar(
                              radius: ComponentSize.starIcons(context) + ComponentSize.starIcons(context) /2, backgroundColor: AppColors.grey,
                              child: TextLarge(text: _getController.meModel.value.data!.result!.fullName.toString().contains(' ') ? _getController.meModel.value.data!.result!.fullName.toString().split(' ')[0].substring(0,1) + _getController.meModel.value.data!.result!.fullName.toString().split(' ')[1].substring(0,1) : _getController.meModel.value.data!.result!.fullName.toString().substring(0,1), color: Theme.of(context).colorScheme.surface, fontSize: Get.width * 0.06, fontWeight: FontWeight.bold))
                          : CircleAvatar(
                              radius: ComponentSize.starIcons(context) + ComponentSize.starIcons(context) / 2,
                              backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                          ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: ComponentSize.starIcons(context),
                            height: ComponentSize.starIcons(context),
                            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(Get.width * 0.06.r)),
                            child: IconButton(
                              icon: Icon(Icons.edit, color: AppColors.white, size: ComponentSize.backIcons(context)),
                              onPressed: () => {_pickImage(ImageSource.gallery)},
                              padding: const EdgeInsets.all(0),
                              constraints: const BoxConstraints(),
                              iconSize: Get.width * 0.06
                            )
                          )
                      )
                    ]
                  )
                ),
                Expanded(child: Container(
                    width: Get.width * 0.66,
                    padding: EdgeInsets.only(left: Get.width * 0.05, top: Get.width * 0.04, bottom: Get.width * 0.04),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLarge(text: _getController.meModel.value.data!.result!.fullName.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 16.sp),
                          SizedBox(height: Get.height * 0.004),
                          TextSmall(text: 'ID ${_getController.meModel.value.data!.result!.sId.toString()}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),fontSize: 15.sp)
                        ]
                    )
                ))

              ]
            ),
            SizedBox(height: Get.height * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck.isFalse)
              Container(
                padding: EdgeInsets.only(left: Get.width * 0.05),
                child: TextLarge(text: '${'Telefon raqam'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
              )
            else
              Container(
                padding: EdgeInsets.only(left: Get.width * 0.05),
                child: TextLarge(text: 'f.i.sh'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
              ),
            SizedBox(height: Get.height * 0.01),
            if (_getController.meModel.value.data!.result!.phone != null && _getController.editCheck.isFalse)
            Row(
                children: [
                  SizedBox(width: Get.width * 0.05),
                  _getController.meModel.value.data!.result!.phone == null && _getController.editCheck.isFalse ? TextSmall(text: 'Telefon raqam', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)) : TextSmall(text: _getController.meModel.value.data!.result!.phone.toString(), color: Theme.of(context).colorScheme.onSurface),
                ]
            )
            else
              Center(child: TextFieldsAuth(nameController: _getController.fullNameController, next: TextInputAction.next, inputType: TextInputType.name)),
            SizedBox(height: _getController.editCheck.isFalse ? Get.height * 0.05 : Get.height * 0.02),
            Container(
                //padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                width: _getController.width.value,
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor,padding: EdgeInsets.only(top: 16.h, bottom: 16.h), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                    onPressed: () {
                    if (_getController.editCheck.isFalse) {
                      _getController.editCheck.value = true;
                      _getController.fullNameController.text = _getController.meModel.value.data!.result!.fullName.toString();
                    }else{
                      if (_getController.fullNameController.text == '') {
                        ApiController().showToast(context, 'Xatolik', 'f.i.sh kiriting!', true, 3);
                        return;
                      }
                      _getController.editCheck.value = false;
                      ApiController().editUser(_getController.image.value);
                    }
                  },
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_getController.editCheck.isFalse)
                            Icon(Icons.edit, color: AppColors.white, size: ComponentSize.backIcons(context)),
                          SizedBox(width: Get.width * 0.02),
                          TextSmall(text: _getController.editCheck.isFalse ? 'Tahrirlash'.tr : 'Saqlash'.tr, color: AppColors.white, fontWeight: FontWeight.w600)
                    ]
                  )
                )
            )
          ],
        ))
    );
  }
}