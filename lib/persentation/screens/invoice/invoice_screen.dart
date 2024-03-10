import 'package:app/business_logic/invoce/cubit/invoice_cubit.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/persentation/screens/invoice/invoice_details_screen.dart';
import 'package:app/persentation/screens/receipt/receipt_details_screen.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InVoiceScreen extends StatefulWidget {
  const InVoiceScreen({super.key});

  @override
  State<InVoiceScreen> createState() => _InVoiceScreenState();
}

class _InVoiceScreenState extends State<InVoiceScreen> {
  @override
  void initState() {
    InVoiceCubit.get(context).getInVoice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Invoices'.tr(),
      iconback: true,
      body: BlocBuilder<InVoiceCubit, InVoiceState>(
        builder: (context, state) {
          return InVoiceCubit.get(context).isLoadingData
              ? MyLoadingTransperant()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 80,
                    top: 24,
                    left: 40,
                    right: 40,
                  ),
                  itemBuilder: (context, index) {
                    return InVoiceWidget(inVoiceModel: InVoiceCubit.get(context).allInVoice[index]);
                  },
                  itemCount: InVoiceCubit.get(context).allInVoice.length,
                );
        },
      ),
    );
  }
}

class InVoiceWidget extends StatelessWidget {
  InVoiceWidget({
    super.key,
    required this.inVoiceModel,
  });

  InVoiceModel inVoiceModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, InVoiceDetailsScreen(inVoiceModel: inVoiceModel));
      },
      child: Container(
        width: 300.0,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyColors.scaffoldColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reference'.tr(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  inVoiceModel.reference,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '${inVoiceModel.owner?.name}',
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              height: 20,
              color: MyColors.black,
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice Value'.tr(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${inVoiceModel.total} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Release Date'.tr(),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatDate(context, inVoiceModel.createdAt),
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
