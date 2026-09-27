import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Small circular author avatar shared by article cards and the detail view.
///
/// Shows the author's [photoUrl] when one is stored on the article; otherwise
/// falls back to a neutral person silhouette (same fallback for daily news,
/// which carries no author photo at all).
class AuthorAvatar extends StatelessWidget {
  final String? photoUrl;
  final double radius;

  const AuthorAvatar({
    super.key,
    this.photoUrl,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (photoUrl?.isNotEmpty == true) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        backgroundImage: CachedNetworkImageProvider(photoUrl!),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black12,
      child: Icon(
        Icons.person,
        size: radius,
        color: Colors.white70,
      ),
    );
  }
}
