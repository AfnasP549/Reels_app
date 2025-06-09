import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reels_app/features/data/models/reel_model.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelItem extends StatefulWidget {
  final ReelModel reel;

  const ReelItem({super.key, required this.reel});

  @override
  ReelItemState createState() => ReelItemState();
}

class ReelItemState extends State<ReelItem> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _initializeVideo() {
    if (widget.reel.cdnUrl != null &&
        widget.reel.cdnUrl != 'string' &&
        Uri.tryParse(widget.reel.cdnUrl!)?.hasAbsolutePath == true) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.reel.cdnUrl!),
        )
        ..initialize()
            .then((_) {
              if (mounted) {
                setState(() {
                  _isInitialized = true;
                });
                _controller!.setLooping(true);
                _controller!.play();
              }
            })
            .catchError((error) {
              if (mounted) {
                setState(() {
                  _isInitialized = false;
                });
              }
            });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio =
        (widget.reel.videoWidth != null &&
                widget.reel.videoHeight != null &&
                widget.reel.videoHeight! > 0)
            ? widget.reel.videoWidth! / widget.reel.videoHeight!
            : 16 / 9;

    return VisibilityDetector(
      key: Key(widget.reel.id.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && _controller == null) {
          _initializeVideo();
        } else if (info.visibleFraction <= 0.5 && _controller != null) {
          _controller?.pause();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Column(
              children: [
                // Top profile picture and user info
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      //! Profile picture
                      ClipOval(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child:
                              widget.reel.profilePicture != null &&
                                      Uri.tryParse(
                                            widget.reel.profilePicture!,
                                          )?.hasAbsolutePath ==
                                          true
                                  ? CachedNetworkImage(
                                    imageUrl: widget.reel.profilePicture!,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                    errorWidget:
                                        (context, url, error) => const Icon(
                                          Icons.person,
                                          size: 24,
                                          color: Colors.grey,
                                        ),
                                  )
                                  : const Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! Username
                            Text(
                              widget.reel.userFullname ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 2),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4.0),
                            //! Category
                            Text(
                              ' ${widget.reel.categoryTitle ?? 'Uncategorized'}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 2),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //! Video or thumbnail
                Expanded(
                  child: Center(
                    child:
                        _isInitialized && _controller != null
                            ? AspectRatio(
                              aspectRatio: aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                            : (widget.reel.thumbCdnUrl != null &&
                                widget.reel.thumbCdnUrl != 'string' &&
                                Uri.tryParse(
                                      widget.reel.thumbCdnUrl!,
                                    )?.hasAbsolutePath ==
                                    true)
                            ? AspectRatio(
                              aspectRatio: aspectRatio,
                              child: CachedNetworkImage(
                                imageUrl: widget.reel.thumbCdnUrl!,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget:
                                    (context, url, error) => const Icon(
                                      Icons.error,
                                      size: 50,
                                      color: Colors.red,
                                    ),
                              ),
                            )
                            : const Icon(
                              Icons.error,
                              size: 50,
                              color: Colors.red,
                            ),
                  ),
                ),
                // Engagement metrics and description
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          //! total likes
                          _buildIcons(
                            Icons.favorite_border,
                            '${widget.reel.totalLikes} likes',
                          ),
                          const SizedBox(width: 16.0),
                          //! total comments
                          _buildIcons(
                            Icons.comment,
                            '${widget.reel.totalComments} comments',
                          ),
                          const SizedBox(width: 16.0),
                          //! total shares
                          _buildIcons(
                            Icons.share,
                            '${widget.reel.totalShare} shares',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          //!Title
                          Text(
                            '${widget.reel.title ?? 'No Title'} ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 2),
                              ],
                            ),
                          ),
                          SizedBox(width: 4),

                          //! total views
                          Icon(Icons.visibility, color: Colors.grey, size: 18),
                          SizedBox(width: 2),
                          Text(
                            '${widget.reel.totalViews} views',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcons(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
      ],
    );
  }
}
