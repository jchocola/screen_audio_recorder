import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/app_text/app_text.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/core/snack_bar/show_error_snackbar.dart';
import 'package:recorder_app/core/snack_bar/show_success_snackbar.dart';
import 'package:recorder_app/feature/main/widget/app_menu.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';
import 'package:recorder_app/feature/recorder/presentation/recording_bar.dart';
import 'package:recorder_app/main.dart';
import 'package:recorder_app/shared/big_button.dart';
import 'package:recorder_app/shared/mode_card.dart';
import 'package:recorder_app/shared/parameter_listile.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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

          BlocConsumer<RecorderBloc, RecorderBlocState>(
            listener: (context, state) {
              if (state is RecorderBlocState_success) {
                showSuccessSnackbar(context, content: state.note);
              }

              if (state is RecorderBlocState_error) {
                showErrorSnackbar(context, content: state.error);
              }
            },

            builder: (context, state) {
              if (state is RecorderBlocState_preparing) {
                return Column(
                  spacing: AppConstant.appPadding,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        ModeCard(
                          modeName: context.tr(AppText.record_screen),
                          icon: AppIcon.recordIcon,
                          isSelected: state.isRecordScreen,
                          onTap: () => context.read<RecorderBloc>().add(
                            RecorderBlocEvent_pickRecordScreen(),
                          ),
                        ),
                        ModeCard(
                          modeName: context.tr(AppText.record_audio),
                          icon: AppIcon.audioIcon,
                          isSelected: !state.isRecordScreen,
                          onTap: () => context.read<RecorderBloc>().add(
                            RecorderBlocEvent_pickRecordAudio(),
                          ),
                        ),
                      ],
                    ),

                    state.isRecordScreen
                        ? _videoRecorderParams(context)
                        : _audioRecorderParams(context),

                    BigButton(
                      title: context.tr(AppText.start_recording),
                      onTap: () => context.read<RecorderBloc>().add(
                        RecorderBlocEvent_startRecordingTapped(),
                      ),
                    ),
                  ],
                );
              } else if (state is RecorderBlocState_recordingAudio ||
                  state is RecorderBlocState_recordingScreen) {
                return RecordingBar();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

          // RecordingBar(),
        ],
      ),
    );
  }

  Widget _videoRecorderParams(BuildContext context) {
    final recorderBloc_l = context.watch<RecorderBloc>().state;
    return Column(
      children: [
        ParameterListile(
          title: recorderBloc_l is RecorderBlocState_preparing ?  recorderBloc_l.recordVideoWithAudio ? context.tr(AppText.with_audio) : context.tr(AppText.without_audio): '',
          switchValue: recorderBloc_l is RecorderBlocState_preparing
              ? recorderBloc_l.recordVideoWithAudio
              : false,
          onSwitchChanged: (_) => context.read<RecorderBloc>().add(
            RecorderBlocEvent_toogleRecordVideoWithAudio(),
          ),
        ),
      ],
    );
  }

  Widget _audioRecorderParams(BuildContext context) {
    final recorderBloc_l = context.watch<RecorderBloc>().state;
    return Column(
      children: [
        ParameterListile(
          title: recorderBloc_l is RecorderBlocState_preparing
              ? recorderBloc_l.recordChannelIsMono
                    ? context.tr(AppText.mono)
                    : context.tr(AppText.stereo)
              : '',
          switchValue: recorderBloc_l is RecorderBlocState_preparing
              ? recorderBloc_l.recordChannelIsMono
              : false,
          onSwitchChanged: (_) => context.read<RecorderBloc>().add(
            RecorderBlocEvent_toogleAudioChannelValue(),
          ),
        ),
      ],
    );
  }
}
