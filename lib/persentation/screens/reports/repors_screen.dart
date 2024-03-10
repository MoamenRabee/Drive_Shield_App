import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/account_statement/account_statement_details_screen.dart';
import 'package:app/persentation/screens/account_statement/account_statement_screen.dart';
import 'package:app/persentation/screens/invoice/invoice_screen.dart';
import 'package:app/persentation/screens/notifications/notifications_screen.dart';
import 'package:app/persentation/screens/overdue/overdue_screen.dart';
import 'package:app/persentation/screens/receipt/receipt_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                MyNavigator.navigateTo(context, const NotificationScreen());
              },
              icon: SvgPicture.asset(
                AssetsSVG.notification,
                color: MyColors.mainColor,
              ),
            ),
            actions: [
              SvgPicture.asset(
                AssetsSVG.fullIconColor,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _header(),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ReportsWidget(
                      onTap: () {
                        MyNavigator.navigateTo(context, const InVoiceScreen());
                      },
                      title: 'Invoices'.tr(),
                      svg: AssetsSVG.reports_1,
                      color: MyColors.gray,
                    ),
                    ReportsWidget(
                      onTap: () {
                        MyNavigator.navigateTo(context, const ReceiptScreen());
                      },
                      title: 'Bonds'.tr(),
                      svg: AssetsSVG.reports_2,
                      color: MyColors.gray,
                    ),
                    ReportsWidget(
                      onTap: () {
                        MyNavigator.navigateTo(context, const OverdueScreen());
                      },
                      title: 'Indebtedness'.tr(),
                      svg: AssetsSVG.reports_3,
                      color: MyColors.gray,
                    ),
                    ReportsWidget(
                      onTap: () {
                        MyNavigator.navigateTo(context, AccountStatementScreen());
                      },
                      title: 'Account Statement'.tr(),
                      svg: AssetsSVG.reports_4,
                      color: MyColors.gray,
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _header() {
    return Container(
      padding: const EdgeInsetsDirectional.all(20),
      width: double.infinity,
      height: 199,
      margin: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: MyColors.mainColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reports'.tr(),
                  style: const TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Control Your Finances With Ease!'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SvgPicture.asset(AssetsSVG.reports_1),
        ],
      ),
    );
  }
}

class ReportsWidget extends StatelessWidget {
  ReportsWidget({
    super.key,
    required this.title,
    required this.svg,
    required this.color,
    this.onTap,
  });

  String title;
  String svg;
  Color color;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.0,
        height: 160.0,
        // margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(child: SvgPicture.asset(svg)),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
