import 'dart:developer';
import 'dart:io';

import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/network/services/profile_service.dart';
import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingProfile = false;
  bool isLoading = false;
  bool isLoadingUpdate = false;
  bool isLoadingChangeNotifications = false;
  bool isLoadingChangePassword = false;

  UserModel? userModel;

  Future<void> getProfile() async {
    isLoadingProfile = true;
    emit(GetProfileLoading());
    try {
      userModel = await ProfileServices.getProfile();

      isLoadingProfile = false;
      emit(GetProfileSuccess());
    } catch (e) {
      isLoadingProfile = false;
      emit(GetProfileError());
      log('$e');
    }
  }

  Future<void> changePassword(String password, BuildContext context) async {
    isLoadingChangePassword = true;
    emit(ChangePasswordLoading());
    try {
      Response? response = await ProfileServices.updatePassword(
        phone: userModel!.phoneNumber,
        password: password,
      );

      if (response?.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showMessage(context: context, message: '${response?.data['msg']}', color: Colors.green);

        // ignore: use_build_context_synchronously
        await getProfile();

        // ignore: use_build_context_synchronously
        MyNavigator.back(context);
      }

      isLoadingChangePassword = false;
      emit(ChangePasswordSuccess());
    } catch (e) {
      isLoadingChangePassword = false;
      log(e.toString());
      emit(ChangePasswordError());
    }
  }
}
