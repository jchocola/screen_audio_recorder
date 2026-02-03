// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fft_recorder_ui/fft_recorder_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recorder/flutter_recorder.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:path_provider/path_provider.dart';

import 'package:recorder_app/main.dart';

///
/// EVENT
///
abstract class RecorderBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecorderBlocEvent_pickRecordAudio extends RecorderBlocEvent {}

class RecorderBlocEvent_pickRecordScreen extends RecorderBlocEvent {}

class RecorderBlocEvent_toogleRecordVideoWithAudio extends RecorderBlocEvent {}

class RecorderBlocEvent_toogleAudioChannelValue extends RecorderBlocEvent {}

class RecorderBlocEvent_startRecordingTapped extends RecorderBlocEvent {}

class RecorderBlocEvent_stopRecordingTapped extends RecorderBlocEvent {}

class RecorderBlocEvent_tick extends RecorderBlocEvent {}

///
/// STATE
///
abstract class RecorderBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecorderBlocState_preparing extends RecorderBlocState {
  final bool isRecordScreen;
  final bool recordVideoWithAudio;
  final bool recordChannelIsMono;
  RecorderBlocState_preparing({
    required this.isRecordScreen,
    required this.recordVideoWithAudio,
    required this.recordChannelIsMono,
  });

  RecorderBlocState_preparing copyWith({
    bool? isRecordScreen,
    bool? recordVideoWithAudio,
    bool? recordChannelIsMono,
  }) {
    return RecorderBlocState_preparing(
      isRecordScreen: isRecordScreen ?? this.isRecordScreen,
      recordVideoWithAudio: recordVideoWithAudio ?? this.recordVideoWithAudio,
      recordChannelIsMono: recordChannelIsMono ?? this.recordChannelIsMono,
    );
  }

  @override
  List<Object?> get props => [
    isRecordScreen,
    recordVideoWithAudio,
    recordChannelIsMono,
  ];
}

class RecorderBlocState_loading extends RecorderBlocState {}

class RecorderBlocState_recordingAudio extends RecorderBlocState {
  final Duration elapsed;
  RecorderBlocState_recordingAudio({required this.elapsed});

  @override
  List<Object?> get props => [elapsed];
}

class RecorderBlocState_recordingScreen extends RecorderBlocState {
  final bool withAudio;
  RecorderBlocState_recordingScreen({
    required this.withAudio,
  });
  @override
  List<Object?> get props => [withAudio];
}

class RecorderBlocState_success extends RecorderBlocState {
  final String note;
  RecorderBlocState_success({required this.note});
  @override
  List<Object?> get props => [note];
}

class RecorderBlocState_error extends RecorderBlocState {
  final String error;
  RecorderBlocState_error({required this.error});
  @override
  List<Object?> get props => [error];
}

///
/// BLOC
///
class RecorderBloc extends Bloc<RecorderBlocEvent, RecorderBlocState> {
  FftRecorderController fftRecorderController = FftRecorderController();
  // private timer and elapsed tracker
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  RecorderBloc()
    : super(
        RecorderBlocState_preparing(
          isRecordScreen: true,
          recordVideoWithAudio: true,
          recordChannelIsMono: true,
        ),
      ) {
    ///
    /// PICK RECORD AUDIO
    ///
    on<RecorderBlocEvent_pickRecordAudio>((event, emit) {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          emit(currentState.copyWith(isRecordScreen: false));
        } catch (e) {
          log(e.toString());
        }
      }
    });

    ///
    /// PICK RECORD SCREEN
    ///
    on<RecorderBlocEvent_pickRecordScreen>((event, emit) {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          emit(currentState.copyWith(isRecordScreen: true));
        } catch (e) {
          log(e.toString());
        }
      }
    });

    ///
    /// TOOGLE RECORD VIDEO WITH AUDIO
    ///
    on<RecorderBlocEvent_toogleRecordVideoWithAudio>((event, emit) {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          final currentValue = currentState.recordVideoWithAudio;

          emit(currentState.copyWith(recordVideoWithAudio: !currentValue));
        } catch (e) {
          log(e.toString());
        }
      }
    });

    ///
    /// TOOGLE RECORD CHANNEL
    ///
    on<RecorderBlocEvent_toogleAudioChannelValue>((event, emit) {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          final isMono = currentState.recordChannelIsMono;

          emit(currentState.copyWith(recordChannelIsMono: !isMono));

          logger.d('Audio Channel : ${!isMono}');

          fftRecorderController = FftRecorderController(
            channels: !isMono ? RecorderChannels.mono : RecorderChannels.stereo,
          );
        } catch (e) {
          log(e.toString());
        }
      }
    });

    on<RecorderBlocEvent_tick>((event, emit) {
      _elapsed = _elapsed + const Duration(seconds: 1);
      emit(RecorderBlocState_recordingAudio(elapsed: _elapsed));
    });

    ///
    /// START RECORDING TAPPED
    ///
    on<RecorderBlocEvent_startRecordingTapped>((event, emit) async {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          final filename = DateTime.now().toIso8601String();

          if (currentState.isRecordScreen) {
            ///
            /// RECORD SCREEN
            ///
            logger.f('Record screen');
            bool started = false;

            if (currentState.recordVideoWithAudio) {
              // 1) RECORD SCREEN WITH AUDIO
              started = await FlutterScreenRecording.startRecordScreenAndAudio(
                filename,
              );
            } else {
              //1.b ) RECORD SCREEN WITHOUT AUDIO
              started = await FlutterScreenRecording.startRecordScreen(
                filename,
              );
            }

            if (started) {
              emit(RecorderBlocState_recordingScreen(withAudio: currentState.recordVideoWithAudio));
            }
          } else {
            ///
            /// RECORD AUDIO
            ///
            //1) REQUEST MICROPHONE
            final status = await fftRecorderController.requestMicPermission();

            if (status == true) {
              final dir = await getDownloadsDirectory();
              final filename = DateTime.now().toIso8601String() + '.wav';
              final fileDir = dir!.path + '/${filename}';
              // Start recording (auto-starts streaming)
              await fftRecorderController.startRecording(filePath: fileDir);

              // reset and start timer
              _elapsed = Duration.zero;
              emit(RecorderBlocState_recordingAudio(elapsed: _elapsed));
              _timer?.cancel();
              _timer = Timer.periodic(const Duration(seconds: 1), (_) {
                add(RecorderBlocEvent_tick());
              });
            } else {
              log('Microphone denied');
              emit(
                RecorderBlocState_error(error: 'Microphone don\'t allowed !'),
              );
              emit(currentState);
            }
          }
        } catch (e) {
          log(e.toString());
        }
      }
    });

    ///
    /// ON STOP RECORDING TAPPED
    ///
    on<RecorderBlocEvent_stopRecordingTapped>((event, emit) async {
      final currentState = state;

      ///
      /// RECORD AUDIO LOGIC
      ///
      if (currentState is RecorderBlocState_recordingAudio) {
        try {
          // stop timer first
          _timer?.cancel();
          _timer = null;

          final saveDir = await fftRecorderController.stopRecording();

          emit(RecorderBlocState_success(note: saveDir ?? ''));

          _elapsed = Duration.zero;

          emit(
            RecorderBlocState_preparing(
              isRecordScreen: false,
              recordVideoWithAudio: true,
              recordChannelIsMono: true,
            ),
          );
        } catch (e) {
          log(e.toString());
        }
      }

      ///
      /// RECORD SCREEN LOGIC
      ///
      if (currentState is RecorderBlocState_recordingScreen) {
        try {
          final saveDir = await FlutterScreenRecording.stopRecordScreen;

          emit(RecorderBlocState_success(note: saveDir));

          emit(
            RecorderBlocState_preparing(
              isRecordScreen: false,
              recordVideoWithAudio: true,
              recordChannelIsMono: true,
            ),
          );
        } catch (e) {
          logger.e(e);
        }
      }
    });

    @override
    Future<void> close() {
      _timer?.cancel();
      return super.close();
    }
  }
}
