import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/core/assets_path/images_path.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import 'package:touch_of_beauty/features/authentication/buisness_logic/auth_cubit.dart';
import 'package:touch_of_beauty/features/authentication/buisness_logic/auth_state.dart';
import '../../../../core/assets_path/font_path.dart';
import '../../../../core/assets_path/svg_path.dart';
import '../../../../core/cache_manager/cache_keys.dart';
import '../../../../core/cache_manager/shared_preferences.dart';
import '../widgets/auht_text_form_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/pin_field_builder.dart';


class OtpArgs{
  final dynamic phoneNumber;
  final bool isConfirmPassword;

  OtpArgs({required this.phoneNumber, this.isConfirmPassword = false});
}

class OtpScreen extends StatefulWidget {
  final dynamic phoneNumber;
  final bool isConfirmPassword;
  const OtpScreen({Key? key, this.phoneNumber, required this.isConfirmPassword}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinController = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    phone.text = widget.phoneNumber!=null?widget.phoneNumber.toString():'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          var cubit = AuthCubit.get(context);
          if(state is ConfirmRegisterLoading){
            showProgressIndicator(context);
          }
          if(state is ConfirmRegisterSuccess){
            Navigator.pop(context);
            if(cubit.mainResponse.errorCode==0){
              Fluttertoast.showToast(msg: cubit.mainResponse.errorMessage);
              Navigator.pushReplacementNamed(context, ScreenName.loginScreen);
            }else{
              Fluttertoast.showToast(msg: cubit.mainResponse.errorMessage);
            }
          }
          if(state is ConfirmForgetPasswordLoading){
            showProgressIndicator(context);
          }
          if(state is ConfirmForgetPasswordSuccess){
            Navigator.pop(context);
            Fluttertoast.showToast(msg: cubit.mainResponse.errorMessage);
            if(cubit.mainResponse.errorCode ==0&&state.confirmForgetPasswordModel.userType==1){
              CacheHelper.saveData(key: CacheKeys.token, value: state.confirmForgetPasswordModel.token).whenComplete(() {
                CacheHelper.saveData(key: CacheKeys.userType, value: state.confirmForgetPasswordModel.userType.toString()).whenComplete(() {
                  token = CacheHelper.getData(key: CacheKeys.token);
                  Navigator.pushNamedAndRemoveUntil(context, ScreenName.userMainLayout, (route) => false);
                });
              });
            }else if(cubit.mainResponse.errorCode ==0&&state.confirmForgetPasswordModel.userType==2){
              CacheHelper.saveData(key: CacheKeys.token, value: state.confirmForgetPasswordModel.token).whenComplete(() {
                CacheHelper.saveData(key: CacheKeys.userType, value: state.confirmForgetPasswordModel.userType.toString()).whenComplete(() {
                  token = CacheHelper.getData(key: CacheKeys.token);
                  Navigator.pushNamedAndRemoveUntil(context, ScreenName.vendorMainLayout, (route) => false);
                });
              });
            }else if(cubit.mainResponse.errorCode ==0&&state.confirmForgetPasswordModel.userType==3){
              CacheHelper.saveData(key: CacheKeys.token, value: state.confirmForgetPasswordModel.token).whenComplete(() {
                CacheHelper.saveData(key: CacheKeys.userType, value: state.confirmForgetPasswordModel.userType.toString()).whenComplete(() {
                  token = CacheHelper.getData(key: CacheKeys.token);
                  Navigator.pushNamedAndRemoveUntil(context, ScreenName.freelancerMainLayout, (route) => false);
                });
              });
            }
          }
          if(state is ConfirmForgetPasswordSuccessButErrorInData){
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.errorMessage);
          }
          if(state is ConfirmForgetPasswordError){
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.error);
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 25.w),
                        child: Image.asset(
                          ImagePath.phoneLogo,
                          width: 206.w,
                          height: 221.h,
                        ),
                      ),),
                  SizedBox(
                    height: 55.h,
                  ),
                  Text(
                    'تأكيد رقم الهاتف',
                    style: TextStyle(
                        color: const Color(0xff262626),
                        fontFamily: FontPath.almaraiBold,
                        fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120.w),
                    child: Text(
                      'لقد أرسلنا كود تفعيلي من رقم 4 ارقام على الهاتف الخاص بك',
                      style: TextStyle(
                          height: 1.8.h,
                          color: const Color(0xffABABAB),
                          fontFamily: FontPath.almaraiRegular,
                          fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  AuthTextFormField(
                    hintText: 'رقم الهاتف',
                    maxLength: 20,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل رقم الهاتف';
                      } else if (value.length < 9) {
                        return 'لا يحب ان يقل الرقم عن 10 ارقام';
                      }
                      return null;
                    },
                    suffix: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: SvgPicture.asset(
                        SvgPath.saudiPhoneFieldIcon,
                        width: 52.w,
                        height: 15.h,
                      ),
                    ),
                    controller: phone,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinFieldBuilder(
                      controller: pinController,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AuthButton(
                      buttonTitle: 'تأكيد الرقم',
                      isTapped: () {
                        if(!widget.isConfirmPassword){
                          cubit.confirmRegister(phone: phone.text, randomCode: pinController.text);
                        }else if(widget.isConfirmPassword){
                          cubit.confirmPassword(phone: phone.text, randomCode: pinController.text);
                        }
                      },
                      width: double.infinity),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
