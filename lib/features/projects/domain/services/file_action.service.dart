import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

abstract class FileActionService {
  static Future<bool> saveInPhone({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final Uri? savedPath = await FilePicker.saveFile(
      dialogTitle: 'Guardar reporte Excel',
      fileName: '$fileName.xlsx',
      bytes: bytes,
    );

    return savedPath != null;
  }

  static Future<void> shareFile({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Te comparto el reporte en Excel',
    );
  }
}
