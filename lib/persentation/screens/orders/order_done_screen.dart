import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/layout/layout_screen.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GifView.asset(
                    'assets/images/02.gif',
                    height: 300,
                    width: 300,
                    frameRate: 30,
                    repeat: ImageRepeat.noRepeat,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your Request Has Been Received Successfully'.tr(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPressed: () {
                      MyNavigator.navigateOffAll(context, const LayoutScreen());
                    },
                    text: 'Home'.tr(),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    borderRadius: BorderRadius.circular(30),
                    width: 270,
                    height: 50,
                    color: MyColors.scaffoldColor,
                    textColor: MyColors.mainColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
