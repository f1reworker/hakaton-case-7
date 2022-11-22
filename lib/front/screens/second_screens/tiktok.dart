// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:video_player/video_player.dart';

class TikTokPage extends StatefulWidget {
  const TikTokPage({Key? key}) : super(key: key);

  @override
  State<TikTokPage> createState() => _TikTokPageState();
}

class _TikTokPageState extends State<TikTokPage> {
  int indexVideo = 0;
  List<VideoPlayerController> listCont = [];
  cacheVideo() async {
    for (int i = 0; i < uris.length; i++) {
      VideoPlayerController controller = VideoPlayerController.network(uris[i]);
      controller.initialize().then((_) {
        listCont.add(controller);
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener((event) {
      _handleCallbackEvent(event.direction, event.success);
    });
    cacheVideo();
  }

  final List<String> uris = [
    'https://firebasestorage.googleapis.com/v0/b/case-7-10506.appspot.com/o/videos%2Fvideo_2022-11-19_20-51-32.mp4?alt=media&token=4aea8170-f6aa-4323-84df-27e07d65b61e',
    'https://firebasestorage.googleapis.com/v0/b/case-7-10506.appspot.com/o/videos%2Fmixkit-winter-fashion-cold-looking-woman-concept-video-39874.mp4?alt=media&token=05c8d644-ee58-4536-8fbb-3d05d4189e2c',
    'https://firebasestorage.googleapis.com/v0/b/case-7-10506.appspot.com/o/videos%2Fmixkit-waves-in-the-water-1164.mp4?alt=media&token=1180ff26-7eef-4d00-a434-7618f5fb21cf',
    'https://firebasestorage.googleapis.com/v0/b/case-7-10506.appspot.com/o/videos%2Fmixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875.mp4?alt=media&token=588ebced-b2cd-40b0-852d-94a6b98db879',
  ];
  final Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: uris.length,
        swipePositionThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 400),
        // ^ how long the animation will take
        controller: controller,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int index) {
          indexVideo = index;
          return Center(
            child: listCont.length > index
                ? AspectRatio(
                    aspectRatio: listCont[index].value.aspectRatio,
                    child: GestureDetector(
                        onTap: () => setState(() {
                              listCont[index].value.isPlaying
                                  ? listCont[index].pause()
                                  : listCont[index].play();
                            }),
                        child: VideoPlayer(listCont[index])),
                  )
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) {
    indexVideo = currentIndex!;
  }
}
