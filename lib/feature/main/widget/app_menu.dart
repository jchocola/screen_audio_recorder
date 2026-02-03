import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/app_text/app_text.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/feature/main/modal/app_info_modal.dart';
import 'package:recorder_app/feature/main/modal/language_modal.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';
import 'package:recorder_app/main.dart';
import 'package:recorder_app/shared/app_logo.dart';
import 'package:url_launcher/url_launcher.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void onAboutAppTapped() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => AppInfoModal(),
      );
    }

     void onLanguageTapped() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => LanguageModal(),
      );
    }

    Future<void> onLegalInfoTapped() async {
      if (!await launchUrl(Uri.parse(AppConstant.pravicyPolicyUrl))) {
        logger.e('Failed to launch ');
      }
    }

    return Row(
      spacing: AppConstant.appPadding,
      children: [
        AppLogo(),
        BlocBuilder<RecorderBloc, RecorderBlocState>(
          builder: (context, state) {
            if (state is RecorderBlocState_recordingAudio) {
              return Text(
                context.tr(AppText.audio_recording),
                style: theme.textTheme.titleMedium,
              );
            } else if (state is RecorderBlocState_recordingScreen) {
              return Text(
                context.tr(AppText.screen_recording),
                style: theme.textTheme.titleMedium,
              );
            } else {
              return Text(
                context.tr(AppText.simple_recoder),
                style: theme.textTheme.titleMedium,
              );
            }
          },
        ),
        Spacer(),

        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                 onTap: onLanguageTapped,
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [
                    Icon(AppIcon.languageIcon),
                    Text(context.tr(AppText.language)),
                  ],
                ),
              ),

              PopupMenuItem(
                onTap: onLegalInfoTapped,
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [
                    Icon(AppIcon.legalInfoIcon),
                    Text(context.tr(AppText.legal_info)),
                  ],
                ),
              ),

              PopupMenuItem(
                onTap: onAboutAppTapped,
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [
                    Icon(AppIcon.infoIcon),
                    Text(context.tr(AppText.about)),
                  ],
                ),
              ),
            ];
          },
          child: Icon(AppIcon.settingIcon),
        ),
      ],
    );
  }
}
