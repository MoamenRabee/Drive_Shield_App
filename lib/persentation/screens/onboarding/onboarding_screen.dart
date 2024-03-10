import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/login_screen.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Center(
              //   child: Transform.scale(
              //     scale: 1.2,
              //     child: SizedBox(
              //       width: double.infinity,
              //       height: 300,
              //       child: SvgPicture.asset(
              //         AssetsSVG.onbording,
              //         width: double.infinity,
              //         height: double.infinity,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (context.locale.languageCode == 'ar')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'More Than One Application'.tr(),
                            style: const TextStyle(
                              fontSize: 37.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'A friend to keep track of your bills'.tr(),
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: MyColors.mainColor,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            'Easily'.tr(),
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: MyColors.mainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'And Smoothly'.tr(),
                            style: const TextStyle(
                              fontSize: 26.0,
                              color: MyColors.mainColor,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'More Than One Application'.tr(),
                            style: const TextStyle(
                              fontSize: 37.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(children: [
                              TextSpan(
                                text: 'A friend to keep track of your bills'.tr(),
                                style: const TextStyle(
                                  fontSize: 26.0,
                                  color: MyColors.mainColor,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              TextSpan(
                                text: ' ${'Easily'.tr()} ',
                                style: const TextStyle(
                                  fontSize: 26.0,
                                  color: MyColors.mainColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'And Smoothly'.tr(),
                                style: const TextStyle(
                                  fontSize: 26.0,
                                  color: MyColors.mainColor,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ]),
                          ])),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  MyNavigator.navigateOffAll(context, LoginScreen());
                },
                child: SvgPicture.asset(
                  AssetsSVG.nextOn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
