import 'dart:async';

import 'package:baapapp/constants/app_colors.dart';
import 'package:baapapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    Key? key,
    required this.secondsRemaining,
    required this.whenTimeExpires,
    required this.whenTimeSeconds,
    this.countDownFormatter,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.letterSpacing,
    this.textDecoration,
    this.textOverflow,
  }) : super(key: key);

  final int secondsRemaining;
  final VoidCallback whenTimeExpires;
  final VoidCallback whenTimeSeconds;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverflow;
  final Function(int seconds)? countDownFormatter;

  @override
  State createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Duration duration;
  late final Timer callbackTimer;

  String get timerDisplayString {
    final duration = _controller.duration! * _controller.value;
    if (widget.countDownFormatter != null) {
      return widget.countDownFormatter!(duration.inSeconds) as String;
    } else {
      return formatHHMMSS(duration.inSeconds);
    }
  }

  String formatHHMMSS(int seconds) {
    final hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final minutes = (seconds / 60).truncate();

    final hoursStr = (hours).toString().padLeft(2, '0');
    final minutesStr = (minutes).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  void initState() {
    super.initState();
    duration = Duration(seconds: widget.secondsRemaining);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller
      ..reverse(from: widget.secondsRemaining.toDouble())
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          widget.whenTimeExpires();
          callbackTimer.cancel();
        }
      });

    callbackTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      widget.whenTimeSeconds();
    });
  }

  @override
  void didUpdateWidget(CountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.secondsRemaining != oldWidget.secondsRemaining) {
      setState(() {
        duration = Duration(seconds: widget.secondsRemaining);
        _controller.dispose();
        _controller = AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller
          ..reverse(from: widget.secondsRemaining.toDouble())
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.whenTimeExpires();
              callbackTimer.cancel();
            }
          });

        callbackTimer =
            Timer.periodic(const Duration(seconds: 3), (Timer timer) {
          widget.whenTimeSeconds();
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    callbackTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, Widget? child) {
        return TextWidget(
          text: timerDisplayString,
          fontSize: widget.fontSize,
          color: widget.color ?? AppColors.blackColor,
          fontWeight: widget.fontWeight ?? FontWeight.w600,
          textAlign: widget.textAlign,
          letterSpacing: widget.letterSpacing,
          textDecoration: widget.textDecoration,
          textOverflow: widget.textOverflow,
        );
      },
    );
  }
}
