import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:injectable/injectable.dart';
import 'package:solar_check/features/projects/domain/entities/inspection.entity.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

@injectable
class InspectionExport {
  InspectionExport();
  Future<Uint8List> export(Inspection inspection) async {
    final excel = _generateInspectionExcel(inspection);

    final bytes = excel.save();
    if (bytes == null) throw Exception('No se pudo generar el archivo Excel');

    return Uint8List.fromList(bytes);
  }

  Excel _generateInspectionExcel(Inspection inspection) {
    final excel = Excel.createExcel();

    for (Section section in inspection.inspectionAnswers) {
      final sheet = excel[section.title];
      sheet.appendRow(_getHeaders());

      _addSectionToSheet(sheet, section);
    }

    excel.setDefaultSheet(inspection.inspectionAnswers.first.title);
    excel.delete('Sheet1');

    return excel;
  }

  void _addSectionToSheet(Sheet sheet, Section section) {
    for (SectionEntry s in section.items) {
      if (s is Section) {
        _addSectionToSheet(sheet, s);
      }
      if (s is SectionItem) {
        sheet.appendRow(_getItemInfo(s));
      }
    }
  }

  List<TextCellValue> _getHeaders() {
    return [
      TextCellValue('Item'),
      ...ValidationStatus.values.map((v) => TextCellValue(v.text))
    ];
  }

  List<TextCellValue> _getItemInfo(SectionItem item) {
    return [
      TextCellValue(item.title),
      ...ValidationStatus.values
          .map((v) => TextCellValue(v == item.status ? 'X' : ''))
    ];
  }
}
