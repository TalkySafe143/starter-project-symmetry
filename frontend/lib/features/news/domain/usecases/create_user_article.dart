import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';

class CreateUserArticleParams {
  final ArticleEntity article;
  final File? imageFile;

  const CreateUserArticleParams({
    required this.article,
    this.imageFile,
  });
}

@lazySingleton
class CreateUserArticle
    implements UseCase<DataState<void>, CreateUserArticleParams> {
  final UserArticleRepository _userArticleRepository;

  CreateUserArticle(this._userArticleRepository);

  @override
  Future<DataState<void>> call({CreateUserArticleParams? params}) async {
    if (params == null) return Future.value(DataSuccess(null));
    return await _userArticleRepository.createUserArticle(
      params.article,
      imageFile: params.imageFile,
    );
  }
}
