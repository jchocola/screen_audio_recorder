import 'package:flutter/material.dart';

void showSuccessSnackbar(BuildContext context, {required String content}) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: theme.colorScheme.primary,
    content: Text(content, style: theme.textTheme.bodySmall,)));
}
