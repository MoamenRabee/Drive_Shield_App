import 'dart:developer';

import 'package:app/business_logic/products/cubit/products_cubit.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/branche/branche_model.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/models/selected_products/selected_products.dart';
import 'package:app/network/services/orders_services.dart';
import 'package:app/persentation/screens/orders/order_done_screen.dart';
import 'package:app/theme/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(BuildContext context) => BlocProvider.of(context);
  BrancheModel? selectedBranch;

  void selectBranch(BrancheModel brancheModel) {
    selectedBranch = brancheModel;
    emit(SelectBranch());
  }

  bool isLoadingData = false;
  bool isLoadingAction = false;
  bool isLoadingDelete = false;

  Future<void> addOrder({
    required BuildContext context,
    required DateTime dateTime,
    required BrancheModel brancheModel,
    required String address,
  }) async {
    try {
      isLoadingAction = true;
      emit(OrdersActionLoading());

      Response? response = await OrdersServices.addData(
        {
          "order": {
            "date": "${dateTime.day}-${dateTime.month}-${dateTime.year}",
            "location": address,
            "branch_id": "${brancheModel.id}",
            "notes": "",
            "line_items": SelectedProductsModel.selectedProducts
                .map((e) => {
                      "product_id": e.productModel.id,
                      "quantity": e.qty,
                    })
                .toList(),
          }
        },
      );

      if (response?.statusCode == 200) {
        SelectedProductsModel.selectedProducts.clear();
        // ignore: use_build_context_synchronously
        ProductsCubit.get(context).totalPrice = 0.0;

        // ignore: use_build_context_synchronously
        MyNavigator.navigateTo(context, OrderDoneScreen());

        // ignore: use_build_context_synchronously
        showMessage(context: context, message: response?.data['msg'], color: MyColors.mainColor);
      } else {
        log('${response?.data['msg']}');
        // ignore: use_build_context_synchronously
        showMessage(context: context, message: response?.data['msg'], color: MyColors.redColor);
      }
      isLoadingAction = false;
      emit(OrdersActionSuccess());
    } catch (e) {
      log('$e');
      isLoadingAction = false;
      emit(OrdersActionError());
    }
  }

  List<OrderModel> allOrders = [];
  Future<void> getOrders() async {
    try {
      isLoadingData = true;
      emit(OrdersGetLoading());
      allOrders = await OrdersServices.getData();
      isLoadingData = false;
      emit(OrdersGetSuccess());
    } catch (e) {
      log('$e');
      isLoadingData = false;
      emit(OrdersGetError());
    }
  }
}
