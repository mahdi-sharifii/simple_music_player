import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';

class PlayPauseButton extends StatefulWidget {
  bool playing;
  final int index;
  final String dataSong;

  PlayPauseButton({
    super.key,
    required this.index,
    required this.dataSong,
    required this.playing,
  });

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    widget.playing ? controller.forward() : controller.reverse();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 15,
          shadowColor: Colors.white,
          shape: const CircleBorder(),
          backgroundColor: widget.playing
              ? const Color.fromARGB(255, 140, 125, 102)
              : const Color.fromARGB(255, 245, 229, 212)),
      onPressed: () async {
        BlocProvider.of<HomeBloc>(context)
            .add(PlayPauseEvent(widget.index, widget.dataSong));
      },
      child: AnimatedIcon(
        color: widget.playing
            ? const Color.fromARGB(255, 250, 238, 222)
            : const Color.fromARGB(255, 140, 125, 102),
        icon: AnimatedIcons.play_pause,
        progress: controller,
      ),
    );
  }
}
