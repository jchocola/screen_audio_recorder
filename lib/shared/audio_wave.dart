import 'package:fft_recorder_ui/fft_recorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';

class AudioWave extends StatelessWidget {
  const AudioWave({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BarVisualizer(
      data: context.watch<RecorderBloc>().fftRecorderController .fftData.value,
      barCount: 64,
      barColor: Colors.white,
      barWidth: size.width * 0.5,
      maxHeight: 60,
      spacing: 6,
      emptyText: 'Waiting for FFT data',
    );
  }
}
