import 'package:app/business_logic/layout/cubit/layout_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarItem {
  late String title;
  late String icon;
  late int id;

  BottomNavBarItem({required this.title, required this.icon, required this.id});

  static List<BottomNavBarItem> navBar = [
    BottomNavBarItem(title: 'Home', icon: AssetsSVG.home, id: 0),
    BottomNavBarItem(title: 'Orders', icon: AssetsSVG.orders, id: 1),
    BottomNavBarItem(title: 'Reports', icon: AssetsSVG.reports, id: 2),
    BottomNavBarItem(title: 'Profile', icon: AssetsSVG.profile, id: 3),
  ];
}

// Widget bottomNavBar(BuildContext context, int pageIndex) {

//   return Container(
//     width: double.infinity,
//     height: 80,
//     decoration: BoxDecoration(
//       color: MyColors.black,
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//       border: Border.all(
//         width: 1,
//         color: Colors.grey[300]!,
//       ),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(width: 30),
//         ...BottomNavBarItem.navBar.map(
//           (e) => bottomNavBarItem(
//             context: context,
//             pageIndex: cubit.bottomNavBarIndex,
//             barItem: e,
//           ),
//         ),
//         const SizedBox(width: 30),
//       ],
//     ),
//   );
// }

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: MyColors.black,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.grey[300]!,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 30),
                  ...BottomNavBarItem.navBar.map(
                    (e) => bottomNavBarItem(
                      context: context,
                      pageIndex: cubit.bottomNavBarIndex,
                      barItem: e,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Widget bottomNavBarItem({
  required BuildContext context,
  required int pageIndex,
  required BottomNavBarItem barItem,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        LayoutCubit.get(context).changeScreen(barItem.id);
      },
      child: CircleAvatar(
        radius: 30,
        backgroundColor: pageIndex == barItem.id ? Colors.white.withOpacity(0.08) : Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 2),
            SvgPicture.asset(
              barItem.icon,
              width: 22,
              color: pageIndex == barItem.id ? MyColors.redBottomNavBarColor : Colors.grey[300],
            ),
            const SizedBox(height: 2),
            AutoSizeText(
              barItem.title.tr(),
              style: TextStyle(
                // fontSize: 8,
                color: pageIndex == barItem.id ? MyColors.redBottomNavBarColor : Colors.grey[300],
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              minFontSize: 10,
              maxFontSize: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
