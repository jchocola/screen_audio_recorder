
import 'package:fft_recorder_ui/fft_recorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/feature/recorder/bloc/recorder_bloc.dart';

class AudioWave extends StatelessWidget {
  const AudioWave({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
        final controller = context.read<RecorderBloc>().fftRecorderController;
    return ValueListenableBuilder<List<double>>(
      valueListenable: controller.fftData,
      builder:(conttext,data,_)=> BarVisualizer(
        data: data,
        barCount: 32,
        barColor: theme.colorScheme.primary,
        barWidth: 4,
        maxHeight: 60,
        spacing: 6,
        emptyText: 'Waiting for FFT data',
      ),
    );
  }
}
