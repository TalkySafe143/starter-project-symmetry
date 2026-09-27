import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/news/data/models/article.dart';

@injectable
class UserArticlesFirebaseService {
  final FirebaseFirestore? firestoreDb = FirebaseFirestore.instance;
  final String collectionName = "articles";

  Future<DocumentReference<Map<String, dynamic>>?> createUserArticle(
      ArticleModel article) async {
    return await firestoreDb?.collection(collectionName).add(article.toJson());
  }
}
