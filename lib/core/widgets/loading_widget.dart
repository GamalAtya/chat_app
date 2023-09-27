import '../app_theme.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
