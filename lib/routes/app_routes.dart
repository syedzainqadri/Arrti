import 'package:apni_mandi/views/forgot_pass/screen/forgot_password_screen.dart';
import 'package:apni_mandi/views/login/components/login_success_screen.dart';
import 'package:apni_mandi/views/onBoarding/screen/onboarding_screen.dart';
import 'package:apni_mandi/views/profile_completion/screens/business_profile_completion.dart';
import 'package:apni_mandi/views/profile_completion/screens/personal_profile_completion.dart';
import 'package:apni_mandi/views/register/components/register_success_screen.dart';
import 'package:apni_mandi/views/search_member/screen/search_member_screen.dart';
import 'package:apni_mandi/views/splash/splash_screen.dart';
import 'package:apni_mandi/widgets/auth_toggle_view.dart';
import 'package:apni_mandi/widgets/waiting_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(
        name: '/onBoarding',
        page: () => const OnboardingScreen(),
        transition: Transition.zoom),
    GetPage(
        name: '/forgotPass',
        page: () => ForgotPasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(name: '/signupSuccess', page: () => const RegisterSuccessScreen()),
    GetPage(name: '/signinSuccess', page: () => const LoginSuccessScreen()),
    GetPage(name: '/personalPC', page: () => const PersonalProfileCompletion()),
    GetPage(name: '/businessPC', page: () => const BusinessProfileCompletion()),
    GetPage(name: '/authView', page: () => const AuthToggleView()),
    GetPage(
        name: '/waitingView',
        page: () => WaitingScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: '/searchView',
        page: () => const SearchMemberScreen(),
        transition: Transition.fadeIn),
  ];
}
