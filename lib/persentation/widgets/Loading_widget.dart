import 'package:app/data/constants/assets.dart';
import 'package:app/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// class MyLoading extends StatelessWidget {
//   const MyLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(Assets.loading);
//   }
// }

class MyLoadingTransperant extends StatelessWidget {
  MyLoadingTransperant({super.key, this.color});

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GifView.asset(
        'assets/images/loading.gif',
        height: 80,
        width: 80,
        frameRate: 30, // default is 15 FPS
      ),
    );
  }
}
