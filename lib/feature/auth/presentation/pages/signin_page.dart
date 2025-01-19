import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widget/auth_button.dart';
import '../widget/auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In.",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 15,
            ),
            AuthField(
              hintText: "Email",
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            AuthField(
              hintText: "Password",
              controller: passwordController,
              isObscureTxt: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const AuthButton(
              text: "Sign In",
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.toNamed("signup");
                },
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppPallete.gradient2))
                      ]),
                )),
          ],
        ),
      ),
    ));
  }
}
