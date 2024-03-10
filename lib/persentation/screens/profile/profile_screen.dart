import 'package:app/business_logic/auth/cubit/auth_cubit.dart';
import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/auth/login_screen.dart';
import 'package:app/persentation/screens/notifications/notifications_screen.dart';
import 'package:app/persentation/screens/profile/branches_screen.dart';
import 'package:app/persentation/screens/profile/policies_screen.dart';
import 'package:app/persentation/screens/profile/profile_details_screen.dart';
import 'package:app/persentation/screens/profile/settings_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColors.gray,
          appBar: AppBar(
            backgroundColor: MyColors.gray,
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
                height: 35,
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 80,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      MyNavigator.navigateTo(context, const ProfileDetailsScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: 349.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: MyColors.mainColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: MyColors.scaffoldColor,
                            ),
                            child: SvgPicture.asset(
                              AssetsSVG.profile,
                              color: MyColors.mainColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${ProfileCubit.get(context).userModel?.name}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProfileWidget(
                    title: 'Branches'.tr(),
                    svg: AssetsSVG.profile_1,
                    onTap: () {
                      MyNavigator.navigateTo(context, const BranchesScreen());
                    },
                  ),
                  ProfileWidget(
                    title: 'Policies'.tr(),
                    svg: AssetsSVG.profile_2,
                    onTap: () {
                      MyNavigator.navigateTo(context, const PoliciesScreen());
                    },
                  ),
                  ProfileWidget(
                    title: 'Settings'.tr(),
                    svg: AssetsSVG.profile_3,
                    onTap: () {
                      MyNavigator.navigateTo(context, const SettingsScreen());
                    },
                  ),
                  ProfileWidget(
                    title: 'Log Out'.tr(),
                    svg: AssetsSVG.profile_4,
                    onTap: () {
                      AuthCubit.get(context).signOut(context);
                    },
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

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    super.key,
    required this.title,
    required this.svg,
    this.onTap,
  });

  String title;
  String svg;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 322.0,
        height: 74.0,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: Colors.transparent,
              ),
              child: Center(child: SvgPicture.asset(svg)),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.0,
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
