import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';

class ModeCard extends StatelessWidget {
  const ModeCard({super.key, this.modeName = '', this.icon = Icons.abc, this.isSelected = false});
  final String modeName;
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
        border: Border.all(color: isSelected ? theme.colorScheme.primary : Colors.transparent, width: 2)),
      padding: EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        children: [
          Icon(icon, size: AppConstant.bigIcon),
          Text(modeName, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
