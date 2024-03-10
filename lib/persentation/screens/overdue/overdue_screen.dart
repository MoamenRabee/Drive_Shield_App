import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OverdueScreen extends StatelessWidget {
  const OverdueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Indebtedness'.tr(),
      iconback: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              _card(
                title: 'Closing Balance'.tr(),
                data: '${ProfileCubit.get(context).userModel?.closingBalance} ${'SAR'.tr()}',
              ),
              _card(
                title: 'Total Due'.tr(),
                data: '${ProfileCubit.get(context).userModel?.totalPaid} ${'SAR'.tr()}',
              ),
              _card(
                title: 'Late'.tr(),
                data: '${ProfileCubit.get(context).userModel?.overdue} ${'SAR'.tr()}',
              ),
              _card(
                title: 'Number Of All Invoices'.tr(),
                data: '${ProfileCubit.get(context).userModel?.totalInvoicesCount}',
              ),
              _card(
                title: 'Total Amounts Of All Invoices'.tr(),
                data: '${ProfileCubit.get(context).userModel?.totalInvoicesAmount} ${'SAR'.tr()}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _card({
    required String title,
    required String data,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      width: 346.0,
      height: 127.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.0),
        color: const Color(0xFFF3ECE5).withOpacity(0.57),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                color: MyColors.mainColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            data,
            style: const TextStyle(
              fontSize: 18.0,
              color: MyColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
