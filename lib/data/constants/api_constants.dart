import 'package:app/helpers/cache_helper.dart';

class Constants {
  static String accessToken = CacheHelper.getString(key: "access_token") ?? "";
}

class ApiConstants {
  static const baseURL = 'https://driveshield.net/api/user/';
  static const stoarge = 'https://driveshield.net/storage/';
  // static const baseURL = 'http://192.168.1.6:8080/server/';
  // static const stoarge = 'http://192.168.1.6:8080/public/';
}

class EndPoints {
  static const login = 'login';
  static const me = 'me';
  static const forgetPassword = 'forget-password';
  static const profile = 'me';
  static const orders = 'orders';
  static const products = 'products';
  static const invoices = 'invoices';
  static const receipts = 'receipts';
  static const accountStatement = 'account-statement';
}
