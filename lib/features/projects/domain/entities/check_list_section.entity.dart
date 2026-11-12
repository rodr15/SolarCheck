import 'package:solar_check/features/projects/domain/entities/check_list.entity.dart';

class ChecklistSection {
  final String seccion;
  final List<ChecklistItem> items;

  ChecklistSection({
    required this.seccion,
    required this.items,
  });

  factory ChecklistSection.fromJson(Map<String, dynamic> json) {
    var rawItems = json['items'] as List;
    List<ChecklistItem> parsedItems =
        rawItems.map((i) => ChecklistItem.fromJson(i)).toList();

    return ChecklistSection(
      seccion: json['seccion'] as String,
      items: parsedItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seccion': seccion,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}
