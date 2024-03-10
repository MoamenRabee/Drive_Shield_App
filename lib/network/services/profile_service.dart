import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/models/user/user_model.dart';
import 'package:app/network/dio_helper.dart';
import 'package:dio/dio.dart';

class ProfileServices {
  static Future<UserModel?> getProfile() async {
    try {
      var result = await DioHelper.get(path: EndPoints.profile);

      if (result.statusCode == 200) {
        log('Get Profile Success');
        return UserModel.fromJson(result.data['data']['user']);
      } else {
        log('Unable To Get Profile');
      }
    } catch (e) {
      log('$e');
    }
    return null;
  }

  static Future<Response?> updatePassword({
    required String phone,
    required String password,
  }) async {
    try {
      var result = await DioHelper.put(
        path: EndPoints.profile,
        data: {
          "phone_number": phone,
          "password": password,
          "password_confirmation": password,
        },
      );

      if (result.statusCode == 200) {
        log('Update Profile Success');
      } else {
        log('${result.data['data']}');
        log('Unable To Update Profile');
      }
      return result;
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
