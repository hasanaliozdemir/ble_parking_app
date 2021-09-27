import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageService{
  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      format: CompressFormat.png,
      
      minWidth: 144,
      minHeight: 144,
      quality: 40,
      
    );
    
    return result;
  }
}