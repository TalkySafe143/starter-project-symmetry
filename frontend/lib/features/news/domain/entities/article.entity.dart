import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable{
  final int ? id;
  final String ? authorDisplayName;
  final String ? title;
  final String ? description;
  final String ? url;
  final String ? urlToImage;
  final String ? publishedAt;
  final String ? content;
  final String ? authorId;

  const ArticleEntity({
    this.id,
    this.authorDisplayName,
    this.title,
    this.description,
    this.url,
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
      url,
      urlToImage,
      publishedAt,
      content,
      authorId,
    ];
  }
}
