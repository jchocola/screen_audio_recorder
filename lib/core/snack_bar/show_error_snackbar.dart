import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, {required String content}) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: theme.colorScheme.error,
    content: Text(content, style: theme.textTheme.bodySmall,)));
}
