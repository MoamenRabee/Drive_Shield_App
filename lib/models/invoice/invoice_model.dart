import 'package:app/models/branche/branche_model.dart';
import 'package:app/models/driver/driver_model.dart';
import 'package:app/models/line_items/line_items_model.dart';
import 'package:app/models/order_item/order_item_model.dart';
import 'package:app/models/owner/owner_model.dart';
import 'package:app/models/payment/payments_model.dart';
import 'package:app/models/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InVoiceModel {
  late int id;
  late int contactId;
  late String reference;
  late String? description;
  late String? issueDate;
  late String? dueDate;
  late String? status;
  late String dueAmount;
  late String paidAmount;
  late String total;
  late String? notes;
  late dynamic termsConditions;
  late String? qrcodeString;
  late String? paymentMethod;
  late DateTime createdAt;
  late DateTime updatedAt;
  late dynamic inventory;
  late String? type;
  late List<PaymentsModel>? payments;
  late List<LineItemsModel>? lineItems;
  late UserModel? contact;
  late OwnerModel? owner;

  InVoiceModel({
    required this.id,
    required this.contactId,
    required this.reference,
    required this.description,
    required this.issueDate,
    required this.dueDate,
    required this.status,
    required this.dueAmount,
    required this.paidAmount,
    required this.total,
    required this.notes,
    required this.termsConditions,
    required this.qrcodeString,
    required this.paymentMethod,
    required this.createdAt,
    required this.inventory,
    required this.type,
    required this.payments,
    required this.lineItems,
    required this.contact,
    required this.owner,
  });

  factory InVoiceModel.fromJson(Map<String, dynamic> json) => _$InVoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InVoiceModelToJson(this);
}
