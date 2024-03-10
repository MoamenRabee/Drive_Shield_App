import 'package:app/business_logic/exports/cubit/exports_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/invoice/invoice_model.dart';
import 'package:app/models/receipt/receipt_model.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screenshot/screenshot.dart';

class InVoiceDetailsScreen extends StatelessWidget {
  const InVoiceDetailsScreen({super.key, required this.inVoiceModel});

  final InVoiceModel inVoiceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            MyNavigator.back(context);
          },
          icon: Transform.flip(flipX: context.locale.languageCode == 'ar' ? true : false, child: SvgPicture.asset(AssetsSVG.next, color: MyColors.mainColor)),
        ),
        leadingWidth: 80,
        actions: [
          SvgPicture.asset(
            AssetsSVG.logoIcon,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Invoice Details'.tr(),
                  style: const TextStyle(
                    fontSize: 23.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: MyColors.scaffoldColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _titleValueWidget('Invoice Type'.tr(), '${inVoiceModel.type}'),
                      _titleValueWidget('Status'.tr(), '${inVoiceModel.status}'),
                      _titleValueWidget('Reference'.tr(), inVoiceModel.reference.toString()),
                      _titleValueWidget('Release Date'.tr(), inVoiceModel.issueDate.toString()),
                      _titleValueWidget('Expiry Date'.tr(), inVoiceModel.dueAmount.toString()),
                      _titleValueWidget('Date of Supply'.tr(), inVoiceModel.issueDate.toString()),
                      _titleValueWidget('From the Location'.tr(), '${inVoiceModel.owner?.shippingAddress.shippingCity}'),
                      _titleValueWidget('Payment Method'.tr(), '${inVoiceModel.paymentMethod}'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Customer'.tr(),
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: MyColors.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${inVoiceModel.contact?.name}",
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: MyColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // const SizedBox(height: 5),
                            // const Text(
                            //   'طريق الملك عبد الله, الرياض, السعودية, 12345 --',
                            //   style: TextStyle(
                            //     fontSize: 14.0,
                            //     color: MyColors.black,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: MyColors.black,
                        height: 40,
                      ),
                      ...List.generate(inVoiceModel.lineItems?.length ?? 0, (index) {
                        return Column(
                          children: [
                            _titleValueWidget2('Product'.tr(), '${inVoiceModel.lineItems?[index].name}'),
                            _titleValueWidget2('Quantity'.tr(), '${inVoiceModel.lineItems?[index].quantity}'),
                            _titleValueWidget2('Unit Price'.tr(), '${inVoiceModel.lineItems?[index].unitPrice} ر.س'),
                            _titleValueWidget2('Discount'.tr(), '${inVoiceModel.lineItems?[index].discount} ر.س'),
                            _titleValueWidget2('Total Before Tax'.tr(), '${inVoiceModel.lineItems?[index].unitPrice} ر.س'),
                            _titleValueWidget2('${'Tax'.tr()} %', '${inVoiceModel.lineItems?[index].taxPercent}%'),
                            _titleValueWidget2('Tax Value'.tr(), '${double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") * (double.parse(inVoiceModel.lineItems?[index].taxPercent ?? "0.0") / 100)} ر.س'),
                            _titleValueWidget2('Total'.tr(), '${double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") + double.parse(inVoiceModel.lineItems?[index].unitPrice ?? "0.0") * (double.parse(inVoiceModel.lineItems?[index].taxPercent ?? "0.0") / 100)} ر.س'),
                            const Divider(
                              thickness: 0.5,
                              color: MyColors.black,
                              height: 40,
                            ),
                          ],
                        );
                      }),
                      _titleValueWidget3('${'Total Before Tax'.tr()}:', '--	4,200.00 ر.س'),
                      _titleValueWidget3('${'Tax Value'.tr()}:', '--	630.00 ر.س'),
                      _titleValueWidget3('${'Total'.tr()}:', '	${inVoiceModel.total} ر.س'),
                      _titleValueWidget3('${'Deserved Amount'.tr()}:', '	${inVoiceModel.paidAmount} ر.س'),
                      const Divider(
                        thickness: 0.5,
                        color: MyColors.black,
                        height: 40,
                      ),
                      BlocBuilder<ExportsCubit, ExportsState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: ExportsCubit.get(context).isExportingPDF != true,
                            child: CustomButton(
                              text: 'Download PDF'.tr(),
                              onPressed: () async {
                                // ignore: use_build_context_synchronously
                                await ExportsCubit.get(context).downloadInvoice(context, inVoiceModel);
                              },
                              color: MyColors.black,
                              width: 120,
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleValueWidget(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.black,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleValueWidget2(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            height: 2.43,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.black,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _titleValueWidget3(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            color: MyColors.black,
            fontWeight: FontWeight.w600,
            height: 2.43,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.0,
              color: MyColors.mainColor,
              fontWeight: FontWeight.w600,
              height: 2.43,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
