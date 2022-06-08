import 'package:get/get.dart';

import '../views/allusers/allusers.dart';
import '../views/forgot_pass/screen/forgot_password_screen.dart';
import '../views/login/components/login_success_screen.dart';
import '../views/onBoarding/screen/onboarding_screen.dart';
import '../views/profile/waiting_screen.dart';
import '../views/profile_completion/screens/business_profile_completion.dart';
import '../views/profile_completion/screens/personal_profile_completion.dart';
import '../views/register/components/register_success_screen.dart';
import '../views/splash/splash_screen.dart';
import '../widgets/auth_toggle_view.dart';

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
        page: () => const WaitingScreen(),
        transition: Transition.fadeIn),
    // GetPage(
    //     name: '/searchView',
    //     page: () => const SearchMemberScreen(),
    //     transition: Transition.fadeIn),
    GetPage(name: '/allUsers', page: () => const AllUsers()),
  ];
}
