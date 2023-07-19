import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/presentation/providers/movies/movie_videos_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/domain.dart';

class VideosFromMovie extends ConsumerWidget {
  final int movieId;
  const VideosFromMovie({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(movieVideosProvider(movieId));
    return moviesFromVideo.when(
      data: (List<VideoEntity> videos) => _VideosList(
        videos: videos,
      ),
      error: (_, __) => const Text(
        "couldn't load videos",
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<VideoEntity> videos;
  const _VideosList({
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const Center(
        child: Text(
          'No videos found',
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Videos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //* First video
        _YoutubeVideoPlayer(
          youtubeVideoId: videos.first.youTubeKey,
          name: videos.first.name,
        ),
        //* All videos
        // ...videos
        //     .map(
        //       (video) => _YoutubeVideoPlayer(
        //         youtubeVideoId: videos.first.youTubeKey,
        //         name: videos.first.name,
        //       ),
        //     )
        //     .toList()
      ],
    );
  }
}

class _YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeVideoId;
  final String name;
  const _YoutubeVideoPlayer({
    required this.youtubeVideoId,
    required this.name,
  });

  @override
  State<_YoutubeVideoPlayer> createState() => __YoutubeVideoPlayerState();
}

class __YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  late YoutubePlayerController _youtubePlayerController;
  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.youtubeVideoId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
          ),
          YoutubePlayer(
            controller: _youtubePlayerController,
          ),
        ],
      ),
    );
  }
}
