import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resource/colors.dart';
import '../filds/text_large.dart';
import '../filds/text_small.dart';

class AudioSkeleton extends StatelessWidget {
  const AudioSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 200.w,
                            height: 200.h,
                            margin: EdgeInsets.only(bottom: 15.h),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(10.r)), image: const DecorationImage(image: NetworkImage( 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: FadeInImage(
                                    image: const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                    placeholder: const AssetImage('assets/images/back.png'),
                                    imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: BoxDecoration(image: const DecorationImage(image: NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover), borderRadius: BorderRadius.all(Radius.circular(10.r))));},
                                    fit: BoxFit.cover
                                )
                            )
                        ),
                        TextLarge(text: 'Assalomu alaykum', fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                        SizedBox(height: 40.h),
                        Row(
                            children: [
                              SizedBox(width: 15.w),
                              TextSmall(text: 'Qalaysiz', fontSize: 20.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)
                            ]
                        ),
                        Slider(
                          value: 0.0,
                          min: 0,
                          max: 100, onChanged: (double value) {  },
                          activeColor:  Colors.grey.withOpacity(0.2),
                          inactiveColor: Colors.grey.withOpacity(0.2),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0:00'),
                                  Text('0:00'),
                                ]
                            )
                        ),
                        SizedBox(height: 10.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(icon: Icon(Icons.replay_10, size: 30.sp), onPressed: () {}),
                              IconButton(
                                  color: AppColors.primaryColor,
                                  icon: Icon(Icons.play_circle_filled, size: 60.sp
                                  ),
                                  onPressed: () {}
                              ),
                              IconButton(
                                  icon: Icon(Icons.forward_10, size: 30.sp),
                                  onPressed: (){}
                              )
                            ]
                        ),
                        SizedBox(height: 20.h)
                      ]
                  )
              ),
              SizedBox(height: 20.h),
              Row(
                  children: [
                    SizedBox(width: 15.w),
                    TextSmall(text: 'Bo‘limlar', fontSize: 20.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                  ]
              ),
              SizedBox(height: 10.h),
              for (int index = 0; index < 4; index++)
                Column(
                    children: [
                      InkWell(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {},
                          child: Container(
                              width: Get.width,
                              height: 60.h,
                              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all( Radius.circular(10.r)), image: const DecorationImage(image: NetworkImage( 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover)),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                            child: FadeInImage(
                                                image: const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                                placeholder: const AssetImage('assets/images/back.png'),
                                                imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: BoxDecoration(image: const DecorationImage(image: NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover), borderRadius: BorderRadius.all(Radius.circular(10.r))));},
                                                fit: BoxFit.cover
                                            )
                                        )
                                    ),
                                    SizedBox(width: 15.w),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextSmall(text: 'Assalomu alaykum', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                          SizedBox(height: 5.h),
                                          const TextSmall(text: '1024 MB', color: AppColors.primaryColor)
                                        ]
                                    ),
                                    const Spacer(),
                                    Container(
                                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), shape: BoxShape.circle),
                                      child: Icon(TablerIcons.lock_filled, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).iconTheme.fill),
                                    )
                                  ]
                              )
                          )
                      ),
                      Divider(thickness: 1, color: AppColors.grey, indent: 15.w, endIndent: 15.w)
                    ]
                )
            ]
        )
    );
  }

}