import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomeVideoPlayer extends StatefulWidget {
  final XFile? video;
  const CustomeVideoPlayer({required this.video, super.key});

  @override
  State<CustomeVideoPlayer> createState() => _CustomeVideoPlayerState();
}

class _CustomeVideoPlayerState extends State<CustomeVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  bool showControls = false;
  bool isPlaying = false;
  var currentPos = const Duration();

  initVideoPlayerController() async {
    if (widget.video == null) {
      return const CircularProgressIndicator();
    }
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video!.path));
    await _videoPlayerController!.initialize();
  }

  @override
  void initState() {
    super.initState();
    initVideoPlayerController();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController == null) {
      return const CircularProgressIndicator();
    }
    return AspectRatio(
      aspectRatio:
          _videoPlayerController!.value.aspectRatio, // video format을 유지할때
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(children: [
          VideoPlayer(_videoPlayerController!),
          if (showControls)
            ControlByIcon(
                onPressedBack: onPressedBack,
                onPressedPlay: onPressedPlay,
                onPressedForward: onPressedForward,
                isPlaying: _videoPlayerController!.value.isPlaying),
          Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  print('home');
                },
                icon: const Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Slider(
              value: currentPos.inSeconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  currentPos = Duration(seconds: value.toInt());
                });
              },
              min: 0.0,
              max: _videoPlayerController!.value.duration.inSeconds.toDouble(),
            ),
          )
        ]),
      ),
    );
    // VideoPlayer(_videoPlayerController!);
  }

  onPressedBack() {
    print('Back');
    currentPos = _videoPlayerController!.value.position;
    Duration position = const Duration();

    if (currentPos > const Duration(seconds: 3)) {
      position = currentPos - const Duration(seconds: 3);
    }
    _videoPlayerController!.seekTo(position);
  }

  onPressedPlay() {
    // if playing, have to change to stop
    // if stop, have to change play
    if (_videoPlayerController!.value.isPlaying) {
      _videoPlayerController!.pause();
    } else {
      _videoPlayerController!.play();
    }
    setState(() {});
  }

  onPressedForward() {
    print('Forward');
    currentPos = _videoPlayerController!.value.position;
    Duration position = currentPos + const Duration(seconds: 3);

    if (position > _videoPlayerController!.value.duration) {
      position = _videoPlayerController!.value.duration;
    }

    _videoPlayerController!.seekTo(position);
  }
}

class ControlByIcon extends StatelessWidget {
  VoidCallback onPressedBack, onPressedPlay, onPressedForward;
  bool isPlaying;
  ControlByIcon(
      {super.key,
      required this.onPressedBack,
      required this.onPressedPlay,
      required this.onPressedForward,
      required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Colors.white,
          ),
          onPressed: onPressedBack,
        ),
        IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 30,
            color: Colors.white,
          ),
          onPressed: onPressedPlay,
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_rounded,
            size: 30,
            color: Colors.white,
          ),
          onPressed: onPressedForward,
        ),
      ],
    );
  }
}
