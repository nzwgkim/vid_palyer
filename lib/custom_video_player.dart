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
    return VideoPlayer(_videoPlayerController!);
  }
}
