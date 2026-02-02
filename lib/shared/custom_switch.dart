import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, this.value = false, this.onChanged});
  final bool value;
  final void Function(bool)? onChanged;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Switch(value: value, onChanged: onChanged, inactiveThumbColor: theme.colorScheme.primaryContainer ,inactiveTrackColor: theme.colorScheme.secondary,trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),);
  }
}
