import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_router/screens_name.dart';
import '../../../../core/app_theme/light_theme.dart';
import '../../../../core/assets_path/font_path.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../vendor/presentation/widgets/screen_layout_widget_with_logo.dart';

class FreelancerCentersScreen extends StatelessWidget {
  const FreelancerCentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreenWithLogoWidget(
        firstContainerBackgroundHeight: 151.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'المركز',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontPath.almaraiBold,
                          fontSize: 17.sp),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, ScreenName.freelancerNotificationScreen);
                    },
                    child: SvgPicture.asset(
                      SvgPath.notificationBill,
                      color: Colors.white,
                      height: 28.h,
                      width: 23.w,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 186.h,
              ),
              buildItem(svgImage: SvgPath.centersIcon, title: 'بيانات مقدم الخدمة', onTap: (){
                Navigator.pushNamed(context, ScreenName.freelancerDetailsScreen);
              }),
              SizedBox(
                height: 10.h,
              ),
              const Divider(),
              buildItem(svgImage: SvgPath.clock, title: 'مواعيد العمل', onTap: (){
                Navigator.pushNamed(context, ScreenName.freelancerTimeScreen);
              }),
              SizedBox(
                height: 10.h,
              ),
              const Divider(),
              buildItem(svgImage: SvgPath.bag, title: 'خدماتي', onTap: (){
                Navigator.pushNamed(context, ScreenName.freelancerServicesScreen);
              }),
              SizedBox(
                height: 10.h,
              ),
              const Divider(),
              buildItem(svgImage: SvgPath.calender2, title: 'حجوزاتي', onTap: (){
                Navigator.pushNamed(context, ScreenName.vendorReservationsScreen);
              }),
              SizedBox(
                height: 10.h,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  } Widget buildItem({
    required String svgImage,
    required String title,
    required Function onTap
  }) {
    return ListTile(
      onTap: (){
        onTap();
      },
      leading: SvgPicture.asset(
        svgImage,
        color: AppColorsLightTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: const Color(0xff3C475C),
            fontSize: 14.sp,
            fontFamily: FontPath.almaraiRegular),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
