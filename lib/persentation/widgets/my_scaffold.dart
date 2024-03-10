import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/notifications/notifications_screen.dart';
import 'package:app/persentation/widgets/header.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    super.key,
    this.title,
    this.widgetTitle,
    this.body,
    this.iconback,
    this.fullIcon,
    this.scaffoldColor,
  });

  String? title;
  Widget? widgetTitle;
  Widget? body;
  bool? iconback;
  bool? fullIcon;
  Color? scaffoldColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainColor,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: MyColors.mainColor,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(50),
                bottomStart: Radius.circular(50),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 25),
                          if (iconback != true)
                            GestureDetector(
                              onTap: () {
                                MyNavigator.navigateTo(context, const NotificationScreen());
                              },
                              child: SvgPicture.asset(
                                AssetsSVG.notification,
                                height: 30,
                                width: 30,
                              ),
                            )
                          else
                            IconButton(
                              onPressed: () {
                                MyNavigator.back(context);
                              },
                              icon: Transform.flip(flipX: context.locale.languageCode == 'ar' ? true : false, child: SvgPicture.asset(AssetsSVG.next)),
                            ),
                          const Spacer(),
                          fullIcon == true
                              ? SvgPicture.asset(
                                  AssetsSVG.fullIcon,
                                  width: 40,
                                  height: 35,
                                  color: Colors.white,
                                )
                              : SvgPicture.asset(
                                  AssetsSVG.logoIcon,
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      title.toString(),
                      style: const TextStyle(
                        fontSize: 27,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (widgetTitle != null)
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: widgetTitle,
                  ),
              ],
            ),
          ),
          Expanded(
            child: ClipPath(
              clipper: MyClipper(radius: 50),
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                color: MyColors.whiteColor,
                width: MediaQuery.of(context).size.width,
                child: body ?? const SizedBox(),
              ),
            ),
          ),
          // Expanded(child: ),
        ],
      ),
    );
  }
}
