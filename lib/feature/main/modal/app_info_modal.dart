import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recorder_app/core/app_text/app_text.dart';
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
          Text( context.tr(AppText.simple_recoder), style: theme.textTheme.titleLarge,),
          InfoListile(title: context.tr(AppText.version), value: AppConstant.appVersion),
          InfoListile(title:  context.tr(AppText.build_date), value: AppConstant.buildDate),
          InfoListile(title:  context.tr(AppText.developer), value: AppConstant.developer),
          InfoListile(title:  context.tr(AppText.support), value: AppConstant.supportEmail),
        ],
      ),
    );
  }
}
