import 'package:evently_app_c13_mon_7pm/core/extensions/validations.dart';
import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:evently_app_c13_mon_7pm/core/utils/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/color_palette.dart';
import '../../core/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
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
                  controller: _nameController,
                  hint: "Name",
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AppAssets.personIcn,
                    ),
                    color: ColorPalette.generalGreyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                CustomTextField(
                  controller: _emailController,
                  hint: "Email",
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: const ImageIcon(
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
                  hint: "Password",
                  isPassword: true,
                  maxLines: 1,
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AppAssets.lockIcn,
                    ),
                    color: ColorPalette.generalGreyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your password";
                    }
                    if (!Validations.validatePassword(value)) {
                      return "please enter your a valid password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.02,
                ),
                CustomTextField(
                  isPassword: true,
                  maxLines: 1,
                  hint: "Re-Password",
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AppAssets.lockIcn,
                    ),
                    color: ColorPalette.generalGreyColor,
                  ),
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter your password";
                    }
                    if (value != _passwordController.text) {
                      return "re-password not matched ";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseServices.signUp(
                        _emailController.text,
                        _passwordController.text,
                      ).then(
                        (value) {
                          EasyLoading.dismiss();
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRoutesName.signIn,
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
                    "Register",
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
                        text: "Already Have Account ? ",
                        style: theme.textTheme.titleMedium,
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
