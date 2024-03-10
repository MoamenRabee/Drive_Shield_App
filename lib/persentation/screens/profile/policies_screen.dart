import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/reset_change_password_screen.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'Policies'.tr(),
      fullIcon: true,
      iconback: true,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 346.0,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: MyColors.gray,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Privacy Policy'.tr(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AssetsSVG.next,
                            color: MyColors.mainColor,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 346.0,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: MyColors.gray,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Technical Support'.tr(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AssetsSVG.next,
                            color: MyColors.mainColor,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
