import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_helper;
import 'dart:io';

class HardDrive {
  static const HardDrive _self = HardDrive._internal();

  const HardDrive._internal();

  static HardDrive getInstance() {
    return _self;
  }

  Future<File> copyToDisk({
    required File file,
  }) async {
//copy the file to the hard drive
    try {
      final _directory = await getApplicationDocumentsDirectory();
      final _fileName = path_helper.basename(file.path);
      String _diskPath = path_helper.join(
        _directory.path,
        _fileName,
      );
      //copy this file to that path
      final _file = await file.copy(_diskPath);
      return _file;
    } catch (err) {
      rethrow;
    }
  }
}
