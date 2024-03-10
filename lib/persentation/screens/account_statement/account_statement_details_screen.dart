import 'package:app/business_logic/account_statement/cubit/account_statement_cubit.dart';
import 'package:app/business_logic/exports/cubit/exports_cubit.dart';
import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AccountStatementDetailsScreen extends StatefulWidget {
  const AccountStatementDetailsScreen({super.key});

  @override
  State<AccountStatementDetailsScreen> createState() => _AccountStatementDetailsScreenState();
}

class _AccountStatementDetailsScreenState extends State<AccountStatementDetailsScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Account Statement'.tr(),
              style: const TextStyle(
                fontSize: 22.0,
                color: MyColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.0),
                        color: MyColors.scaffoldColor.withOpacity(0.44),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Date'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Type'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Description Process'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Ref'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Debtor'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Creditor'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'Balance'.tr(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${AccountStatementCubit.get(context).allAccountStatements[index].date}',
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          AccountStatementCubit.get(context).allAccountStatements[index].kind,
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${AccountStatementCubit.get(context).allAccountStatements[index].description}',
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          '${AccountStatementCubit.get(context).allAccountStatements[index].reference}',
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          AccountStatementCubit.get(context).allAccountStatements[index].contact.name,
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          '${ProfileCubit.get(context).userModel?.name}',
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          AccountStatementCubit.get(context).allAccountStatements[index].amount,
                                          style: const TextStyle(
                                            fontSize: 8,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: AccountStatementCubit.get(context).allAccountStatements.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ExportsCubit, ExportsState>(
                    builder: (context, state) {
                      return ExportsCubit.get(context).isExportingAccountStatement
                          ? CustomButtonLoading(
                              color: MyColors.black,
                              width: 120,
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            )
                          : CustomButton(
                              text: 'Download PDF'.tr(),
                              onPressed: () {
                                ExportsCubit.get(context).exportAccountStatement(AccountStatementCubit.get(context).allAccountStatements, context);
                              },
                              color: MyColors.black,
                              width: 120,
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
