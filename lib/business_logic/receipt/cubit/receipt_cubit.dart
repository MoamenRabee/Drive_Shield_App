import 'dart:developer';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/network/services/receipts_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());

  static ReceiptCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingData = false;
  List<ReceiptModel> allReceipt = [];
  Future<void> getReceipt() async {
    try {
      isLoadingData = true;
      emit(ReceiptGetLoading());
      allReceipt = await ReceiptsServices.getData();
      isLoadingData = false;
      emit(ReceiptGetSuccess());
    } catch (e) {
      log('$e');
      isLoadingData = false;
      emit(ReceiptGetError());
    }
  }
}
