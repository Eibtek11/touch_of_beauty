import 'package:flutter/material.dart';
import 'package:touch_of_beauty/core/app_router/screens_name.dart';
import 'package:touch_of_beauty/features/authentication/presentation/screens/choose_type_screen.dart';
import 'package:touch_of_beauty/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:touch_of_beauty/features/authentication/presentation/screens/login_screen.dart';
import 'package:touch_of_beauty/features/authentication/presentation/screens/otp_screen.dart';
import 'package:touch_of_beauty/features/authentication/presentation/screens/user_register.dart';
import 'package:touch_of_beauty/features/intro_screens/screens/onboarding_screen.dart';
import 'package:touch_of_beauty/features/intro_screens/screens/splash_screen.dart';
import 'package:touch_of_beauty/features/user/presentation/screens/favorites_services_screen.dart';
import 'package:touch_of_beauty/features/user/presentation/screens/home_screen_screens/search_screen.dart';
import 'package:touch_of_beauty/features/user/presentation/screens/user_main_layout.dart';
import '../../features/authentication/presentation/screens/change_forget_password.dart';
import '../../features/authentication/presentation/screens/vendor_register.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/freelancer/presentation/screens/freelance_main_layout.dart';
import '../../features/freelancer/presentation/screens/freelancer_center_screens/edit_freelancer_details.dart';
import '../../features/freelancer/presentation/screens/freelancer_center_screens/freelancer_details_screen.dart';
import '../../features/freelancer/presentation/screens/freelancer_center_screens/freelancer_services_screen.dart';
import '../../features/freelancer/presentation/screens/freelancer_center_screens/freelancer_working_time_screen.dart';
import '../../features/freelancer/presentation/screens/freelancer_notification_screen.dart';
import '../../features/intro_screens/screens/check_publish_screen.dart';
import '../../features/skip_layout/main_skip_layout.dart';
import '../../features/user/presentation/screens/edit_profile_screen.dart';
import '../../features/user/presentation/screens/help_privacy_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/all_centers_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/all_questions_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/filter_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/main_featuers_services.dart';
import '../../features/user/presentation/screens/home_screen_screens/complains_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/gallery_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/order_screens/add_address_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/order_screens/choose_address_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/order_screens/payment_web_view.dart';
import '../../features/user/presentation/screens/home_screen_screens/order_screens/reserve_order_screen.dart';
import '../../features/user/presentation/screens/home_screen_screens/our_services_screen.dart';
import '../../features/user/presentation/screens/privacy_and_policy.dart';
import '../../features/vendor/presentation/screens/order_screens/home_orders_details_screen.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/add_services_screen.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/center_details_screen.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/center_working_time_screen.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/edit_center_details.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/vendor_reservations_screen.dart';
import '../../features/vendor/presentation/screens/vendor_center_screens/vendor_services_screen.dart';
import '../../features/vendor/presentation/screens/vendor_main_layout.dart';
import '../../features/vendor/presentation/screens/vendor_notification_screen.dart';



class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case ScreenName.splashscreen:
          return MaterialPageRoute(builder: (BuildContext context) { return const SplashScreen(); });
        case ScreenName.userMainLayout:
          return MaterialPageRoute(builder: (BuildContext context) { return const UserMainLayout(); });
        case ScreenName.vendorMainLayout:
          return MaterialPageRoute(builder: (BuildContext context) { return const VendorMainLayout(); });
        case ScreenName.checkPublishScreen:
          return MaterialPageRoute(builder: (BuildContext context) { return const CheckPublishScreen(); });
        case ScreenName.freelancerMainLayout:
          return MaterialPageRoute(builder: (BuildContext context) { return const FreelancerMainLayout(); });
        case ScreenName.onboardingScreen:
          return MaterialPageRoute(builder: (BuildContext context) { return const OnboardingScreen(); });
        case ScreenName.chooseRegisterType:
          return _animateRouteBuilder(const ChooseTypeScreen());
        case ScreenName.orderInHomeDetailsScreen:
          return _animateRouteBuilder(const HomeOrderDetailsScreen());
        case ScreenName.vendorNotificationScreen:
          return _animateRouteBuilder(const VendorNotificationScreen());
        case ScreenName.allQuestionsScreen:
          return _animateRouteBuilder(const AllQuestionsScreen());
        case ScreenName.freelancerNotificationScreen:
          return _animateRouteBuilder(const FreelancerNotificationScreen());
        case ScreenName.userCategoryDetailsScreen:
          final arg = settings.arguments;
          MainFeatureServicesArgs arguments = arg as MainFeatureServicesArgs;
          return _animateRouteBuilder(CategoryDetailsScreen(title: arguments.title,mainFeatureId:arguments.mainFeatureId));
        case ScreenName.userSearchScreen:
          final arg = settings.arguments;
          return _animateRouteBuilder( SearchScreen(servicesProviderId: arg,));
        case ScreenName.editCenterScreen:
          return _animateRouteBuilder( const EditCenterDetailsScreen());
        case ScreenName.filteredServicesScreen:
          return _animateRouteBuilder( const FilteredServicesScreen());
        case ScreenName.freelancerDetailsScreen:
          return _animateRouteBuilder( const FreelancerDetailsScreen());
        case ScreenName.helpPrivacy:
          return _animateRouteBuilder( const HelpAnpPrivacyScreen());
        case ScreenName.privacyScreen:
          return _animateRouteBuilder( const PrivacyAndPolicy());
        case ScreenName.freelancerEditDetailsScreen:
          return _animateRouteBuilder( EditFreelancerDetailsScreen());
        case ScreenName.freelancerTimeScreen:
          return _animateRouteBuilder( const FreelancerWorkingTimeScreen());
        case ScreenName.vendorServicesScreen:
          return _animateRouteBuilder( const VendorServicesScreen());
        case ScreenName.freelancerServicesScreen:
          return _animateRouteBuilder( const FreelancerServicesScreen());
        case ScreenName.mainSkipLayout:
          return _animateRouteBuilder( const MainSkipLayout());
        case ScreenName.vendorReservationsScreen:
          return _animateRouteBuilder( const VendorReservationsScreen());
        case ScreenName.vendorAddToServicesScreen:
          final args = settings.arguments;
          AddToServicesArguments arguments = args as AddToServicesArguments;
          return _animateRouteBuilder(AddServicesScreen(type: arguments.type,servicesModel: arguments.servicesModel,));
        case ScreenName.centerWorkingTimeScreen:
          return _animateRouteBuilder( const CenterWorkingTimeScreen());
        case ScreenName.detailsCenterScreen:
          return _animateRouteBuilder( const CenterDetailsScreen());
        case ScreenName.loginScreen:
          return _animateRouteBuilder(const LoginScreen());
        case ScreenName.favoritesServicesScreen:
          return _animateRouteBuilder(const FavoritesServicesScreen());
        case ScreenName.userRegister:
          return _animateRouteBuilder(const UserRegisterScreen());
        case ScreenName.vendorRegister:
          return _animateRouteBuilder(const VendorRegisterScreen());
        case ScreenName.changeForgetPasswordScreen:
          return _animateRouteBuilder(const ChangeForgetPasswordScreen());
        case ScreenName.otpScreen:
          final args = settings.arguments;
          OtpArgs arguments = args as OtpArgs;
          return _animateRouteBuilder( OtpScreen(phoneNumber: arguments.phoneNumber, isConfirmPassword: arguments.isConfirmPassword,));
        case ScreenName.addAddressScreen:
          final args = settings.arguments ;
          final AddAddressArgs arg = args as AddAddressArgs;
          return _animateRouteBuilder(AddAddressScreen(userEqualsZeroVendorEqualsOne: arg.userEqualsZeroVendorEqualsOne!,addressModel: arg.addressModel,));
        case ScreenName.editProfileScreen:
          return _animateRouteBuilder(const EditProfileScreen());
        case ScreenName.chooseAddressScreen:
          return _animateRouteBuilder(const ChooseAddressScreen());
        case ScreenName.reserveOrderScreen:
          final args = settings.arguments;
          ReserveOrderScreenArguments arguments = args as ReserveOrderScreenArguments;
          return _animateRouteBuilder(ReserveOrderScreen(servicesModel: arguments.servicesModel, isFav: arguments.isFav,isBottomSheet: arguments.isBottomSheet,));
        case ScreenName.allCentersScreen:
          return _animateRouteBuilder(const AllCentersScreen());
        case ScreenName.ourServicesScreen:
          final args = settings.arguments;
          return _animateRouteBuilder(OurServicesScreen(id:args));
        case ScreenName.paymentWebView:
          final args = settings.arguments;
          String arguments = args as String;
          return _animateRouteBuilder(PaymentWebView(url:arguments));
        case ScreenName.complainsScreen:
          return _animateRouteBuilder(const ComplainsScreen());
        case ScreenName.galleryScreen:
          final arg = settings.arguments;
          return _animateRouteBuilder(GalleryScreen(galleryList: arg,));
        case ScreenName.chatScreen:
          final args = settings.arguments;
          ChatScreenArgs arguments = args as ChatScreenArgs;
          return _animateRouteBuilder(ChatScreen(title: arguments.title, receiverId: arguments.receiverId,receiverImg: arguments.receiverImg,receiverName: arguments.receiverName,));
        case ScreenName.forgetPasswordScreen:
          return _animateRouteBuilder(const ForgetPasswordScreen());
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static PageRouteBuilder _animateRouteBuilder(Widget to, {double x = 1, double y = 0}) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => to,
      transitionDuration: const Duration(milliseconds: 190),
      reverseTransitionDuration: const Duration(milliseconds: 190),
      transitionsBuilder: (context, animation, animationTime, child) {
        final tween = Tween<Offset>(begin: Offset(x, y), end: Offset.zero);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('خطأ'),
        ),
        body: const Center(
          child: Text('نعتذر حدث خطأ , الرجاء اعادة المحاولة'),
        ),
      );
    });
  }

}