import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/network/dio_helper.dart';
import 'package:dio/dio.dart';

class OrdersServices {
  static String endPoint = EndPoints.orders;

  static List<OrderModel> data = [];
  static Future<List<OrderModel>> getData() async {
    data.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 1000});
      var result = await DioHelper.get(path: endPoint);
      DioHelper.dio.options.headers.remove('per_page');

      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          data.add(OrderModel.fromJson(element));
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

  static Future<Response?> addData(Map<String, dynamic> payload) async {
    try {
      var result = await DioHelper.post(path: endPoint, data: payload);

      if (result.statusCode == 200) {
        log('Add $endPoint  Success');
        return result;
      } else {
        log('Unable To Add $endPoint');
      }

      return result;
    } catch (e) {
      log('$e');
    }
    return null;
  }
}
