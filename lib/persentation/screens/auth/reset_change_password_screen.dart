import 'package:app/business_logic/reset_password/cubit/reset_password_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/reset_password_screen.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/lang_widget.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';

class ResetChangePasswordScreen extends StatefulWidget {
  ResetChangePasswordScreen({super.key, required this.phone});

  final String phone;

  @override
  State<ResetChangePasswordScreen> createState() => _ResetChangePasswordScreenState();
}

class _ResetChangePasswordScreenState extends State<ResetChangePasswordScreen> {
  TextEditingController password1Controller = TextEditingController();

  TextEditingController password2Controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  text: 'New Password'.tr(),
                  controller: password1Controller,
                  borderRadius: BorderRadius.circular(32),
                  borderColor: Colors.grey,
                  isFilld: true,
                  color: MyColors.scaffoldColor,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  onChanged: (val) {
                    setState(() {});
                  },
                  validator: (val) {
                    if (val!.isEmpty || val.length < 8) {
                      return 'Please enter a password of 8 characters'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  text: 'Confirm Password'.tr(),
                  controller: password2Controller,
                  borderRadius: BorderRadius.circular(32),
                  borderColor: Colors.grey,
                  isFilld: true,
                  color: MyColors.scaffoldColor,
                  hintColor: Colors.black,
                  textColor: Colors.black,
                  onChanged: (val) {
                    setState(() {});
                  },
                  validator: (val) {
                    if (val!.isEmpty || val.length < 8) {
                      return 'Please enter a password of 8 characters'.tr();
                    }
                    if (val != password1Controller.text) {
                      return 'The two passwords are not the same'.tr();
                    }
                    return null;
                  },
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
                              height: 50,
                              width: 300,
                              borderRadius: BorderRadius.circular(11),
                            )
                          : CustomButton(
                              onPressed: (password1Controller.text.isEmpty || password2Controller.text.isEmpty)
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        await ResetPasswordCubit.get(context).changePassword(
                                          phone: widget.phone,
                                          password1: password1Controller.text,
                                          password2: password2Controller.text,
                                          context: context,
                                        );
                                      }
                                    },
                              text: 'Change'.tr(),
                              color: MyColors.mainColor,
                              textColor: MyColors.whiteColor,
                              fontSize: 25,
                              height: 50,
                              width: 300,
                              borderRadius: BorderRadius.circular(11),
                            );
                    },
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
