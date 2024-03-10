import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/branche/branche_model.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fullIcon: true,
      scaffoldColor: MyColors.gray,
      title: 'Branches'.tr(),
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
                  Text(
                    'Tax Number'.tr(),
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: MyColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 346.0,
                    height: 79.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Colors.grey[100],
                    ),
                    child: Center(
                      child: Text(
                        '${ProfileCubit.get(context).userModel?.taxNumber}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(ProfileCubit.get(context).userModel?.branches?.length ?? 0, (index) {
                    return _branchCard(ProfileCubit.get(context).userModel!.branches![index]);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _branchCard(BrancheModel brancheModel) {
    return Container(
      width: 346.0,
      height: 79.0,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: MyColors.gray,
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
            child: Center(
              child: SvgPicture.asset(AssetsSVG.profile_1),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            brancheModel.name,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
