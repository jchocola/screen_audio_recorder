// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }
}
