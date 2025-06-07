import 'dart:async';
import 'package:flutter/material.dart';

class LaunchCountdown extends StatefulWidget {
  final DateTime launchDate;

  const LaunchCountdown({required this.launchDate, Key? key}) : super(key: key);

  @override
  State<LaunchCountdown> createState() => _LaunchCountdownState();
}

class _LaunchCountdownState extends State<LaunchCountdown> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.launchDate.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = widget.launchDate.difference(now);

      if (diff.isNegative) {
        _timer.cancel();
        setState(() {
          _timeLeft = Duration.zero;
        });
      } else {
        setState(() {
          _timeLeft = diff;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft == Duration.zero) {
      return Text("Launched!");
    }
    return Text(
      _formatDuration(_timeLeft),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
