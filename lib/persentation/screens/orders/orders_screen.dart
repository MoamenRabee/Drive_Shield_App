import 'dart:developer';

import 'package:app/business_logic/orders/cubit/orders_cubit.dart';
import 'package:app/business_logic/translation/cubit/translation_cubit.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/persentation/screens/orders/add_order_screen.dart';
import 'package:app/persentation/screens/orders/order_details_screen.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    OrdersCubit.get(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationCubit, TranslationState>(
      builder: (context, state) {
        return MyScaffold(
          widgetTitle: GestureDetector(
            onTap: () {
              MyNavigator.navigateTo(context, AddOrderScreen());
            },
            child: SvgPicture.asset(
              AssetsSVG.add,
              // width: 38.0,
              // height: 38.0,
            ),
          ),
          body: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return OrdersCubit.get(context).isLoadingData
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
                        return CardOrderWidget(orderModel: OrdersCubit.get(context).allOrders[index]);
                      },
                      itemCount: OrdersCubit.get(context).allOrders.length,
                    );
            },
          ),
        );
      },
    );
  }
}

class CardOrderWidget extends StatelessWidget {
  CardOrderWidget({
    super.key,
    required this.orderModel,
  });

  OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, OrderDetailsScreen(orderModel: orderModel));
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
                  'Order Number'.tr(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  orderModel.id.toString(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              '${orderModel.customer?.name}',
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
                  '${orderModel.totalWithTax} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 13.0,
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
                  formatDate(context, orderModel.createdAt),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                '${orderModel.status}'.tr(),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF7B7B7B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
