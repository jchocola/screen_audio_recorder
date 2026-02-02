import 'package:flutter/material.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/shared/audio_recording_parameters.dart';
import 'package:recorder_app/shared/audio_wave.dart';
import 'package:recorder_app/shared/big_button.dart';

class RecordingBar extends StatelessWidget {
  const RecordingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        RecordingParameters(),
        AudioWave(),  BigButton(title: 'Stop Recording',), BigButton(isNegative: true, title: 'Hold to delete record',)],
    );
  }
}
