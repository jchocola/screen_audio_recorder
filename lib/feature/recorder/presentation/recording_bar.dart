import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/app_text/app_text.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';
import 'package:recorder_app/shared/recording_parameters.dart';
import 'package:recorder_app/shared/audio_wave.dart';
import 'package:recorder_app/shared/big_button.dart';

class RecordingBar extends StatelessWidget {
  const RecordingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderBloc, RecorderBlocState>(
      builder: (context, state) {
        if (state is RecorderBlocState_recordingAudio ||
            state is RecorderBlocState_recordingScreen) {
          return Column(
            spacing: AppConstant.appPadding,
            children: [
              RecordingParameters(),
              state is RecorderBlocState_recordingAudio ?  AudioWave() : Container(),
              BigButton(title: context.tr(AppText.stop_recording), onTap: ()=> context.read<RecorderBloc>().add(RecorderBlocEvent_stopRecordingTapped()),),
             // BigButton(isNegative: true, title: 'Hold to delete record'),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
