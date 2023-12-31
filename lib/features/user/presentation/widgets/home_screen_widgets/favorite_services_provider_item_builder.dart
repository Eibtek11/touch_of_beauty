import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touch_of_beauty/core/network/api_end_points.dart';
import '../../../../../core/app_theme/light_theme.dart';
import '../../../../../core/assets_path/font_path.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/models/favorites_services_provider_model.dart';

class FavoriteSalonItemBuilder extends StatelessWidget {
  final FavoriteServicesProviderModel servicesProviderModel;
  final void Function()? delete;

  const FavoriteSalonItemBuilder({Key? key, required this.servicesProviderModel, required this.delete })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        height: 210.h,
        width: 265.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.29),
                offset: Offset(0, 3.h),
                blurRadius: 6.r)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 118.h,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                    "${EndPoints.imageBaseUrl}${servicesProviderModel
                        .userImgUrl}",
                    placeholder: (context, url) =>
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),),

                Positioned(
                  top: 14.h,
                  left: 14.w,
                  child: InkWell(
                    onTap: delete,
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: AppColorsLightTheme.secondaryColor,
                          size: 23.r,
                        ),
                      ),
                    ),
                  ))
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${servicesProviderModel.title}',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: FontPath.almaraiBold,
                          color: const Color(0xff1E2432)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      servicesProviderModel.addresses!.isNotEmpty?servicesProviderModel.addresses![0].city!:LocaleKeys.no_address_added.tr(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: FontPath.almaraiRegular,
                        color: const Color(0xff666666),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Expanded(
                      child: HtmlWidget('${servicesProviderModel.description}',),
                      // Text(
                      //   '${servicesProviderModel.description}',
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //     fontSize: 11.sp,
                      //     fontFamily: FontPath.almaraiRegular,
                      //     color: const Color(0xff666666),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
