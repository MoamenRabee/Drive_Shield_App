import 'package:app/business_logic/reset_password/cubit/reset_password_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/pin_code_screen.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/lang_widget.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import 'package:gif_view/gif_view.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: MyColors.scaffoldColor,
        leading: IconButton(
          onPressed: () {
            MyNavigator.back(context);
          },
          icon: Transform.flip(
            flipX: context.locale.languageCode == 'ar' ? true : false,
            child: SvgPicture.asset(
              AssetsSVG.next,
              color: MyColors.mainColor,
            ),
          ),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GifView.asset(
                'assets/images/03.gif',
                height: 200,
                width: 300,
                frameRate: 30,
                repeat: ImageRepeat.noRepeat,
              ),
              const SizedBox(height: 10),
              Text(
                'Set password'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                text: 'Phone Number'.tr(),
                controller: phoneController,
                borderRadius: BorderRadius.circular(32),
                borderColor: Colors.grey,
                isFilld: true,
                color: MyColors.scaffoldColor,
                hintColor: Colors.grey,
                textColor: Colors.grey,
                prefixIcon: context.locale.languageCode == 'ar'
                    ? Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          AssetsSVG.user,
                          color: Colors.black,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                AssetsSVG.user,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                '+966',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                onChanged: (val) {
                  setState(() {});
                },
                suffixIcon: context.locale.languageCode == 'en'
                    ? null
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Text(
                            '+966',
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              Center(
                child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  builder: (context, state) {
                    return ResetPasswordCubit.get(context).isLoading
                        ? CustomButtonLoading(
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
                            fontSize: 25,
                            height: 57,
                            width: 300,
                            borderRadius: BorderRadius.circular(30),
                          )
                        : CustomButton(
                            onPressed: (phoneController.text.isEmpty)
                                ? null
                                : () async {
                                    await ResetPasswordCubit.get(context).sendOTPMessage(context: context, phone: phoneController.text);
                                  },
                            text: 'Send'.tr(),
                            color: MyColors.mainColor,
                            textColor: MyColors.whiteColor,
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
  }
}
