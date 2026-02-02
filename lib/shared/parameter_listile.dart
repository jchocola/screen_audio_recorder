import 'package:flutter/material.dart';
import 'package:recorder_app/shared/custom_switch.dart';

class ParameterListile extends StatelessWidget {
  const ParameterListile({
    super.key,
    this.title = '',
    this.switchValue = false,
    this.onSwitchChanged,
  });
  final String title;
  final bool switchValue;
  final void Function(bool)? onSwitchChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        CustomSwitch(value: switchValue, onChanged: onSwitchChanged),
      ],
    );
  }
}
