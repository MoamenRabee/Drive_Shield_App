import 'dart:developer';

import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/account_statement_model/account_statement_model.dart';
import 'package:app/models/branche/branche_model.dart';
import 'package:app/network/services/account_statement_services.dart';
import 'package:app/persentation/screens/account_statement/account_statement_details_screen.dart';
import 'package:app/theme/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'account_statement_state.dart';

class AccountStatementCubit extends Cubit<AccountStatementState> {
  AccountStatementCubit() : super(AccountStatementInitial());

  static AccountStatementCubit get(BuildContext context) => BlocProvider.of(context);
  BrancheModel? selectedBranch;
  bool isLoadingAction = false;

  void selectBranch(BrancheModel brancheModel) {
    selectedBranch = brancheModel;
    emit(SelectBranch());
  }

  List<AccountStatementModel> allAccountStatements = [];
  Future<void> getAccountStatement({
    required BuildContext context,
    required DateTime fromDateTime,
    required DateTime toDateTime,
    required BrancheModel brancheModel,
  }) async {
    try {
      isLoadingAction = true;
      emit(GetAccountStatementLoading());

      allAccountStatements = await AccountStatementServices.getData({
        "filter[date_range]": "${fromDateTime.year}-${fromDateTime.month}-${fromDateTime.day},${toDateTime.year}-${toDateTime.month}-${toDateTime.day}",
        "branch_id": "${brancheModel.id}",
      });

      // allAccountStatements = await AccountStatementServices.getData({
      //   "filter[date_range]": "2021-01-01,2024-06-01",
      //   "branch_id": "4",
      // });

      // ignore: use_build_context_synchronously
      MyNavigator.navigateTo(context, const AccountStatementDetailsScreen());

      isLoadingAction = false;
      emit(GetAccountStatementSuccess());
    } catch (e) {
      log('$e');
      isLoadingAction = false;
      emit(GetAccountStatementError());
    }
  }
}
