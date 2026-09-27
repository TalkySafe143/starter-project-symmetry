import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/author_avatar.dart';

void main() {
  Widget buildAvatar({String? photoUrl}) {
    return MaterialApp(
      home: Scaffold(body: AuthorAvatar(photoUrl: photoUrl)),
    );
  }

  testWidgets('shows a person silhouette when there is no photo URL',
      (tester) async {
    await tester.pumpWidget(buildAvatar());

    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('shows a person silhouette when the photo URL is empty',
      (tester) async {
    await tester.pumpWidget(buildAvatar(photoUrl: ''));

    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('builds a photo avatar when a photo URL is stored',
      (tester) async {
    await tester.pumpWidget(
      buildAvatar(photoUrl: 'https://example.com/avatar.jpg'),
    );
    await tester.pump();

    expect(find.byIcon(Icons.person), findsNothing);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
