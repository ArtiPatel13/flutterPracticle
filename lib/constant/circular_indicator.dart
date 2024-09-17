

import 'package:flutter/material.dart';

import 'app_colors.dart';

class CircularIndicator extends StatelessWidget{
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(shape: BoxShape.circle, color:  AppColors.splashGreen),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

}