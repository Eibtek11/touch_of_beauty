import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/assets_path/images_path.dart';
import 'package:touch_of_beauty/core/cache_manager/cache_keys.dart';
import 'package:touch_of_beauty/core/cache_manager/shared_preferences.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import 'package:touch_of_beauty/features/authentication/buisness_logic/auth_cubit.dart';
import 'package:touch_of_beauty/features/authentication/buisness_logic/auth_state.dart';
import 'package:touch_of_beauty/features/authentication/presentation/widgets/auht_text_form_field.dart';
import '../../../../core/assets_path/font_path.dart';
import '../../../../translations/locale_keys.g.dart';
import '../widgets/auth_button.dart';
import '../widgets/phone_auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            var cubit = AuthCubit.get(context);
            if (state is LoginLoading) {
              showProgressIndicator(context);
            }
            if (state is LoginSuccess) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: cubit.mainResponse.errorMessage);
              if (cubit.mainResponse.errorCode == 0 &&
                  state.loginModel.userType == 1) {
                CacheHelper.saveData(
                        key: CacheKeys.userId, value: state.loginModel.userId)
                    .whenComplete(() {
                  CacheHelper.saveData(
                          key: CacheKeys.token, value: state.loginModel.token)
                      .whenComplete(() {
                    CacheHelper.saveData(
                            key: CacheKeys.userType,
                            value: state.loginModel.userType.toString())
                        .whenComplete(() {
                      token = CacheHelper.getData(key: CacheKeys.token);
                      userId = CacheHelper.getData(key: CacheKeys.userId);
                      Navigator.pushNamedAndRemoveUntil(
                          context, ScreenName.userMainLayout, (route) => false);
                    });
                  });
                });
              } else if (cubit.mainResponse.errorCode == 0 &&
                  state.loginModel.userType == 2) {
                CacheHelper.saveData(
                        key: CacheKeys.userId, value: state.loginModel.userId)
                    .whenComplete(() {
                  CacheHelper.saveData(
                          key: CacheKeys.token, value: state.loginModel.token)
                      .whenComplete(() {
                    CacheHelper.saveData(
                            key: CacheKeys.userType,
                            value: state.loginModel.userType.toString())
                        .whenComplete(() {
                      token = CacheHelper.getData(key: CacheKeys.token);
                      userId = CacheHelper.getData(key: CacheKeys.userId);
                      Navigator.pushNamedAndRemoveUntil(context,
                          ScreenName.vendorMainLayout, (route) => false);
                    });
                  });
                });
              } else if (cubit.mainResponse.errorCode == 0 &&
                  state.loginModel.userType == 3) {
                CacheHelper.saveData(
                        key: CacheKeys.userId, value: state.loginModel.userId)
                    .whenComplete(() {
                  CacheHelper.saveData(
                          key: CacheKeys.token, value: state.loginModel.token)
                      .whenComplete(() {
                    CacheHelper.saveData(
                            key: CacheKeys.userType,
                            value: state.loginModel.userType.toString())
                        .whenComplete(() {
                      token = CacheHelper.getData(key: CacheKeys.token);
                      userId = CacheHelper.getData(key: CacheKeys.userId);
                      Navigator.pushNamedAndRemoveUntil(context,
                          ScreenName.freelancerMainLayout, (route) => false);
                    });
                  });
                });
              }
            }
            if (state is LoginSuccessButErrorInData) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: state.errorMessage);
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Center(
                    child: Image.asset(
                      ImagePath.authLogo,
                      width: 154.w,
                      height: 154.h,
                    ),
                  ),
                  SizedBox(
                    height: 67.h,
                  ),
                  Text(
                    LocaleKeys.login.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xff262626),
                        fontFamily: FontPath.almaraiBold,
                        fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  PhoneAuthFormField(controller: phone,),
                  SizedBox(
                    height: 10.h,
                  ),
                  AuthTextFormField(
                    hintText: LocaleKeys.password.tr(),
                    controller: password,
                    isPassword: true,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.enter_password.tr();
                      } else if (value.length < 6) {
                        return LocaleKeys.weak_password.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ScreenName.forgetPasswordScreen);
                    },
                    child: Text(
                      LocaleKeys.forget_your_password.tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: const Color(0xffAAADB5),
                          fontFamily: FontPath.almaraiLight,
                          fontSize: 13.sp),
                    ),
                  ),

                  SizedBox(
                    height: 16.h,
                  ),
                  AuthButton(
                      buttonTitle: LocaleKeys.login.tr(),
                      isTapped: () {
                        if (formKey.currentState!.validate()) {
                          cubit.login(
                              phone: phone.text, password: password.text);
                        }
                      },
                      width: double.infinity),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: (){
                        showProgressIndicator(context);
                        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ScreenName.mainSkipLayout);
                        });
                      },
                      child: Text(
                        LocaleKeys.app_overview.tr(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColorsLightTheme.secondaryColor,
                            fontFamily: FontPath.almaraiLight,
                            fontSize: 13.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 57.h,
                  ),
                  InkWell(
                    onTap: () {
                      checkPublish = CacheHelper.getBoolean(key: CacheKeys.checkPublish);
                      if(checkPublish !=null && checkPublish==true){
                        Navigator.pushReplacementNamed(context, ScreenName.userRegister);
                      }else if(checkPublish!=null && checkPublish==false){
                        Navigator.pushReplacementNamed(context, ScreenName.chooseRegisterType);
                      }
                      // Navigator.pushNamed(
                      //     context, ScreenName.chooseRegisterType);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${LocaleKeys.have_account.tr()}  ',
                          style: TextStyle(
                              color: const Color(0xff262626),
                              fontFamily: FontPath.almaraiRegular,
                              fontSize: 10.sp),
                        ),
                        Text(
                          LocaleKeys.create_account.tr(),
                          style: TextStyle(
                            color: AppColorsLightTheme.secondaryColor,
                            fontFamily: FontPath.almaraiRegular,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
