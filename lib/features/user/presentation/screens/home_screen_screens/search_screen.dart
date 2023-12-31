import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import '../../../../../core/assets_path/font_path.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../buisness_logic/services_cubit/services_cubit.dart';
import '../../../buisness_logic/services_cubit/services_state.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/home_screen_widgets/search_check_button_item.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  final dynamic servicesProviderId;

  const SearchScreen({super.key, this.servicesProviderId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues rangeValues = const RangeValues(1, 4000);

  @override
  void initState() {
    if (UserServicesCubit.get(context).citiesList.isEmpty) {
      UserServicesCubit.get(context).getCities();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            LocaleKeys.search_prober.tr(),
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
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shrinkWrap: true,
          children: [
            StatefulBuilder(
              builder:
                  (BuildContext context, void Function(void Function()) sS) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      LocaleKeys.price.tr(),
                      style: TextStyle(
                        color: AppColorsLightTheme.searchScreenTextColor,
                        fontFamily: FontPath.almaraiRegular,
                        fontSize: 14.sp,
                      ),
                    ),
                    RangeSlider(
                      max: 4000,
                      min: 1,
                      inactiveColor: Colors.grey.withOpacity(0.5),
                      activeColor: AppColorsLightTheme.primaryColor,
                      values: rangeValues,
                      onChanged: (RangeValues values) {
                        sS(() {
                          rangeValues = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${rangeValues.start.round().toString()} ريال ',
                          style: TextStyle(
                              color: const Color(0xff757575),
                              fontFamily: FontPath.almaraiRegular,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          width: 144.w,
                        ),
                        Text(
                          '${rangeValues.end.round().toString()} ريال',
                          style: TextStyle(
                              color: const Color(0xff757575),
                              fontFamily: FontPath.almaraiRegular,
                              fontSize: 12.sp),
                        )
                      ],
                    )
                  ],
                );
              },
            ),
            BlocConsumer<UserServicesCubit, UserServicesState>(
              listener: (context, state) {
                var cubit = UserServicesCubit.get(context);
                if(state is GetFilteredServicesByServiceProviderIdSuccess){
                  Navigator.pop(context);
                  if(cubit.mainResponse.errorCode != 0){
                    Fluttertoast.showToast(msg: '${cubit.mainResponse.errorMessage}');
                  }else{
                    Fluttertoast.showToast(msg: '${cubit.mainResponse.errorMessage}');
                    Navigator.pushNamed(context, ScreenName.filteredServicesScreen);
                  }
                }if (state is GetFilteredServicesByServiceProviderIdLoading){
                  showProgressIndicator(context);
                }
              },
              builder: (context, state) {
                var cubit = UserServicesCubit.get(context);
                return state is! GetCitiesLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.changeButtonState(onPressed: () {
                                      cubit.inHome = !cubit.inHome;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: cubit.inHome
                                          ? AppColorsLightTheme.primaryColor
                                          : AppColorsLightTheme
                                              .authTextFieldFillColor,
                                      shape: const StadiumBorder()),
                                  child: Text(
                                    LocaleKeys.home_serv.tr(),
                                    style: TextStyle(
                                        color: cubit.inHome
                                            ? Colors.white
                                            : Colors.grey,
                                        fontFamily: FontPath.almaraiRegular,
                                        fontSize: 12.sp),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.changeButtonState(onPressed: () {
                                      cubit.inCenter = !cubit.inCenter;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: cubit.inCenter
                                          ? AppColorsLightTheme.primaryColor
                                          : AppColorsLightTheme
                                              .authTextFieldFillColor,
                                      shape: const StadiumBorder()),
                                  child: Text(
                                    LocaleKeys.center_serv.tr(),
                                    style: TextStyle(
                                        color: cubit.inCenter
                                            ? Colors.white
                                            : Colors.grey,
                                        fontFamily: FontPath.almaraiRegular,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          Text(LocaleKeys.services_type.tr(),
                              style: TextStyle(
                                  color:
                                      AppColorsLightTheme.searchScreenTextColor,
                                  fontFamily: FontPath.almaraiRegular,
                                  fontSize: 14.sp)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.titleType.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SearchCheckButtonItem(
                                index: index,
                                currentIndex: cubit.servicesCI,
                                title: cubit.titleType[index],
                                onPressed: () {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.servicesCI = index;
                                  });
                                },
                                onChanged: (value) {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.servicesCI = index;
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Text(LocaleKeys.city.tr(),
                              style: TextStyle(
                                  color:
                                      AppColorsLightTheme.searchScreenTextColor,
                                  fontFamily: FontPath.almaraiRegular,
                                  fontSize: 14.sp)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.citiesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SearchCheckButtonItem(
                                title: cubit.citiesList[index].name!,
                                index: index,
                                currentIndex: cubit.cityCurrentId,
                                onPressed: () {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.cityId = cubit.citiesList[index].id!;
                                    cubit.cityCurrentId = index;
                                  });
                                },
                                onChanged: (value) {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.cityId = cubit.citiesList[index].id!;
                                    cubit.cityCurrentId = index;
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Text(LocaleKeys.arrangement.tr(),
                              style: TextStyle(
                                  color:
                                      AppColorsLightTheme.searchScreenTextColor,
                                  fontFamily: FontPath.almaraiRegular,
                                  fontSize: 14.sp)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.arrangement.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SearchCheckButtonItem(
                                onChanged: (value) {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.arrangementCI = index;
                                  });
                                },
                                title: cubit.arrangement[index],
                                index: index,
                                currentIndex: cubit.arrangementCI,
                                onPressed: () {
                                  cubit.changeButtonState(onPressed: () {
                                    cubit.arrangementCI = index;
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          CustomUserButton(
                              buttonTitle: LocaleKeys.search.tr(),
                              isTapped: () {
                                cubit.filteredServicesPageNumber = 1;
                                cubit.getFilteredServices(
                                  servicesProviderId: widget.servicesProviderId,
                                  inCenter: cubit.inCenter,
                                  inHome: cubit.inHome,
                                  minPrice: rangeValues.start.round(),
                                  maxPrice: rangeValues.end.round(),
                                  cityId: cubit.cityId,
                                  serviceTypeDto: cubit.servicesCI,
                                  orderFromNew: cubit.arrangementCI==0?true:false,
                                );
                              },
                              width: double.infinity,
                              paddingVertical: 16.h,
                              paddingHorizontal: 45.w),
                          SizedBox(
                            height: 22.h,
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator.adaptive());
              },
            ),
          ],
        ),
      ),
    );
  }
}
