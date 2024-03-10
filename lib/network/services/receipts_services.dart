import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/network/dio_helper.dart';

class ReceiptsServices {
  static String endPoint = EndPoints.receipts;

  static List<ReceiptModel> data = [];
  static Future<List<ReceiptModel>> getData() async {
    data.clear();
    try {
      DioHelper.dio.options.headers.addAll({"per_page": 1000});
      var result = await DioHelper.get(path: endPoint);
      DioHelper.dio.options.headers.remove('per_page');

      if (result.statusCode == 200) {
        log('Get $endPoint Success');
        for (var element in result.data['data']['data']) {
          data.add(ReceiptModel.fromJson(element));
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
