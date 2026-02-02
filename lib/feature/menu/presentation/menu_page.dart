import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/feature/menu/widget/app_menu.dart';
import 'package:recorder_app/shared/big_button.dart';
import 'package:recorder_app/shared/mode_card.dart';
import 'package:recorder_app/shared/parameter_listile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
      ),

      padding: EdgeInsets.all(AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          AppMenu(),

          // RecordingBar(),
          Row(
            mainAxisAlignment: .spaceAround,
            children: [
              ModeCard(
                modeName: 'Record Screen',
                icon: AppIcon.recordIcon,
                isSelected: true,
              ),
              ModeCard(modeName: 'Record Audio', icon: AppIcon.audioIcon),
            ],
          ),

          _videoRecorderParams(context),

          BigButton(title: 'Start Recording'),
        ],
      ),
    );
  }

  Widget _videoRecorderParams(BuildContext context) {
    return Column(children: [ParameterListile(title: 'Audio')]);
  }

  Widget _audioRecorderParams(BuildContext context) {
    return Column(children: [ParameterListile(title: 'Audio')]);
  }
}
