import 'dart:io';

import 'package:app/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingImage({
  required String image,
  double? width,
  double? height,
  BorderRadius? borderRadius,
  BoxFit? boxFit,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: MyColors.mainColor,
              rightDotColor: MyColors.redColor,
              size: 15,
            ),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
  );
}

Widget loadingAssetsImage({
  required String image,
  required double width,
  required double height,
  BorderRadius? borderRadius,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Image.file(
        File(image),
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    ),
  );
}
