import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';

@injectable
class UserArticlesFirebaseService {
  static final _log = Logger('UserArticlesFirebaseService');

  final FirebaseFirestore _firestoreDb = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static const String _articlesCollection = 'articles';
  static const String _thumbnailsFolder = 'media/articles';

  /// Uploads [imageFile] to Firebase Cloud Storage under [_thumbnailsFolder]
  /// and returns its download URL. Returns null if [imageFile] is null.
  Future<String?> uploadThumbnail(File? imageFile) async {
    if (imageFile == null) return null;

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${imageFile.uri.pathSegments.last}';
    final ref = _storage.ref().child('$_thumbnailsFolder/$fileName');

    _log.info('uploadThumbnail → uploading to $_thumbnailsFolder/$fileName');
    final task = await ref.putFile(imageFile);
    final url = await task.ref.getDownloadURL();
    _log.info('uploadThumbnail → uploaded, url=$url');
    return url;
  }

  /// Returns the articles created by [userId], newest first by `publishedAt`.
  /// Returns an empty list when [userId] is blank instead of querying.
  Future<List<ArticleModel>> getUserArticles(String userId) async {
    if (userId.trim().isEmpty) return [];

    _log.info('getUserArticles → querying articles for user $userId');
    final snapshot = await _firestoreDb
        .collection(_articlesCollection)
        .where('authorId', isEqualTo: userId)
        .orderBy('publishedAt', descending: true)
        .get();

    final articles =
        snapshot.docs.map((doc) => ArticleModel.fromJson(doc.data())).toList();
    _log.info('getUserArticles → found ${articles.length} articles');
    return articles;
  }

  /// Saves [article] to Firestore. The [article.urlToImage] should already
  /// contain the Storage download URL before calling this.
  Future<DocumentReference<Map<String, dynamic>>> createUserArticle(
      ArticleModel article) async {
    _log.info('createUserArticle → saving to Firestore');
    final ref = await _firestoreDb
        .collection(_articlesCollection)
        .add(article.toJson());


    // TODO(sgalindo) this maybe can be done before the actual element
    // is created with set, but right now the entity is inmutable,
    // thus we cannot change the ID of the field itself before is 
    // inserted.
    await _firestoreDb
        .collection(_articlesCollection)
        .doc(ref.id)
        .update({"id": ref.id});

    _log.info('createUserArticle → saved with id=${ref.id}');
    return ref;
  }
}
