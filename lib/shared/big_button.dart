import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/theme/app_color.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    this.color = AppColor.green,
    this.onTap,
    this.title = '',
    this.isNegative = false
  });
  final Color color;
  final void Function()? onTap;
  final String title;
  final bool isNegative;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppConstant.appPadding),
        decoration: BoxDecoration(
          border: isNegative ? Border.all(color: theme.colorScheme.error , width: 2) : null,
          borderRadius: BorderRadius.circular(AppConstant.appBorder , ),
          color: isNegative ? Colors.transparent : color , 
        ),
        child: Center(child: Text(title, style: theme.textTheme.titleMedium)),
      ),
    );
  }
}
