// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as int,
      customerId: json['customer_id'] as int?,
      driverId: json['driver_id'] as int?,
      inventoryId: json['inventory_id'] as int,
      reference: json['reference'] as String,
      status: json['status'] as String?,
      shippingStatus: json['shipping_status'] as String?,
      confirmationImage: json['confirmation_image'] as String?,
      termsConditions: json['terms_conditions'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      totalTax: (json['total_tax'] as num?)?.toDouble(),
      total: (json['total'] as num).toDouble(),
      totalWithTax: (json['total_with_tax'] as num).toDouble(),
      orderItems: (json['order_items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      driver: json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
    )..notes = json['notes'] as String?;

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'driver_id': instance.driverId,
      'inventory_id': instance.inventoryId,
      'reference': instance.reference,
      'status': instance.status,
      'shipping_status': instance.shippingStatus,
      'notes': instance.notes,
      'confirmation_image': instance.confirmationImage,
      'terms_conditions': instance.termsConditions,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'total_tax': instance.totalTax,
      'total': instance.total,
      'total_with_tax': instance.totalWithTax,
      'order_items': instance.orderItems,
      'driver': instance.driver,
      'customer': instance.customer,
    };
