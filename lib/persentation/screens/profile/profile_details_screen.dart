import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'Account Details'.tr(),
      fullIcon: true,
      iconback: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
                  child: Text(
                    'Phone Number'.tr(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  text: '${ProfileCubit.get(context).userModel?.phoneNumber}',
                  controller: TextEditingController(),
                  isFilld: true,
                  color: MyColors.gray,
                  borderSide: BorderSide.none,
                  hintColor: Colors.black,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  borderRadius: BorderRadius.circular(11),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
                  child: Text(
                    'Company'.tr(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  text: '${ProfileCubit.get(context).userModel?.organization}',
                  controller: TextEditingController(),
                  isFilld: true,
                  color: MyColors.gray,
                  borderSide: BorderSide.none,
                  hintColor: Colors.black,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  borderRadius: BorderRadius.circular(11),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
                  child: Text(
                    'Commercial Register'.tr(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  text: '${ProfileCubit.get(context).userModel?.taxNumber}',
                  controller: TextEditingController(),
                  isFilld: true,
                  color: MyColors.gray,
                  borderSide: BorderSide.none,
                  hintColor: Colors.black,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  borderRadius: BorderRadius.circular(11),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
