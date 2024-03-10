import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      scaffoldColor: MyColors.gray,
      title: 'Notifications'.tr(),
      iconback: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
            ],
          ),
        ),
      ),
    );
  }

  Container _card() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: MyColors.scaffoldColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: MyColors.mainColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AssetsSVG.logoIcon,
                width: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تم الموفقة على الطلبية الجديدة',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'رقم الطلبية 1',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
