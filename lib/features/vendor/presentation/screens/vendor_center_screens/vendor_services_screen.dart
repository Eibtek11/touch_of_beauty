import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import 'package:touch_of_beauty/features/vendor/presentation/screens/vendor_center_screens/add_services_screen.dart';
import '../../../../../core/app_router/screens_name.dart';
import '../../../../../core/app_theme/light_theme.dart';
import '../../../../../core/assets_path/font_path.dart';
import '../../../../../core/assets_path/svg_path.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../freelancer/presentation/widgets/custom_vendor_button.dart';
import '../../../../user/presentation/widgets/home_screen_widgets/grid_item_builder.dart';
import '../../../buisness_logic/services_cubit/vendor_services_cubit.dart';
import '../../../buisness_logic/services_cubit/vendor_services_state.dart';
import '../../widgets/screen_layout_widget_with_logo.dart';

class VendorServicesScreen extends StatelessWidget {
  const VendorServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColorsLightTheme.primaryColor,
        foregroundColor: Colors.white,
        toolbarHeight: 60.h,
        centerTitle: true,
        title: Text(
          LocaleKeys.services.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            fontFamily: FontPath.almaraiBold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.vendorNotificationScreen);
            },
            icon: SvgPicture.asset(
              SvgPath.notificationBill,
              width: 23.w,
              height: 28.h,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      body: BackgroundScreenWithLogoWidget(
        firstContainerBackgroundHeight: 60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<VendorServicesCubit, VendorServicesState>(
            listener: (context, state) {
              var cubit = VendorServicesCubit.get(context);

              if (state is GetServicesDetailsByItsIdLoadingState) {
                showProgressIndicator(context);
              } else if (state is GetServicesDetailsByItsIdSuccess) {
                if(cubit.errorCodeOfGettingTheServices == 0){
                  cubit.inCenter = cubit.servicesModel!.inCenter!;
                  cubit.inHome = cubit.servicesModel!.inHome!;
                  cubit.mainSectionValue =
                  cubit.servicesModel!.mainSection!.title!;
                  cubit.mainSectionId = cubit.servicesModel!.mainSection!.id!;
                  cubit.isAvailable = cubit.isAvailable;
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    ScreenName.vendorAddToServicesScreen,
                    arguments: AddToServicesArguments(
                      servicesModel: cubit.servicesModel,
                      type: 0,
                    ),
                  );
                  Fluttertoast.showToast(msg:cubit.mainResponse.errorMessage,backgroundColor: Colors.green);
                }else{
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg:'لم تتم موافقة الادمن علي الخدمة',backgroundColor: Colors.red);
                }
              }
            },
            builder: (context, state) {
              var cubit = VendorServicesCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: 130.h,
                  ),
                  SizedBox(
                    height: 400.h,
                    child: state is! GetServicesByServiceProviderIdLoading
                        ? GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.servicesList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                cubit.getServicesDetailsByItsId(
                                    id: cubit.servicesList[index].id!);
                                // print(cubit.servicesList[index].id!);
                                // print(token);
                              },
                              child: GridItemBuilder(
                                model: cubit.servicesList[index],
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                  ),
                  const Spacer(),
                  CustomVendorButton(
                      buttonTitle: LocaleKeys.add_new_services.tr(),
                      isTapped: () {
                        cubit.inCenter = false;
                        cubit.inHome = false;
                        cubit.isAvailable = false;
                        cubit.mainSectionValue = null;
                        Navigator.pushNamed(
                            context, ScreenName.vendorAddToServicesScreen,
                            arguments: AddToServicesArguments(
                                servicesModel: null, type: 0));
                      },
                      width: double.infinity,
                      paddingVertical: 14.h,
                      paddingHorizontal: 45.w),
                  SizedBox(
                    height: 40.h,
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
