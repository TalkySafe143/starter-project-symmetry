import 'dart:io';

void main() async {
  await Process.run(
    'dart',
    ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    runInShell: true,
  );

  await Process.run(
    'dart',
    ['run', 'flutter_launcher_icons'],
    runInShell: true,
  );
}
