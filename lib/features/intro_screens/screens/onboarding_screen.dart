import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/core/app_theme/light_theme.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import 'package:touch_of_beauty/features/intro_screens/widgets/boarding_button.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/cache_manager/cache_keys.dart';
import '../../../core/cache_manager/shared_preferences.dart';
import '../widgets/images_widget.dart';
import '../widgets/onboarding_class.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageViewController = PageController();
  bool isLast = false;
  List<OnboardingModel> boarding = [
    OnboardingModel(
        backGround: ImagePath.onboarding1,
        title: 'Beauty Touch',
        bodyTitle: 'تطبيق بيوتي تاتش وجهتكِ لعالم من خلاله تعيشِ في جنة من الجمال خصص ليكون بين يديك .'),
    OnboardingModel(
        backGround: ImagePath.onboarding2,
        title: '',
        bodyTitle: 'أحصلي على تطبيق متكامل وأبدئي معنا انطلاقتك بالعمل وحققي ربح و دخل أكبر .'),
    OnboardingModel(
        backGround: ImagePath.onboarding3,
        title: '',
        bodyTitle: 'تعالي نعرفك على خدماتنا يا اميرة و نبدأ معك برحلة من الجمال .')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLightTheme.primaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
              controller: pageViewController,
              itemCount: boarding.length,
              itemBuilder: (BuildContext context, int index) {
                return ImagesWidget(
                  model: boarding[index],
                );
              },
              onPageChanged: (index) {
                if (index == 2 && !isLast) {
                  setState(() {
                    isLast = true;
                  });
                }
                if (index == 1 || index == 0 && isLast) {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          Positioned(
            bottom: 256.h,
            left: 156.w,
            right: 158.w,
            child: SmoothPageIndicator(
              controller: pageViewController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  expansionFactor: 3,
                  spacing: 5.w,
                  activeDotColor: AppColorsLightTheme.secondaryColor,
                  dotColor: AppColorsLightTheme.smoothPageIndicatorGreyColor),
            ),
          ),
          Positioned(
            bottom: 141.h,
            // left: !isLast?157.w:112.w,
            right: !isLast ? 158.w : 114.w,
            child: CustomButton(
              isLast: isLast,
              isLastTap: () {
                checkPublish = CacheHelper.getBoolean(key: CacheKeys.checkPublish);
                CacheHelper.saveData(key: CacheKeys.onboarding, value: true).whenComplete((){
                  if(checkPublish !=null && checkPublish==true){
                    Navigator.pushReplacementNamed(context, ScreenName.userRegister);
                  }else if(checkPublish!=null && checkPublish==false){
                    Navigator.pushReplacementNamed(context, ScreenName.chooseRegisterType);
                  }
                });
              },
              isTapped: () {
                pageViewController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
              },
            ),
          )
        ],
      ),
    );
  }
}
