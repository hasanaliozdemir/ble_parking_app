import 'dart:io';
import 'dart:typed_data';

class ImageService{
  Future<Uint8List> testCompressFile(File file) async {
    var result = file.readAsBytesSync();
    
    return result;
  }
}