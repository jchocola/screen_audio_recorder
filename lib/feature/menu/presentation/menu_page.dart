import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
import 'package:recorder_app/core/icon/app_icon.dart';
import 'package:recorder_app/core/snack_bar/show_error_snackbar.dart';
import 'package:recorder_app/core/snack_bar/show_success_snackbar.dart';
import 'package:recorder_app/feature/menu/widget/app_menu.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';
import 'package:recorder_app/feature/recorder/presentation/recording_bar.dart';
import 'package:recorder_app/main.dart';
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
                          modeName: 'Record Screen',
                          icon: AppIcon.recordIcon,
                          isSelected: state.isRecordScreen,
                          onTap: () => context.read<RecorderBloc>().add(
                            RecorderBlocEvent_pickRecordScreen(),
                          ),
                        ),
                        ModeCard(
                          modeName: 'Record Audio',
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
                      title: 'Start Recording',
                      onTap: () => context.read<RecorderBloc>().add(
                        RecorderBlocEvent_startRecordingTapped(),
                      ),
                    ),
                  ],
                );
              } else if (state is RecorderBlocState_recordingAudio) {
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
          title: 'Audio',
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
                    ? 'Audio Channel - Mono'
                    : 'Audio Channel - Stereo'
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
