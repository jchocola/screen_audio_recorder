import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/shared/app_logo.dart';
import 'package:recorder_app/shared/info_listile.dart';

class AppInfoModal extends StatelessWidget {
  const AppInfoModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: .center,
        children: [
          AppLogo(size: 50),
          Text(AppConstant.appName, style: theme.textTheme.titleLarge,),
          InfoListile(title: 'Version', value: AppConstant.appVersion),
          InfoListile(title: 'Build Date', value: AppConstant.buildDate),
          InfoListile(title: 'Developer', value: AppConstant.developer),
          InfoListile(title: 'Support', value: AppConstant.supportEmail),
        ],
      ),
    );
  }
}
