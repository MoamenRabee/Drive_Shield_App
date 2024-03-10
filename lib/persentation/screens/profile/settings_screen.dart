import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/reset_change_password_screen.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/screens/profile/change_password_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'Settings'.tr(),
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
                    onTap: () {
                      MyNavigator.navigateTo(context, ChangePasswordScreen());
                    },
                    child: Container(
                      width: 346.0,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        color: MyColors.gray,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 29.0,
                            height: 29.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: MyColors.whiteColor,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AssetsSVG.unlock,
                                color: MyColors.mainColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Password'.tr(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 346.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: MyColors.gray,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 29.0,
                              height: 29.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.0),
                                color: MyColors.whiteColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AssetsSVG.lang,
                                  width: 15,
                                  color: MyColors.mainColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Language'.tr(),
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 50),
                            GestureDetector(
                              onTap: () {
                                TranslationCubit.get(context).changAppLang(context, 'ar');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.locale.languageCode == 'ar' ? MyColors.mainColor : null,
                                ),
                                child: Text(
                                  'العربية',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: context.locale.languageCode == 'ar' ? MyColors.whiteColor : MyColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                TranslationCubit.get(context).changAppLang(context, 'en');
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: context.locale.languageCode == 'en' ? MyColors.mainColor : null,
                                ),
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: context.locale.languageCode == 'en' ? MyColors.whiteColor : MyColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
