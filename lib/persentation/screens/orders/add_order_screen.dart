import 'dart:developer';

import 'package:app/business_logic/orders/cubit/orders_cubit.dart';
import 'package:app/business_logic/products/cubit/products_cubit.dart';
import 'package:app/business_logic/profile/cubit/profile_cubit.dart';
import 'package:app/data/constants/api_constants.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/functions/functions.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/branche/branche_model.dart';
import 'package:app/models/product/product_model.dart';
import 'package:app/models/selected_products/selected_products.dart';
import 'package:app/persentation/screens/orders/order_done_screen.dart';
import 'package:app/persentation/screens/orders/products_screen.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:app/persentation/widgets/buttons.dart';
import 'package:app/persentation/widgets/image_loading.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddOrderScreen extends StatefulWidget {
  AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'New Purchase Order'.tr(),
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _form(context),
                    const SizedBox(height: 20),
                    _addProductButton(context),
                    const SizedBox(height: 10),
                    ...SelectedProductsModel.selectedProducts.map((product) {
                      return _productsDtails(product, context);
                    }),
                    const SizedBox(height: 10),
                    if (SelectedProductsModel.selectedProducts.isNotEmpty) _footer(context),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container _productCard(ProductModel productModel, BuildContext context) {
    return Container(
      width: 377.0,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 71.0,
            height: 70.0,
            child: loadingImage(
              image: ApiConstants.stoarge + productModel.picture,
              boxFit: BoxFit.cover,
              borderRadius: BorderRadius.circular(14.0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.nameAr,
                  style: const TextStyle(fontSize: 13.0, color: Colors.black, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
                Text(
                  productModel.description,
                  style: const TextStyle(fontSize: 11.0, color: Color(0xFF7B7B7B), overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
                Text(
                  '${productModel.customers?.first.pivot.price} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _footer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 80),
      constraints: const BoxConstraints(minHeight: 262, minWidth: double.infinity),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
        color: MyColors.mainColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${ProductsCubit.get(context).totalPrice} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${ProductsCubit.get(context).totalTax} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${ProductsCubit.get(context).totalPrice} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 30),
              OrdersCubit.get(context).isLoadingAction
                  ? MyLoadingTransperant(
                      color: Colors.white,
                    )
                  : GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (SelectedProductsModel.selectedProducts.isEmpty) {
                            showMessage(context: context, message: 'Please Select A Product'.tr(), color: MyColors.black);
                          } else {
                            await OrdersCubit.get(context).addOrder(
                              context: context,
                              dateTime: selectedDate,
                              brancheModel: OrdersCubit.get(context).selectedBranch!,
                              address: addressController.text,
                            );
                          }
                        }
                      },
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 150, minHeight: 45),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Confirmation'.tr(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Transform.flip(
                                flipX: context.locale.languageCode == 'en' ? true : false,
                                child: SvgPicture.asset(
                                  AssetsSVG.next,
                                  color: Colors.black,
                                  width: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _productsDtails(SelectedProductsModel selectedProductsModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          _productCard(selectedProductsModel.productModel, context),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Quantity'.tr(),
              style: const TextStyle(
                fontSize: 22.0,
                color: MyColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 319.0,
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: MyColors.scaffoldColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    ProductsCubit.get(context).addQtyProduct(context, selectedProductsModel.productModel);
                  },
                  child: SvgPicture.asset(
                    AssetsSVG.add,
                    color: MyColors.mainColor,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${selectedProductsModel.qty}',
                  style: const TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    ProductsCubit.get(context).qtyMinusProduct(context, selectedProductsModel.productModel);
                  },
                  child: SvgPicture.asset(
                    AssetsSVG.minus,
                    color: MyColors.mainColor,
                    width: 25,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Price'.tr(),
              style: const TextStyle(
                fontSize: 22.0,
                color: MyColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 319.0,
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: MyColors.scaffoldColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${selectedProductsModel.productModel.customers?.first.pivot.price} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _form(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsetsDirectional.only(
          start: 30,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30),
            bottomStart: Radius.circular(30),
          ),
          color: MyColors.scaffoldColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'Date'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  currentDate: selectedDate,
                  lastDate: DateTime.now().add(const Duration(days: (365 * 5))),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: MyColors.mainColor,
                          surfaceTint: Colors.white,
                        ),
                        textTheme: const TextTheme(
                          button: TextStyle(fontFamily: MyFonts.font),
                          headlineLarge: TextStyle(fontFamily: MyFonts.font),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate = value;
                      dateController.text = formatDate(context, value);
                    });
                  }
                });
              },
              child: CustomTextFormField(
                text: 'Select the invoice date'.tr(),
                controller: dateController,
                isFilld: true,
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none,
                enabled: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Select the invoice date'.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'Branches'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: MyColors.scaffoldColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                height: 5,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: MyColors.black,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ...List.generate(
                                ProfileCubit.get(context).userModel?.branches?.length ?? 0,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        OrdersCubit.get(context).selectBranch(ProfileCubit.get(context).userModel!.branches![index]);
                                        branchController.text = OrdersCubit.get(context).selectedBranch?.name ?? '';
                                      });
                                      MyNavigator.back(context);
                                    },
                                    child: Container(
                                      width: 293.0,
                                      height: 43.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32.0),
                                        color: OrdersCubit.get(context).selectedBranch == ProfileCubit.get(context).userModel!.branches![index] ? MyColors.black : null,
                                        border: Border.all(
                                          width: 0.5,
                                          color: MyColors.black,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          ProfileCubit.get(context).userModel!.branches![index].name,
                                          style: TextStyle(color: OrdersCubit.get(context).selectedBranch == ProfileCubit.get(context).userModel!.branches![index] ? Colors.white : MyColors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: CustomTextFormField(
                text: 'Select the institution'.tr(),
                controller: branchController,
                isFilld: true,
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(37),
                borderSide: BorderSide.none,
                enabled: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please select the institution'.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15),
              child: Text(
                'Location'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              text: 'Choose the city of receipt'.tr(),
              controller: addressController,
              isFilld: true,
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(37),
              borderSide: BorderSide.none,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Choose the city of receipt'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  GestureDetector _addProductButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyNavigator.navigateTo(context, const ProductsScreen());
      },
      child: Container(
        width: 319.0,
        height: 55.0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27.0),
          color: MyColors.mainColor,
          border: Border.all(
            width: 0.5,
            color: const Color(0xFFDADBDD),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Product'.tr(),
              style: const TextStyle(
                fontSize: 14,
                color: MyColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SvgPicture.asset(
              AssetsSVG.add,
              width: 25.0,
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
