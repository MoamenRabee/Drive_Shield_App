import 'dart:developer';

import 'package:app/network/services/profile_service.dart';
import 'package:app/persentation/screens/auth/login_screen.dart';
import 'package:app/persentation/screens/auth/pin_code_screen.dart';
import 'package:app/persentation/screens/auth/reset_change_password_screen.dart';
import 'package:app/persentation/screens/profile/change_password_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/constants/api_constants.dart';
import '../../../data/constants/constants.dart';
import '../../../functions/functions.dart';
import '../../../functions/my_navigation.dart';
import '../../../network/dio_helper.dart';
import '../../../theme/colors.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit get(BuildContext context) => BlocProvider.of(context);

  bool isCodeSent = false;
  bool isLoading = false;
  String myVerificationId = "";

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  void showPassword1() {
    isPasswordVisible = !isPasswordVisible;
    emit(ShowPasswordState());
  }

  void showPassword2() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ShowPasswordState());
  }

  Future<void> sendOTPMessage({
    required BuildContext context,
    required String phone,
  }) async {
    isLoading = true;
    emit(ResetPasswordLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${'+966'}$phone',
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException e) {
        showMessage(context: context, message: e.code);
        if (e.code == 'invalid-phone-number') {
          showMessage(
            context: context,
            message: "Phone number is incorrect".tr(),
            color: MyColors.redColor,
          );
        } else if (e.code == 'invalid-verification-code') {
          showMessage(
            context: context,
            message: "The confirmation code is incorrect".tr(),
            color: MyColors.redColor,
          );
        } else if (e.code == 'missing-client-identifier') {
          showMessage(
            context: context,
            message: "Unkown error".tr(),
            color: MyColors.redColor,
          );
        } else {
          log(e.toString());
          showMessage(
            context: context,
            message: e.toString(),
            color: Colors.red,
          );
        }
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) {
        myVerificationId = verificationId;
        isLoading = false;

        emit(ResetPasswordSuccess());
        MyNavigator.navigateOff(context, PinCodeScreen(phone: phone));
        isCodeSent = true;
        log("Code Sent");
      },
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void codeAutoRetrievalTimeout(String verificationId) async {
    log("CodeAutoRetrievalTimeout");
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    log("verificationCompleted");
  }

  Future<void> confirmPhoneNumberAndResetPassword({
    required BuildContext context,
    required String code,
    required String phone,
  }) async {
    isLoading = true;
    emit(ResetPasswordLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: myVerificationId,
        smsCode: code,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        MyNavigator.navigateTo(context, ResetChangePasswordScreen(phone: phone));
        isCodeSent = false;
      });
      isLoading = false;
      emit(ResetPasswordSuccess());
    } catch (e) {
      if (e.toString().startsWith("[firebase_auth/invalid-phone-number]")) {
        // ignore: use_build_context_synchronously
        showMessage(
          context: context,
          message: "Phone number is incorrect".tr(),
          color: MyColors.redColor,
        );
      } else if (e.toString().startsWith("[firebase_auth/invalid-verification-code]")) {
        // ignore: use_build_context_synchronously
        showMessage(
          context: context,
          message: "The confirmation code is incorrect".tr(),
          color: MyColors.redColor,
        );
      } else {
        log(e.toString());
        // ignore: use_build_context_synchronously
        showMessage(context: context, message: e.toString(), color: Colors.red);
      }
      isLoading = false;
      emit(ResetPasswordError());
    }
  }

  Future<void> changePassword({
    required String phone,
    required String password1,
    required String password2,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(ResetPasswordLoading());
    try {
      await ProfileServices.updatePassword(
        phone: phone,
        password: password2,
      ).then((response) {
        if (response?.statusCode == 200) {
          MyNavigator.navigateOffAll(context, LoginScreen());
          showMessage(
            context: context,
            message: response!.data["msg"],
            color: Colors.green,
          );
        } else {
          showMessage(
            context: context,
            message: response!.data["msg"],
            color: Colors.red,
          );
        }
      });

      isLoading = false;
      emit(ResetPasswordSuccess());
    } catch (e) {
      isLoading = false;
      emit(ResetPasswordError());
    }
  }
}
