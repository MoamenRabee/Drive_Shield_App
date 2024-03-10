import 'dart:developer';

import 'package:app/business_logic/receipt/cubit/receipt_cubit.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/persentation/screens/invoice/invoice_details_screen.dart';
import 'package:app/persentation/screens/receipt/receipt_details_screen.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  void initState() {
    ReceiptCubit.get(context).getReceipt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Bonds'.tr(),
      iconback: true,
      body: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          return ReceiptCubit.get(context).isLoadingData
              ? MyLoadingTransperant()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 80,
                    top: 24,
                    left: 40,
                    right: 40,
                  ),
                  itemBuilder: (context, index) {
                    return ReceiptWidget(receiptModel: ReceiptCubit.get(context).allReceipt[index]);
                  },
                  itemCount: ReceiptCubit.get(context).allReceipt.length,
                );
        },
      ),
    );
  }
}

class ReceiptWidget extends StatelessWidget {
  ReceiptWidget({
    super.key,
    required this.receiptModel,
  });

  ReceiptModel receiptModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, ReceiptDetailsScreen(receiptModel: receiptModel));
      },
      child: Container(
        width: 300.0,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyColors.scaffoldColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Number'.tr(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${receiptModel.reference}',
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              receiptModel.contact.name,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              height: 20,
              color: MyColors.black,
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice Value'.tr(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${receiptModel.amount} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Release Date'.tr(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${receiptModel.date}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
