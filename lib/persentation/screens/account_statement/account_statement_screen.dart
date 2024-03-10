import 'package:app/business_logic/account_statement/cubit/account_statement_cubit.dart';
import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AccountStatementScreen extends StatefulWidget {
  AccountStatementScreen({super.key});

  @override
  State<AccountStatementScreen> createState() => _AccountStatementScreenState();
}

class _AccountStatementScreenState extends State<AccountStatementScreen> {
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController date2Controller = TextEditingController();
  final TextEditingController branchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

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
            _form(context),
            const SizedBox(height: 20),
            _addSearchButton(context),
          ],
        ),
      ),
    );
  }

  Form _form(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsetsDirectional.only(
          start: 30,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30),
            bottomStart: Radius.circular(30),
          ),
          color: MyColors.scaffoldColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'Branches'.tr(),
                style: const TextStyle(
                  fontSize: 15.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<AccountStatementCubit, AccountStatementState>(
                      builder: (context, state) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: MyColors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ...List.generate(
                                ProfileCubit.get(context).userModel?.branches?.length ?? 0,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        AccountStatementCubit.get(context).selectBranch(ProfileCubit.get(context).userModel!.branches![index]);
                                        branchController.text = AccountStatementCubit.get(context).selectedBranch?.name ?? '';
                                      });
                                      MyNavigator.back(context);
                                    },
                                    child: Container(
                                      width: 293.0,
                                      height: 43.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32.0),
                                        color: AccountStatementCubit.get(context).selectedBranch == ProfileCubit.get(context).userModel!.branches![index] ? MyColors.black : null,
                                        border: Border.all(
                                          width: 0.5,
                                          color: MyColors.black,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          ProfileCubit.get(context).userModel!.branches![index].name,
                                          style: TextStyle(color: AccountStatementCubit.get(context).selectedBranch == ProfileCubit.get(context).userModel!.branches![index] ? Colors.white : MyColors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: CustomTextFormField(
                text: 'Select the institution'.tr(),
                controller: branchController,
                isFilld: true,
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none,
                enabled: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please select the institution'.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'From'.tr(),
                style: const TextStyle(
                  fontSize: 15.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1990),
                  currentDate: selectedDate1,
                  locale: context.locale,
                  lastDate: DateTime.now().add(const Duration(days: (365 * 10))),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: MyColors.mainColor,
                          surfaceTint: Colors.white,
                        ),
                        textTheme: const TextTheme(
                          button: TextStyle(fontFamily: MyFonts.font),
                          headlineLarge: TextStyle(fontFamily: MyFonts.font),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate1 = value;
                      date1Controller.text = formatDate(context, value);
                    });
                  }
                });
              },
              child: CustomTextFormField(
                text: 'Select the invoice date'.tr(),
                controller: date1Controller,
                isFilld: true,
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none,
                enabled: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Select the invoice date'.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'To'.tr(),
                style: const TextStyle(
                  fontSize: 15.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime(1990),
                  currentDate: selectedDate2,
                  locale: context.locale,
                  lastDate: DateTime.now().add(const Duration(days: (365 * 10))),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: MyColors.mainColor,
                          surfaceTint: Colors.white,
                        ),
                        textTheme: const TextTheme(
                          button: TextStyle(fontFamily: MyFonts.font),
                          headlineLarge: TextStyle(fontFamily: MyFonts.font),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate2 = value;
                      date2Controller.text = formatDate(context, value);
                    });
                  }
                });
              },
              child: CustomTextFormField(
                text: 'Select the invoice date'.tr(),
                controller: date2Controller,
                isFilld: true,
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none,
                enabled: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Select the invoice date'.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  BlocBuilder _addSearchButton(BuildContext context) {
    return BlocBuilder<AccountStatementCubit, AccountStatementState>(
      builder: (context, state) {
        return AccountStatementCubit.get(context).isLoadingAction
            ? CustomButtonLoading(
                fontWeight: FontWeight.bold,
                color: MyColors.mainColor,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(30),
                height: 50,
                width: 300,
              )
            : CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await AccountStatementCubit.get(context).getAccountStatement(
                      context: context,
                      fromDateTime: selectedDate1,
                      toDateTime: selectedDate2,
                      brancheModel: AccountStatementCubit.get(context).selectedBranch!,
                    );
                  }
                },
                text: 'Search'.tr(),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.mainColor,
                textColor: Colors.white,
                borderRadius: BorderRadius.circular(30),
                height: 50,
                width: 300,
              );
      },
    );
  }
}
