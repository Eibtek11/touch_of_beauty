import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/app_theme/light_theme.dart';
import '../../../../../core/assets_path/font_path.dart';
import '../../../../../core/assets_path/images_path.dart';

class SalonItemBuilder extends StatelessWidget {
  const SalonItemBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        height: 190.h,
        width: 265.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.29),
                  offset: Offset(0, 3.h),
                  blurRadius: 6.r)
            ]),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 118.h,
                  width: double.infinity,
                  child: Image.asset(
                    ImagePath.carouselImage1,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 14.h,
                    left: 14.w,
                    child: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: AppColorsLightTheme.secondaryColor,
                          size: 12.r,
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'شعر. الأظافر. الوجه',
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontFamily: FontPath.almaraiRegular,
                      color: const Color(0xffCCB48C),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'صالون خانة الجمال',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontPath.almaraiBold,
                            color: const Color(0xff1E2432)),
                      ),
                      RatingBar.builder(
                        itemSize: 14.r,
                        ignoreGestures: true,
                        initialRating: 4,
                        minRating: 1,
                        unratedColor: Colors.white,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColorsLightTheme.secondaryColor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'الطريق العام الخرج - الرياض (365)',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontPath.almaraiRegular,
                      color: const Color(0xff666666),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
