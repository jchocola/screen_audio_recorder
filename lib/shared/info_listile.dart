import 'package:flutter/material.dart';


class InfoListile extends StatelessWidget {
  const InfoListile({
    super.key,
    this.title = '',
   this.value = '',

  });
  final String title;
    final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleSmall),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
