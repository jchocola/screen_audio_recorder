import 'package:flutter/material.dart';
import 'package:recorder_app/core/icon/app_icon.dart';

class RecordingParameters extends StatelessWidget {
  const RecordingParameters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('0:04:43'),
        Spacer(),
        Icon(AppIcon.recordIcon),
        Icon(AppIcon.enableAudioIcon),
        
      ],
    );
  }
}
