import 'package:app/business_logic/layout/cubit/layout_cubit.dart';
import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/persentation/screens/layout/widgets/user_bottom_nav_bar.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);

    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return BlocBuilder<LayoutCubit, LayoutState>(
              builder: (context, state) {
                return Directionality(
                  textDirection: context.locale.languageCode == 'en' ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                  child: Scaffold(
                    extendBody: true,
                    body: ProfileCubit.get(context).isLoading || ProfileCubit.get(context).userModel == null ? MyLoadingTransperant() : cubit.layoutBody[cubit.bottomNavBarIndex],
                    bottomNavigationBar: ProfileCubit.get(context).isLoading || ProfileCubit.get(context).userModel == null ? null : const BottomNavBar(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
