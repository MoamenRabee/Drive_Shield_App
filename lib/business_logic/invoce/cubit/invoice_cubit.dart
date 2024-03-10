import 'dart:developer';

import 'package:app/business_logic/products/cubit/products_cubit.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/branche/branche_model.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/models/selected_products/selected_products.dart';
import 'package:app/network/services/InVoice_services.dart';

import 'package:app/theme/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'invoice_state.dart';

class InVoiceCubit extends Cubit<InVoiceState> {
  InVoiceCubit() : super(InVoiceInitial());

  static InVoiceCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingData = false;
  List<InVoiceModel> allInVoice = [];
  Future<void> getInVoice() async {
    try {
      isLoadingData = true;
      emit(InVoiceGetLoading());
      allInVoice = await InVoiceServices.getData();
      isLoadingData = false;
      emit(InVoiceGetSuccess());
    } catch (e) {
      log('$e');
      isLoadingData = false;
      emit(InVoiceGetError());
    }
  }
}
