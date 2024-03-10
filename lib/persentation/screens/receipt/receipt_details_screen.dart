import 'dart:io';

import 'package:app/business_logic/exports/cubit/exports_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ReceiptDetailsScreen extends StatelessWidget {
  ReceiptDetailsScreen({super.key, required this.receiptModel});

  final ReceiptModel receiptModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            MyNavigator.back(context);
          },
          icon: Transform.flip(flipX: context.locale.languageCode == 'ar' ? true : false, child: SvgPicture.asset(AssetsSVG.next, color: MyColors.mainColor)),
        ),
        leadingWidth: 80,
        actions: [
          SvgPicture.asset(
            AssetsSVG.logoIcon,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Bond Details'.tr(),
                  style: const TextStyle(
                    fontSize: 23.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: MyColors.scaffoldColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _titleValueWidget2('From'.tr(), receiptModel.contact.name),
                      _titleValueWidget2('Account'.tr(), '${receiptModel.account?.nameAr}'),
                      _titleValueWidget2('Reference'.tr(), '${receiptModel.reference}'),
                      _titleValueWidget2('Description'.tr(), '${receiptModel.description}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _titleValueWidget2('Date'.tr(), '${receiptModel.date}'),
                      _titleValueWidget2('Amount'.tr(), '${receiptModel.amount} ر.س'),
                      _titleValueWidget2('Type'.tr(), receiptModel.kind),
                      _titleValueWidget2('Unallocated Amount'.tr(), '${receiptModel.unAllocateAmount} ر.س'),
                      const Divider(
                        thickness: 0.5,
                        color: MyColors.black,
                        height: 40,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Bond Assignments'.tr(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: MyColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _titleValueWidget3('Date'.tr(), '${receiptModel.date}'),
                      _titleValueWidget3('For'.tr(), 'فاتورة مبيعات'),
                      _titleValueWidget3('Reference'.tr(), '${receiptModel.reference}'),
                      _titleValueWidget3('Amount'.tr(), '${receiptModel.amount} ر.س'),
                      _titleValueWidget3('Options'.tr(), '${receiptModel.description}'),
                      const SizedBox(height: 30),
                      BlocBuilder<ExportsCubit, ExportsState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: ExportsCubit.get(context).isExportingPDF != true,
                            child: CustomButton(
                              text: 'Download PDF'.tr(),
                              onPressed: () async {
                                // ignore: use_build_context_synchronously
                                await ExportsCubit.get(context).downloadRecipt(context, receiptModel);
                              },
                              color: MyColors.black,
                              width: 120,
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleValueWidget(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.black,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleValueWidget2(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            height: 2.43,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AutoSizeText(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.black,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
            maxLines: 1,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _titleValueWidget3(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            color: MyColors.black,
            fontWeight: FontWeight.w600,
            height: 2.43,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.mainColor,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
