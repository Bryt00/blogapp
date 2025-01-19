import 'package:blogapp/feature/auth/presentation/pages/signin_page.dart';
import 'package:blogapp/feature/auth/presentation/pages/signup_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

List<GetPage<dynamic>> screens = [
  GetPage(
      name: "/signup",
      page: () => const SignUpPage(),
      transition: Transition.rightToLeftWithFade),
  GetPage(
      name: "/signin",
      page: () => const SignInPage(),
      transition: Transition.rightToLeftWithFade),
];
