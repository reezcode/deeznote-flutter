import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

import '../widgets/rs_turing.dart';

class FileHelper {
  Future<File> saveImageToFile(ui.Image image) async {
    // Dapatkan direktori penyimpanan gambar
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    // Buat file dengan nama yang unik
    String filePath =
        '$appDocPath/signature_${DateTime.now().millisecondsSinceEpoch}.png';
    // Ubah image ke dalam format PNG dan simpan ke dalam file
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    List<int> pngBytes = byteData!.buffer.asUint8List();
    File imageFile = File(filePath);
    await imageFile.writeAsBytes(pngBytes);
    return imageFile;
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      RsToast.show('Error', err.toString());
    }
    return directory?.path;
  }
}
