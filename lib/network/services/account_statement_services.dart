import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/models/account_statement_model/account_statement_model.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/network/dio_helper.dart';
import 'package:dio/dio.dart';

class AccountStatementServices {
  static String endPoint = EndPoints.accountStatement;
  static List<AccountStatementModel> data = [];
  static Future<List<AccountStatementModel>> getData(Map<String, dynamic>? queryParameters) async {
    data.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 10000});
      var result = await DioHelper.get(path: endPoint, queryParameters: queryParameters);
      DioHelper.dio.options.headers.remove('per_page');
      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          data.add(AccountStatementModel.fromJson(element));
        }
        return data;
      } else {
        log('Unable To Get $endPoint');
      }
    } catch (e) {
      log('$e');
    }
    return data;
  }
}
