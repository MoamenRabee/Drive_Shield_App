import 'dart:developer';

import 'package:app/data/constants/api_constants.dart';
import 'package:app/data/constants/assets.dart';
import 'package:app/data/constants/order_status.dart';
import 'package:app/helpers/my_navigation.dart';
import 'package:app/models/order/order_model.dart';
import 'package:app/models/order_item/order_item_model.dart';
import 'package:app/persentation/screens/notifications/notifications_screen.dart';
import 'package:app/persentation/widgets/header.dart';
import 'package:app/persentation/widgets/image_loading.dart';
import 'package:app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderModel});

  final OrderModel orderModel;

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
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Order Details'.tr(),
                  style: const TextStyle(
                    fontSize: 23.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: MyColors.scaffoldColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(orderModel.orderItems?.length ?? 0, (index) {
                        return _productCard(orderModel.orderItems![index], context);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _detailsCard(),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 377.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: MyColors.gray.withOpacity(0.4),
                  ),
                  child: Column(
                    children: [
                      if (orderModel.status == OrderStatus.draft || orderModel.status == OrderStatus.approved)
                        timeLineItemWidget(
                          text: 'Pending'.tr(),
                          color: MyColors.green,
                        ),
                      if (orderModel.status == OrderStatus.draft || orderModel.status == OrderStatus.approved)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            timeLineItemWidget(
                              text: 'Been Approved'.tr(),
                              color: (orderModel.status == OrderStatus.approved) ? MyColors.green : Colors.grey,
                            ),
                            timeLineItemWidget(
                              text: 'The Order Has Been Delivered To The Representative'.tr(),
                              color: (orderModel.status == OrderStatus.approved && orderModel.shippingStatus == OrderShippingStatus.received || orderModel.shippingStatus == OrderShippingStatus.processing || orderModel.shippingStatus == OrderShippingStatus.delivered || orderModel.shippingStatus == OrderShippingStatus.delivered) ? MyColors.green : Colors.grey,
                            ),
                            timeLineItemWidget(
                              text: 'The Order Is Being Prepared'.tr(),
                              color: (orderModel.status == OrderStatus.approved && (orderModel.shippingStatus == OrderShippingStatus.processing || orderModel.shippingStatus == OrderShippingStatus.delivered || orderModel.shippingStatus == OrderShippingStatus.delivered)) ? MyColors.green : Colors.grey,
                            ),
                            timeLineItemWidget(
                              text: 'Delivery Is In Progress'.tr(),
                              color: (orderModel.status == OrderStatus.approved && (orderModel.shippingStatus == OrderShippingStatus.delivery || orderModel.shippingStatus == OrderShippingStatus.delivered)) ? MyColors.green : Colors.grey,
                            ),
                            timeLineItemWidget(
                              text: 'Delivered'.tr(),
                              color: (orderModel.status == OrderStatus.approved && (orderModel.shippingStatus == OrderShippingStatus.delivered)) ? MyColors.green : Colors.grey,
                            ),
                          ],
                        )
                      else if (orderModel.status == OrderStatus.declined)
                        timeLineItemWidget(
                          text: 'Declined'.tr(),
                          color: MyColors.mainColor,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget timeLineItemWidget({required String text, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(
            '<svg viewBox="0.0 0.0 16.4 13.89" ><path transform="translate(0.0, -36.4)" d="M 13.69132137298584 44.02590179443359 C 13.65193462371826 44.00603485107422 13.6124792098999 43.99612045288086 13.57271289825439 43.99612045288086 C 13.48709964752197 43.99612045288086 13.4116792678833 44.02897262573242 13.34596633911133 44.09482955932617 L 12.71461200714111 44.72607803344727 C 12.65560150146484 44.78532791137695 12.62595748901367 44.85757064819336 12.62595748901367 44.94315338134766 L 12.62595748901367 47.44842910766602 C 12.62595748901367 47.88254165649414 12.47176361083984 48.25391387939453 12.16247844696045 48.56312942504883 C 11.85343360900879 48.87217330932617 11.48182201385498 49.02671432495117 11.04777717590332 49.02671432495117 L 2.840855121612549 49.02671432495117 C 2.406776905059814 49.02671432495117 2.03519868850708 48.87217330932617 1.726154804229736 48.56312942504883 C 1.417041659355164 48.25394439697266 1.262571454048157 47.88257598876953 1.262571454048157 47.44842910766602 L 1.262571454048157 39.24167633056641 C 1.262571454048157 38.80767059326172 1.417041659355164 38.43612289428711 1.726154804229736 38.12697982788086 C 2.03519868850708 37.81789779663086 2.406777143478394 37.66339492797852 2.840855121612549 37.66339492797852 L 11.04784774780273 37.66339492797852 C 11.19253921508789 37.66339492797852 11.34047985076904 37.68312454223633 11.49170303344727 37.72261428833008 C 11.53119373321533 37.73567199707031 11.56076717376709 37.74234008789062 11.5802526473999 37.74234008789062 C 11.66586589813232 37.74234008789062 11.74152946472168 37.70955276489258 11.80724239349365 37.64380645751953 L 12.29058742523193 37.16046142578125 C 12.36942958831787 37.0816535949707 12.39914131164551 36.98622894287109 12.37924098968506 36.87453079223633 C 12.35951232910156 36.76929473876953 12.30026054382324 36.69363021850586 12.20162391662598 36.64764022827148 C 11.84673309326172 36.48346710205078 11.46185302734375 36.40099716186523 11.04757213592529 36.40099716186523 L 2.840855121612549 36.40099716186523 C 2.058312177658081 36.40099716186523 1.38916015625 36.6788444519043 0.833468496799469 37.23453521728516 C 0.2778457999229431 37.79029846191406 -7.090414300137127e-08 38.45934677124023 -7.090414300137127e-08 39.24192428588867 L -7.090414300137127e-08 47.44887924194336 C -7.090414300137127e-08 48.23131942749023 0.2778457999229431 48.90043258666992 0.8335031270980835 49.45612716674805 C 1.389194965362549 50.01195526123047 2.058346748352051 50.28980255126953 2.840889930725098 50.28980255126953 L 11.04777812957764 50.28980255126953 C 11.8302173614502 50.28980255126953 12.49943828582764 50.01195526123047 13.05513095855713 49.45612716674805 C 13.61085605621338 48.90043258666992 13.88894462585449 48.23134994506836 13.88894462585449 47.44887924194336 L 13.88894462585449 44.31189727783203 C 13.88887500762939 44.17391204833984 13.82278251647949 44.07862091064453 13.69132137298584 44.02590179443359 Z" fill="#23cb15" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-70.84, -54.31)" d="M 87.00633239746094 56.27785873413086 L 85.92117309570312 55.19269561767578 C 85.76335906982422 55.03490829467773 85.57582855224609 54.95600128173828 85.35874176025391 54.95600128173828 C 85.14195251464844 54.95600128173828 84.95428466796875 55.03490829467773 84.79659271240234 55.19269561767578 L 78.4144287109375 61.57482528686523 L 75.82033538818359 58.98054885864258 C 75.66246795654297 58.82265853881836 75.47501373291016 58.74385452270508 75.25807189941406 58.74385452270508 C 75.04109954833984 58.74385452270508 74.85370635986328 58.82265853881836 74.69581604003906 58.98054885864258 L 73.61078643798828 60.06557083129883 C 73.45297241210938 60.22339248657227 73.37399291992188 60.41085433959961 73.37399291992188 60.62793350219727 C 73.37399291992188 60.84489822387695 73.45297241210938 61.03229904174805 73.61078643798828 61.19018936157227 L 77.85231781005859 65.43170166015625 C 78.01016998291016 65.58963012695312 78.1976318359375 65.66841125488281 78.41457366943359 65.66841125488281 C 78.63151550292969 65.66841125488281 78.81893920898438 65.58967590332031 78.97682952880859 65.43170166015625 L 87.00623321533203 57.4023323059082 C 87.16395568847656 57.24454879760742 87.24303436279297 57.05704879760742 87.24303436279297 56.8400764465332 C 87.24303436279297 56.62311172485352 87.16416168212891 56.43564224243164 87.00633239746094 56.27785873413086 Z" fill="#23cb15" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
            width: 16.4,
            height: 13.89,
            color: color,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _detailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 400.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: MyColors.gray.withOpacity(0.4),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${orderModel.total} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(
            height: 20,
            color: MyColors.black,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${orderModel.totalTax} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(
            height: 20,
            color: MyColors.black,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (Including Tax)'.tr(),
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${orderModel.totalWithTax} ${'SAR'.tr()}',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _productCard(OrderItemModel orderItemModel, BuildContext context) {
    return Container(
      width: 377.0,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
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
              image: ApiConstants.stoarge + orderItemModel.product.picture,
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
                  orderItemModel.product.nameAr.toString(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  orderItemModel.product.description.toString(),
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF7B7B7B),
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '${orderItemModel.unitPrice} ${'SAR'.tr()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            double.parse(orderItemModel.quantity.toString()).toInt().toString(),
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
