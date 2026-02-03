
import 'package:fft_recorder_ui/fft_recorder_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder_app/core/constant/app_constant.dart';
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
      builder:(conttext,data,_)=> SizedBox(
        height: AppConstant.audioWaveHeight,
        child: BarVisualizer(
          data: data,
          barCount: AppConstant.barCount,
          barColor: theme.colorScheme.primary,
          barWidth: AppConstant.audioWaveWidth,
          maxHeight: AppConstant.audioWaveHeight,
          spacing: AppConstant.audioWaveSpacing,
          emptyText: 'Waiting for FFT data',
        ),
      ),
    );
  }
}
