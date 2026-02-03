import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';

class RecordingParameters extends StatelessWidget {
  const RecordingParameters({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RecorderBloc, RecorderBlocState>(
      builder: (context, state) => Row(
        children: [
          Text(
            state is RecorderBlocState_recordingAudio
                ? state.elapsed.toString()
                : '',
          ),
          Spacer(),

          state is RecorderBlocState_recordingAudio
              ? Icon(AppIcon.enableAudioIcon, color: theme.colorScheme.primary,)
              : Container(),
        ],
      ),
    );
  }
}
