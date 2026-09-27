import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable{
  final int ? id;
  final String ? authorDisplayName;
  final String ? title;
  final String ? description;
  final String ? urlToImage;
  final String ? publishedAt;
  final String ? content;
  final String ? authorId;

  const ArticleEntity({
    this.id,
    this.authorDisplayName,
    this.title,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.authorId,
  });

  @override
  List < Object ? > get props {
    return [
      id,
      authorDisplayName,
      title,
      description,
      urlToImage,
      publishedAt,
      content,
      authorId,
    ];
  }
}
