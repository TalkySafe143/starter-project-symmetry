import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/article.entity.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/create_user_article.dart';

part 'create_article_event.dart';
part 'create_article_state.dart';

@injectable
class CreateArticleBloc extends Bloc<CreateArticleEvent, CreateArticleState> {
  final CreateUserArticle _createUserArticle;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  final String DEFAULT_USER_DISPLAY_NAME = "Anonymous";

  CreateArticleBloc(this._createUserArticle, this._getCurrentUserUseCase)
      : super(const CreateArticleIdle()) {
    on<PublishArticle>(_onPublishArticle);
    on<ResetCreateArticle>(_onReset);
  }

  Future<void> _onPublishArticle(
    PublishArticle event,
    Emitter<CreateArticleState> emit,
  ) async {
    if (event.title.trim().isEmpty) {
      emit(const CreateArticleError('Title cannot be empty.'));
      return;
    }
    if (event.content.trim().isEmpty) {
      emit(const CreateArticleError('Content cannot be empty.'));
      return;
    }

    emit(const CreateArticleLoading());

    final user = await _getCurrentUserUseCase();
    var authorDisplayname = DEFAULT_USER_DISPLAY_NAME;
    var authorId = "";

    if (user is DataSuccess && user.data != null) {
      authorDisplayname =
          user.data!.displayName ?? DEFAULT_USER_DISPLAY_NAME;
      authorId = user.data!.id;
    }

    final article = ArticleEntity(
        title: event.title.trim(),
        content: event.content.trim(),
        publishedAt: DateTime.now().toIso8601String(),
        authorDisplayName: authorDisplayname,
        authorId: authorId
        );

    final result = await _createUserArticle(
      params: CreateUserArticleParams(
        article: article,
        imageFile: event.imageFile,
      ),
    );

    if (result is DataSuccess) {
      emit(const CreateArticleSuccess());
    } else {
      emit(CreateArticleError(
        result.errorMessage ?? result.error?.toString() ?? 'Unknown error.',
      ));
    }
  }

  void _onReset(
    ResetCreateArticle event,
    Emitter<CreateArticleState> emit,
  ) {
    emit(const CreateArticleIdle());
  }
}
