import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/comments/domain/repository/comment_repository.dart';

class DeleteCommentParams {
  final String commentId;

  const DeleteCommentParams({required this.commentId});
}

class DeleteComment
    implements UseCase<DataState<void>, DeleteCommentParams> {
  final CommentRepository _commentRepository;

  DeleteComment(this._commentRepository);

  @override
  Future<DataState<void>> call({DeleteCommentParams? params}) async {
    if (params == null) return Future.value(DataSuccess(null));
    return await _commentRepository.deleteComment(params.commentId);
  }
}
