import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touch_of_beauty/core/network/api_end_points.dart';
import 'package:touch_of_beauty/features/user/buisness_logic/services_providers_cubit/services_providers_cubit.dart';
import 'package:touch_of_beauty/features/user/buisness_logic/services_providers_cubit/services_providers_state.dart';
import 'package:touch_of_beauty/features/user/data/models/services_providers_model.dart';
import '../../../../../core/app_theme/light_theme.dart';
import '../../../../../core/assets_path/font_path.dart';

class SalonItemBuilder extends StatelessWidget {
  final ServicesProviderModel servicesProviderModel;
  final bool isFavoriteItemBuilder;

  const SalonItemBuilder({Key? key, required this.servicesProviderModel, this.isFavoriteItemBuilder = false})
      : super(key: key);

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
                // if(!isFavoriteItemBuilder)Positioned(
                //   top: 14.h,
                //   left: 14.w,
                //   child: BlocConsumer<ServicesProvidersCubit, ServicesProvidersState>(
                //     listener: (context, state ){
                //       var cubit = ServicesProvidersCubit.get(context);
                //       if(state is DeleteServicesProviderToFavSuccess){
                //         cubit.favoritesServicesProvidersList.removeWhere((element) => element.providerId == servicesProviderModel.id);
                //       }
                //     },
                //     builder: (context, state) {
                //       var cubit = ServicesProvidersCubit.get(context);
                //       return InkWell(
                //         onTap: (){
                //           if(!cubit.favorites[servicesProviderModel.id!]!){
                //             cubit.addServicesProviderToFavorite(id: servicesProviderModel.id!);
                //           }
                //           else if(cubit.favorites[servicesProviderModel.id!]!){
                //             cubit.deleteServicesProviderToFavorite(id: servicesProviderModel.id!);
                //           }
                //         },
                //         child: CircleAvatar(
                //           radius: 15.r,
                //           backgroundColor: Colors.white,
                //           child: Center(
                //             child: Icon(
                //               cubit.favorites[servicesProviderModel.id!]!?Icons.favorite:Icons.favorite_border,
                //               color: AppColorsLightTheme.secondaryColor,
                //               size: 23.r,
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),),
                if(isFavoriteItemBuilder)Positioned(
                  top: 14.h,
                  left: 14.w,
                  child: BlocConsumer<ServicesProvidersCubit, ServicesProvidersState>(
                    listener: (context, state ){
                      var cubit = ServicesProvidersCubit.get(context);
                      if(state is DeleteServicesProviderToFavSuccess){
                        cubit.favoritesServicesProvidersList.removeWhere((element) => element.providerId == servicesProviderModel.id);
                      }
                    },
                    builder: (context, state) {
                      var cubit = ServicesProvidersCubit.get(context);
                      return InkWell(
                        onTap: (){
                            cubit.deleteServicesProviderToFavorite(id: servicesProviderModel.id!);
                        },
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
                      );
                    },
                  ),)
              ],
            ),
            if(!isFavoriteItemBuilder)Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${servicesProviderModel.title}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontPath.almaraiBold,
                            color: const Color(0xff1E2432)),
                      ),
                      RatingBar.builder(
                        itemSize: 16.r,
                        ignoreGestures: true,
                        initialRating: 0,
                        minRating: 1,
                        unratedColor: Colors.grey.shade400,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                        itemBuilder: (context, _) =>
                        const Icon(
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
                    '${servicesProviderModel.addresses![0].city}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontPath.almaraiRegular,
                      color: const Color(0xff666666),
                    ),
                  ),
                ],
              ),
            ),
            if(isFavoriteItemBuilder)Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                      '${servicesProviderModel.addresses![0].city}',
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
                      child: Text(
                        '${servicesProviderModel.description}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: FontPath.almaraiRegular,
                          color: const Color(0xff666666),
                        ),
                      ),
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
