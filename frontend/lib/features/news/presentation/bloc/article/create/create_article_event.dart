part of 'create_article_bloc.dart';

abstract class CreateArticleEvent {
  const CreateArticleEvent();
}

class PublishArticle extends CreateArticleEvent {
  final String title;
  final String content;
  final File? imageFile;

  const PublishArticle({
    required this.title,
    required this.content,
    this.imageFile,
  });
}

class ResetCreateArticle extends CreateArticleEvent {
  const ResetCreateArticle();
}
