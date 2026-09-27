import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? id;
  final String? authorDisplayName;
  final String? title;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? authorId;
  final String? authorPhotoUrl;

  const ArticleEntity({
    this.id,
    required this.authorDisplayName,
    required this.title,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.authorId,
    this.authorPhotoUrl,
  });

  @override
  List<Object?> get props {
    return [
      id,
      authorDisplayName,
      title,
      urlToImage,
      publishedAt,
      content,
      authorId,
      authorPhotoUrl,
    ];
  }
}
