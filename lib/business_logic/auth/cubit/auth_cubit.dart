import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/cache_helper.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/network/dio_helper.dart';
import 'package:app/persentation/screens/auth/login_screen.dart';
import 'package:app/persentation/screens/layout/layout_screen.dart';
import 'package:app/theme/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingLogin = false;
  bool isLoadingSignOut = false;

  Future<void> login({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    isLoadingLogin = true;
    emit(LoginLoading());
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      String? token = await messaging.getToken();

      Response response = await DioHelper.post(
        path: EndPoints.login,
        data: {
          "phone_number": phone,
          "password": password,
          "device_token": token,
        },
      );

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data["data"]["user"]);

        log("${userModel}");

        await CacheHelper.setString(
          key: "access_token",
          value: response.data["data"]["token"],
        );

        DioHelper.init();

        // ignore: use_build_context_synchronously
        MyNavigator.navigateOff(context, const LayoutScreen());

        // ignore: use_build_context_synchronously
        showMessage(
          context: context,
          message: response.data["msg"],
          color: Colors.green,
        );
      } else {
        // ignore: use_build_context_synchronously
        showMessage(
          context: context,
          message: response.data["msg"].toString(),
          color: MyColors.redColor,
        );
      }

      isLoadingLogin = false;
      emit(LoginSuccess());
    } catch (e) {
      log("$e");
      isLoadingLogin = false;
      emit(LoginError());
    }
  }

  void signOut(BuildContext context) async {
    isLoadingSignOut = true;
    emit(SignoutState());

    // ignore: use_build_context_synchronously
    // ProfileCubit.get(context).userModel = null;

    CacheHelper.removeKey(key: "access_token");
    DioHelper.init();

    isLoadingSignOut = false;
    emit(SignoutState());

    // ignore: use_build_context_synchronously
    MyNavigator.navigateOffAll(context, LoginScreen());
  }
}
