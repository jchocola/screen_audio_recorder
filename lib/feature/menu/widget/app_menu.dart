import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';
import 'package:recorder_app/shared/app_logo.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.appPadding,
      children: [
        AppLogo(),
        BlocBuilder<RecorderBloc, RecorderBlocState>(
          builder: (context, state) {
            if (state is RecorderBlocState_recordingAudio) {
              return Text(
                'Audio Recording',
                style: theme.textTheme.titleMedium,
              );
            } else if (state is RecorderBlocState_recordingScreen) {
               return Text(
                'Screen Recording',
                style: theme.textTheme.titleMedium,
              );
            } else {
              return Text(
                'Simple Recorder',
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
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [Icon(AppIcon.languageIcon), Text('Language')],
                ),
              ),

              PopupMenuItem(
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [Icon(AppIcon.legalInfoIcon), Text('Legal Info')],
                ),
              ),

              PopupMenuItem(
                child: Row(
                  spacing: AppConstant.appPadding,
                  children: [Icon(AppIcon.infoIcon), Text('About')],
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
