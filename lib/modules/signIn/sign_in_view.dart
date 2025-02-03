import 'package:evently_app_c13_mon_7pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/extensions/validations.dart';
import '../../core/services/firebase_auth_service.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.eventlyLogo,
                  height: mediaQuery.size.height * 0.2,
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.05,
                ),
                CustomTextField(
                  controller: _emailController,
                  hint: "Email",
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: ImageIcon(
                    AssetImage(
                      AppAssets.mailIcn,
                    ),
                    color: ColorPalette.generalGreyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your email address";
                    }
                    if (!Validations.validateEmail(value)) {
                      return "please enter your a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                CustomTextField(
                  controller: _passwordController,
                  isPassword: true,
                  maxLines: 1,
                  hint: "Password",
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: ImageIcon(
                    AssetImage(
                      AppAssets.lockIcn,
                    ),
                    color: ColorPalette.generalGreyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your password";
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.01,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Forget Password?"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuthService.signIn(
                        _emailController.text,
                        _passwordController.text,
                      ).then(
                        (value) {
                          EasyLoading.dismiss();
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRoutesName.layout,
                              (route) => false,
                            );
                          }
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorPalette.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      )),
                  child: Text(
                    "Login",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t Have Account ? ",
                        style: theme.textTheme.titleMedium,
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageRoutesName.signUp);
                          },
                          child: Text(
                            "Create Account",
                            style: theme.textTheme.titleMedium?.copyWith(
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorPalette.primaryColor,
                                decorationThickness: 1.2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                    Text(
                      "OR",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 0,
                    backgroundColor: ColorPalette.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.googleIcn,
                        height: mediaQuery.size.height * 0.03,
                      ),
                      SizedBox(
                        width: mediaQuery.size.height * 0.01,
                      ),
                      Text(
                        "Login With Google",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
