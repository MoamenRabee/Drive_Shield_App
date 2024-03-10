import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/network/dio_helper.dart';
import 'package:dio/dio.dart';

class InVoiceServices {
  static String endPoint = EndPoints.invoices;

  static List<InVoiceModel> data = [];
  static Future<List<InVoiceModel>> getData() async {
    data.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 1000});
      var result = await DioHelper.get(path: endPoint);
      DioHelper.dio.options.headers.remove('per_page');

      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          data.add(InVoiceModel.fromJson(element));
        }
        return data;
      } else {
        log('Unable To Get $endPoint');
        return data;
      }
    } catch (e) {
      log('$e');
      return data;
    }
  }
}
