import 'package:app/business_logic/auth/cubit/auth_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/reset_password_screen.dart';
import 'package:app/persentation/screens/home/home_screen.dart';
import 'package:app/persentation/screens/layout/layout_screen.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/lang_widget.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColors.mainColor,
          appBar: AppBar(
            backgroundColor: MyColors.mainColor,
            actions: [
              GestureDetector(
                onTap: () {
                  if (context.locale.languageCode == 'en') {
                    TranslationCubit.get(context).changAppLang(context, 'ar');
                  } else {
                    TranslationCubit.get(context).changAppLang(context, 'en');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    context.locale.languageCode == 'en' ? 'AR' : 'EN',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetsSVG.loginSvg),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      CustomTextFormField(
                        text: 'Phone Number'.tr(),
                        controller: phoneController,
                        borderRadius: BorderRadius.circular(32),
                        borderColor: Colors.white,
                        isFilld: true,
                        color: Colors.white12,
                        hintColor: Colors.white70,
                        textColor: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            AssetsSVG.user,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        text: 'Password'.tr(),
                        controller: passwordController,
                        borderRadius: BorderRadius.circular(32),
                        borderColor: Colors.white,
                        isFilld: true,
                        color: Colors.white12,
                        hintColor: Colors.white70,
                        textColor: Colors.white,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            AssetsSVG.unlock,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      // const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 25, start: 20),
                        child: GestureDetector(
                          onTap: () {
                            MyNavigator.navigateTo(context, ResetPasswordScreen());
                          },
                          child: Text(
                            'Forgot your password?'.tr(),
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Center(
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return AuthCubit.get(context).isLoadingLogin
                            ? CustomButtonLoading(
                                color: MyColors.whiteColor,
                                textColor: MyColors.mainColor,
                                fontSize: 25,
                                height: 57,
                                width: 300,
                                borderRadius: BorderRadius.circular(30),
                              )
                            : CustomButton(
                                onPressed: (phoneController.text.isEmpty || passwordController.text.isEmpty)
                                    ? null
                                    : () {
                                        AuthCubit.get(context).login(
                                          context: context,
                                          phone: phoneController.text,
                                          password: passwordController.text,
                                        );
                                      },
                                text: 'Login'.tr(),
                                color: MyColors.whiteColor,
                                textColor: MyColors.mainColor,
                                fontSize: 17,
                                height: 57,
                                width: 300,
                                borderRadius: BorderRadius.circular(30),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
