import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/assets_path/svg_path.dart';
import '../../../../core/assets_path/font_path.dart';
import '../../../../core/constants/constants.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../buisness_logic/v_reservations_cubit/v_reservation_cubit.dart';
import '../../buisness_logic/v_reservations_cubit/v_reservation_state.dart';
import '../widgets/order_item_builder.dart';
import '../widgets/screen_layout_widget.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  String? value;
  String? dayValue = todayTo.first;
  late int homeZeroOrCenterOne;

  @override
  void initState() {
    homeZeroOrCenterOne = 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreenWidget(
        firstContainerBackgroundHeight: 214.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<VReservationCubit, VReservationState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = VReservationCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.home.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontPath.almaraiBold,
                              fontSize: 17.sp),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ScreenName.vendorNotificationScreen);
                        },
                        icon: SvgPicture.asset(
                          SvgPath.notificationBill,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                          height: 28.h,
                          width: 23.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.h,
                        width: 160.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 27.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.r),
                          color: AppColorsLightTheme.authTextFieldFillColor,
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          hint: Text(
                            LocaleKeys.chooseDayType.tr(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey,
                              fontFamily: FontPath.almaraiRegular,
                            ),
                          ),
                          items: todayTo
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: const Color(0xff666666),
                                          fontFamily: FontPath.almaraiRegular,
                                          fontSize: 14.sp),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              dayValue = val!;
                              if(value!=null){
                                if (dayValue == LocaleKeys.today.tr()) {
                                  cubit.startDate = DateTime.now()
                                      .subtract(const Duration(days: 1))
                                      .toString();
                                  cubit.endDate = DateTime.now()
                                      .add(const Duration(days: 1))
                                      .toString();
                                  VReservationCubit.get(context)
                                      .getTodayOrders(inHome: value== LocaleKeys.in_center.tr()?false:true);
                                } else {
                                  cubit.startDate = DateTime.now()
                                      .subtract(const Duration(days: 2))
                                      .toString();
                                  cubit.endDate = DateTime.now()
                                      .subtract(const Duration(days: 1))
                                      .toString();
                                  VReservationCubit.get(context)
                                      .getTodayOrders(inHome: value== LocaleKeys.in_center.tr()?false:true);
                                }
                              }else{
                                Fluttertoast.showToast(msg: LocaleKeys.chooseServicesType.tr(),backgroundColor: Colors.red);
                              }
                            });
                          },
                          value: dayValue,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 160.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 27.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.r),
                          color: AppColorsLightTheme.authTextFieldFillColor,
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(
                            LocaleKeys.chooseServicesType.tr(),
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontFamily: FontPath.almaraiRegular),
                          ),
                          underline: const SizedBox.shrink(),
                          items: vendorItemsList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: const Color(0xff666666),
                                          fontFamily: FontPath.almaraiRegular,
                                          fontSize: 14.sp),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              value = val!;
                              if (value == LocaleKeys.in_center.tr()) {
                                homeZeroOrCenterOne = 0;
                                VReservationCubit.get(context)
                                    .getTodayOrders(inHome: false);
                              } else {
                                VReservationCubit.get(context)
                                    .getTodayOrders(inHome: true);
                                homeZeroOrCenterOne = 0;
                              }
                            });
                          },
                          value: value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  Expanded(
                    child: state is GetTodayOrdersLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : cubit.getTodayOrdersList.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.sp),
                                    child: OrderItemBuilder(
                                      homeZeroOrCenterOne: homeZeroOrCenterOne,
                                      reserveModel:
                                          cubit.getTodayOrdersList[index],
                                    ),
                                  );
                                },
                                itemCount: cubit.getTodayOrdersList.length,
                              )
                            : Text(
                                LocaleKeys.no_services_yet.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColorsLightTheme.primaryColor,
                                    fontFamily: FontPath.almaraiBold,
                                    fontSize: 17.sp),
                              ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
