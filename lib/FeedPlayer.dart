import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'FlickMultiManager.dart';
import 'FlickMultiPlayer.dart';
import 'mock_data.dart';

class FeedPlayer extends StatefulWidget {
  const FeedPlayer({Key? key}) : super(key: key);

  @override
  State<FeedPlayer> createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {

  List items = mockData['items'];

  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickMultiManager.pause();
        }
      },
      child: Container(
        child: ListView.separated(
          separatorBuilder: (context, int) => Container(
            height: 50,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
                height: 280,
                margin: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FlickMultiPlayer(
                    url: items[index]['trailer_url'],
                    flickMultiManager: flickMultiManager,
                    image: items[index]['image'],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
