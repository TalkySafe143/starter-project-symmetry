import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/user_article_repository.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/update_author_photo_url.dart';

import 'update_author_photo_url_test.mocks.dart';

@GenerateMocks([UserArticleRepository])
void main() {
  late MockUserArticleRepository mockRepository;
  late UpdateAuthorPhotoUrl usecase;

  setUp(() {
    mockRepository = MockUserArticleRepository();
    usecase = UpdateAuthorPhotoUrl(mockRepository);
  });

  test('should refresh the photo on every article by the user', () async {
    when(mockRepository.updateAuthorPhotoUrl(
      'user-123',
      'https://example.com/new-avatar.jpg',
    )).thenAnswer((_) async => const DataSuccess(3));

    final result = await usecase(
      params: const UpdateAuthorPhotoUrlParams(
        userId: 'user-123',
        photoUrl: 'https://example.com/new-avatar.jpg',
      ),
    );

    expect(result, isA<DataSuccess<int>>());
    expect(result.data, 3);
    verify(mockRepository.updateAuthorPhotoUrl(
      'user-123',
      'https://example.com/new-avatar.jpg',
    )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return zero updates when params are null', () async {
    final result = await usecase();

    expect(result, isA<DataSuccess<int>>());
    expect(result.data, 0);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return DataGenericFailed when repository fails', () async {
    when(mockRepository.updateAuthorPhotoUrl('user-123', null)).thenAnswer(
        (_) async => const DataGenericFailed('Failed to refresh photo'));

    final result = await usecase(
      params: const UpdateAuthorPhotoUrlParams(userId: 'user-123'),
    );

    expect(result, isA<DataGenericFailed<int>>());
    verify(mockRepository.updateAuthorPhotoUrl('user-123', null)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
