import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';

import '../../../../../core/assets_path/font_path.dart';
import '../../../../../core/assets_path/svg_path.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  const CustomTextFormField({Key? key, required this.controller, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10.w,),
      decoration: BoxDecoration(
        color: AppColorsLightTheme.authTextFieldFillColor,
        borderRadius: BorderRadius.circular(8.r)
      ),
      child: TextFormField(
        controller: controller,
        expands: true,
        maxLines: null,
        minLines: null,
        textAlign: TextAlign.start,
        style: TextStyle(
          height: 1.3.h,
          fontSize: 12.sp,
          fontFamily: FontPath.almaraiRegular,
          color: const Color(0xff8B8989),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffix: SvgPicture.asset(
            SvgPath.edit,
            width: 22.w,
            height: 22.h,
            color: Colors.grey,
          )
        ),
      ),
    );
  }
}