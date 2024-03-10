// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) => OwnerModel(
      id: json['id'] as int,
      deviceToken: (json['device_token'] as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      locale: json['locale'] as String,
      name: json['name'] as String,
      organization: json['organization'],
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      taxNumber: json['tax_number'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    )
      ..commercialRegistrationNumber =
          json['commercial_registration_number'] as String
      ..shippingAddress = ShippingAddressModel.fromJson(
          json['shipping_address'] as Map<String, dynamic>);

Map<String, dynamic> _$OwnerModelToJson(OwnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_token': instance.deviceToken,
      'locale': instance.locale,
      'name': instance.name,
      'organization': instance.organization,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'tax_number': instance.taxNumber,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'commercial_registration_number': instance.commercialRegistrationNumber,
      'shipping_address': instance.shippingAddress,
    };
