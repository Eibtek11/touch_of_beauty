import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_version/new_version.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/assets_path/svg_path.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../buisness_logic/main_cubit/main_cubit.dart';
import '../../buisness_logic/main_cubit/main_state.dart';
import '../widgets/home_screen_widgets/build_custom_drawer.dart';

class UserMainLayout extends StatefulWidget {
  const UserMainLayout({Key? key}) : super(key: key);

  @override
  State<UserMainLayout> createState() => _UserMainLayoutState();
}

class _UserMainLayoutState extends State<UserMainLayout> {
  @override
  void initState() {
    _checkGorUpdates();
    super.initState();
  }

  void _checkGorUpdates() async{
    final checkForNewVersion = NewVersion(
      androidId: 'com.eibtek.khanetgamal',
      iOSId: 'com.eibtek.khanetgamal',
    );
    checkForNewVersion.showAlertIfNecessary(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            drawer: AppDrawer(
              closeDrawer: () {
                cubit.scaffoldKey.currentState!.closeDrawer();
              },
            ),
            body: cubit.screens[cubit.cIndex],
            bottomNavigationBar: SizedBox(
              height: 70.h,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedFontSize: 13.sp,
                unselectedFontSize: 12.sp,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: AppColorsLightTheme.primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.cIndex,
                selectedLabelStyle: const TextStyle(
                  color: AppColorsLightTheme.primaryColor,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                onTap: cubit.onTap,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      SvgPath.homeIcon,
                      colorFilter: ColorFilter.mode(
                        cubit.cIndex == 0
                            ? AppColorsLightTheme.primaryColor
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: LocaleKeys.home.tr(),
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        SvgPath.reservationIcon,
                        colorFilter: ColorFilter.mode(
                          cubit.cIndex == 1
                              ? AppColorsLightTheme.primaryColor
                              : Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: LocaleKeys.my_reservations.tr()),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        SvgPath.notificationIcon,
                        colorFilter: ColorFilter.mode(
                          cubit.cIndex == 2
                              ? AppColorsLightTheme.primaryColor
                              : Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: LocaleKeys.notification.tr()),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        SvgPath.profileIcon,
                        colorFilter: ColorFilter.mode(
                          cubit.cIndex == 3
                              ? AppColorsLightTheme.primaryColor
                              : Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: LocaleKeys.profile.tr()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
