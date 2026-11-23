import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileActionService {
  static Future<bool> guardarEnDispositivo({
  required Uint8List bytes,
  required String nombreArchivo, // Asegúrate de que termine en '.xlsx'
}) async {
  final Uri? rutaGuardada = await FilePicker.saveFile(
    dialogTitle: 'Guardar reporte Excel',
    fileName: nombreArchivo,
    bytes: bytes,
  );

  return rutaGuardada != null;
}


  static Future<void> compartirArchivo({
    required Uint8List bytes,
    required String nombreArchivo,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$nombreArchivo');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Te comparto el reporte en Excel',
    );
  }
}
