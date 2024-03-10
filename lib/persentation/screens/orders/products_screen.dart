import 'package:app/business_logic/products/cubit/products_cubit.dart';
import 'package:app/data/constants/api_constants.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/product/product_model.dart';
import 'package:app/persentation/screens/orders/order_done_screen.dart';
import 'package:app/persentation/widgets/Loading_widget.dart';
import 'package:app/persentation/widgets/image_loading.dart';
import 'package:app/persentation/widgets/my_scaffold.dart';
import 'package:app/persentation/widgets/textFormField.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel>? searchedProducts;

  @override
  void initState() {
    if (ProductsCubit.get(context).allProducts.isEmpty) {
      ProductsCubit.get(context).getProducts();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Products'.tr(),
      iconback: true,
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 36.0,
                      height: 33.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: MyColors.mainColor,
                      ),
                      child: Padding(padding: const EdgeInsets.all(8), child: SvgPicture.asset(AssetsSVG.search)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 38,
                        child: CustomTextFormField(
                          text: 'Search'.tr(),
                          controller: searchController,
                          isFilld: true,
                          color: MyColors.whiteColor,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          borderRadius: BorderRadius.circular(20),
                          onChanged: (val) {
                            setState(() {
                              if (val != "") {
                                searchedProducts = ProductsCubit.get(context).allProducts.where((element) => element.nameAr.toLowerCase().startsWith(val.toLowerCase())).toList();
                              } else {
                                searchedProducts = null;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ProductsCubit.get(context).isLoadingData
                      ? MyLoadingTransperant()
                      : Builder(
                          builder: (context) {
                            List<ProductModel> products = searchedProducts == null ? ProductsCubit.get(context).allProducts : searchedProducts!;
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _productCard(products[index], context);
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 0.8,
                                  color: Colors.grey,
                                );
                              },
                              itemCount: products.length,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _productCard(ProductModel productModel, BuildContext context) {
    return Container(
      width: 377.0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 71.0,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
            ),
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
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  productModel.description,
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF7B7B7B),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                if (productModel.customers?.isNotEmpty ?? [].isNotEmpty)
                  Text(
                    '${productModel.customers!.first.pivot.price} ${'SAR'.tr()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ProductsCubit.get(context).selectProduct(context, productModel);
            },
            child: SvgPicture.asset(
              AssetsSVG.addRed,
              color: MyColors.mainColor,
              width: 29,
            ),
          )
        ],
      ),
    );
  }

  Container _card({
    required String title,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      constraints: const BoxConstraints(minWidth: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isActive ? MyColors.mainColor : MyColors.whiteColor,
        border: isActive
            ? null
            : Border.all(
                width: 0.5,
                color: MyColors.mainColor,
              ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10.0,
          color: isActive ? MyColors.whiteColor : MyColors.mainColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
