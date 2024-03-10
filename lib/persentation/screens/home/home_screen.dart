import 'dart:developer';

import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/reset_password_screen.dart';
import 'package:app/persentation/screens/notifications/notifications_screen.dart';
import 'package:app/persentation/screens/overdue/overdue_screen.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/chart.dart';
import 'package:app/persentation/widgets/lang_widget.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import 'package:gif_view/gif_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                AssetsSVG.logoSvg,
                // color: MyColors.mainColor,
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Directionality(
            textDirection: context.locale.languageCode == 'en' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 100,
                        margin: const EdgeInsets.only(top: 180),
                        padding: const EdgeInsets.only(top: 80),
                        decoration: const BoxDecoration(
                          color: MyColors.gray,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: const Column(
                          children: [
                            ArrearsWidget(),
                            IndebtednessWidget(),
                            PointsWidget(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                width: 392.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: MyColors.scaffoldColor,
                                ),
                                child: const LineChartWidget(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // MyNavigator.navigateTo(context, const OverdueScreen());
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 30),
        decoration: const BoxDecoration(
          // color: MyColors.gray,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 20, start: 0, top: 0, bottom: 0),
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 392.0,
                // height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10, end: 10, start: 15),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          AssetsSVG.points,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 5, end: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'نقاط الولاء'.tr(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: MyColors.mainColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // const SizedBox(height: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                      text: '2370',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                        height: 0,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' نقطة',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                            height: 0,
                                          ),
                                        ),
                                      ]),
                                ),
                                Text(
                                  'استخدم 1000 نقطة مقابل 100 ريال ',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: MyColors.gray,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: MyColors.mainColor,
                                    thickness: 4,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${ProfileCubit.get(context).userModel?.totalPaid} ',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                    Text(
                                      'SAR'.tr(),
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              end: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: MyColors.black,
                child: Transform.flip(
                  flipX: context.locale.languageCode == 'en' ? true : false,
                  child: SvgPicture.asset(
                    AssetsSVG.next,
                    width: 18,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IndebtednessWidget extends StatelessWidget {
  const IndebtednessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, const OverdueScreen());
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 30),
        decoration: const BoxDecoration(
          // color: MyColors.gray,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 20, start: 0, top: 0, bottom: 0),
              constraints: const BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 392.0,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 0, start: 10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GifView.asset(
                          'assets/images/04.gif',
                          // controller: controller,
                          height: 40,
                          width: 40,
                          frameRate: 30,
                          repeat: ImageRepeat.noRepeat,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 5, end: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Indebtedness'.tr(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: MyColors.mainColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total Invoices'.tr(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  children: [
                                    Text(
                                      '${ProfileCubit.get(context).userModel?.totalInvoicesAmount} ',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                    Text(
                                      'SAR'.tr(),
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total Due'.tr(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${ProfileCubit.get(context).userModel?.totalPaid} ',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                    Text(
                                      'SAR'.tr(),
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              end: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: MyColors.black,
                child: Transform.flip(
                  flipX: context.locale.languageCode == 'en' ? true : false,
                  child: SvgPicture.asset(
                    AssetsSVG.next,
                    width: 18,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArrearsWidget extends StatelessWidget {
  const ArrearsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, const OverdueScreen());
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 40, start: 20, top: 10, bottom: 10),
              width: 392.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: MyColors.mainColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 13, end: 10, start: 10),
                    child: SvgPicture.asset(
                      AssetsSVG.arrears,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Arrears'.tr(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Duty Paid'.tr(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${ProfileCubit.get(context).userModel?.overdue} ',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'SAR'.tr(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 40),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              end: 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: MyColors.black,
                child: Transform.flip(
                  flipX: context.locale.languageCode == 'en' ? true : false,
                  child: SvgPicture.asset(
                    AssetsSVG.next,
                    width: 18,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
