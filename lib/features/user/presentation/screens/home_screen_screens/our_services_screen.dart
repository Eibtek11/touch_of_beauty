import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/assets_path/svg_path.dart';
import '../../../../../core/assets_path/font_path.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/home_screen_widgets/center_services_item.dart';

class OurServicesScreen extends StatelessWidget {

  const OurServicesScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'خدماتنا',
            style: TextStyle(
                color: const Color(0xff263238),
                fontFamily: FontPath.almaraiBold,
                fontSize: 18.sp),
          ),
          toolbarHeight: 60.h,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  const Expanded(
                      child: CustomTextField(hintText: 'ابحث عن خدمة')),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 45.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                        color:
                        AppColorsLightTheme.secondaryColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(SvgPath.settingsSliders),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20.r,
                    color: const Color(0xffB83561),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'الرجاء اختيار عنوانك',
                    style: TextStyle(
                        color: const Color(0xff263238),
                        fontFamily: FontPath.almaraiBold,
                        fontSize: 12.sp),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style:
                    ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: Text(
                      'الخدمات المنزلية',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontPath.almaraiRegular,
                          fontSize: 12.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColorsLightTheme.authTextFieldFillColor,
                        shape: const StadiumBorder()),
                    child: Text('الخدمات بالمركز',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: FontPath.almaraiRegular,
                            fontSize: 12.sp)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child:  const CenterServicesCategoryItem(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
