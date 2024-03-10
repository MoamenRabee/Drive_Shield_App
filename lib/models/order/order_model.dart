import 'package:app/models/branche/branche_model.dart';
import 'package:app/models/driver/driver_model.dart';
import 'package:app/models/order_item/order_item_model.dart';
import 'package:app/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderModel {
  late int id;
  late int? customerId;
  late int? driverId;
  late int inventoryId;
  late String reference;
  late String? status;
  late String? shippingStatus;
  late String? notes;
  late String? confirmationImage;
  late dynamic termsConditions;
  late DateTime createdAt;
  late DateTime updatedAt;
  late double? totalTax;
  late double total;
  late double totalWithTax;
  late List<OrderItemModel>? orderItems;
  late DriverModel? driver;
  late UserModel? customer;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.driverId,
    required this.inventoryId,
    required this.reference,
    required this.status,
    required this.shippingStatus,
    required this.confirmationImage,
    required this.termsConditions,
    required this.createdAt,
    required this.updatedAt,
    required this.totalTax,
    required this.total,
    required this.totalWithTax,
    required this.orderItems,
    required this.driver,
    required this.customer,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
