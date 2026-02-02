// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:fft_recorder_ui/fft_recorder_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

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

class RecorderBlocEvent_startRecordingTapped extends RecorderBlocEvent {}

class RecorderBlocEvent_stopRecordingTapped extends RecorderBlocEvent {}

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
  RecorderBlocState_preparing({
    required this.isRecordScreen,
    required this.recordVideoWithAudio,
  });

  RecorderBlocState_preparing copyWith({
    bool? isRecordScreen,
    bool? recordVideoWithAudio,
  }) {
    return RecorderBlocState_preparing(
      isRecordScreen: isRecordScreen ?? this.isRecordScreen,
      recordVideoWithAudio: recordVideoWithAudio ?? this.recordVideoWithAudio,
    );
  }

  @override
  List<Object?> get props => [isRecordScreen, recordVideoWithAudio];
}

class RecorderBlocState_loading extends RecorderBlocState {}

class RecorderBlocState_recordingAudio extends RecorderBlocState {}

class RecorderBlocState_recordingScreen extends RecorderBlocState {}

///
/// BLOC
///
class RecorderBloc extends Bloc<RecorderBlocEvent, RecorderBlocState> {
  final FftRecorderController fftRecorderController = FftRecorderController();
  RecorderBloc()
    : super(
        RecorderBlocState_preparing(
          isRecordScreen: true,
          recordVideoWithAudio: true,
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
    /// START RECORDING TAPPED
    ///
    on<RecorderBlocEvent_startRecordingTapped>((event, emit) async {
      final currentState = state;
      if (currentState is RecorderBlocState_preparing) {
        try {
          if (currentState.isRecordScreen) {
            ///
            /// RECORD SCREEN
            ///
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

              emit(RecorderBlocState_recordingAudio());
            } else {
              log('Microphone denied');
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
          await fftRecorderController.stopRecording();

          emit(
            RecorderBlocState_preparing(
              isRecordScreen: false,
              recordVideoWithAudio: true,
            ),
          );
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }
}
