import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/article/avatar/author_avatar_cubit.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

/// Small circular author avatar shared by article cards and the detail view.
///
/// Resolves the photo live from the author's public profile (`users/{uid}`)
/// through a cached read; while loading, on error, or when the author has
/// no photo — including daily news, which carries no author id at all — it
/// shows a neutral person silhouette.
class AuthorAvatar extends StatelessWidget {
  final String? authorId;
  final double radius;

  const AuthorAvatar({
    super.key,
    this.authorId,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (authorId?.isNotEmpty != true) {
      return _silhouette();
    }
    return BlocProvider(
      create: (_) => sl<AuthorAvatarCubit>()..load(authorId!),
      child: BlocBuilder<AuthorAvatarCubit, AuthorAvatarState>(
        builder: (context, state) {
          if (state is AuthorAvatarDone) {
            return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.black12,
              backgroundImage:
                  CachedNetworkImageProvider(state.photoUrl),
            );
          }
          return _silhouette();
        },
      ),
    );
  }

  Widget _silhouette() {
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
