import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlaying extends StatefulWidget {
  VideoPlaying(this.youTubeController, {Key? key}) : super(key: key);
  YoutubePlayerController? youTubeController;
  @override
  State<VideoPlaying> createState() => _VideoPlayingState();
}

class _VideoPlayingState extends State<VideoPlaying> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // YoutubePlayerController _controller = YoutubePlayerController(
    //   initialVideoId: widget.youTubeController.,
    //   flags: YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: true,
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(body: SafeArea(child: YoutubePlayerBuilder(
    player: YoutubePlayer(
        controller: widget.youTubeController!,
    ),
    builder: (context, player) {
      return Column(
        children: [
          // some widgets
          player,
          //some other widgets
        ],
      );
    }),
    ),);
  }
}
