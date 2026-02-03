import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';


class LanguageModal extends StatelessWidget {
  const LanguageModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: .center,
        children: List.generate(context.supportedLocales.length, (index) {
          final Locale locale = context.supportedLocales[index];
          return ListTile(
            onTap: () => context.setLocale(locale),
            textColor: context.locale == locale ? theme.colorScheme.primary : theme.colorScheme.secondaryFixed,
            title: Text(locale.languageCode));
        }),
      ),
    );
  }
}
