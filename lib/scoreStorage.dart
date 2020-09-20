import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class ScoreStorage {
  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<io.File> localFile() async {
    final path = await localPath();
    return io.File('$path/score.txt');
  }

  Future<int> readScore() async {
    try {
      final file = await localFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<io.File> writeScore(int score) async {
    final file = await localFile();
    return file.writeAsString('$score');
  }

  Future<bool> availability() async {
    final path = await localPath();
    return io.File('$path/score.txt').exists();
  }
}
