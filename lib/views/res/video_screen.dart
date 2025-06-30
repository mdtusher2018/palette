// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  String videoUrl;
  bool isLocal;
  VideoApp({super.key, required this.videoUrl, this.isLocal = false});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    final uri = Uri.parse(widget.videoUrl);

    if (uri.scheme == 'http') {
      print('http');
    }

    if (widget.isLocal) {
      // If the video is local, use the file path
      _controller = VideoPlayerController.file(File(widget.videoUrl))
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {});
          _controller.play(); // Automatically play the video once initialized
        });
    } else {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..setLooping(true)
        ..initialize().then((_) {
          setState(() {});
          _controller.play(); // Automatically play the video once initialized
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
