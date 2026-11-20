import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

part 'section.model.freezed.dart';
part 'section.model.g.dart';

@freezed
abstract class SectionEntryModel with _$SectionEntryModel {
  const SectionEntryModel();

  factory SectionEntryModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('section') && json['section'] != null) {
      return SectionModel.fromJson(json);
    }

    if (json.containsKey('item')) {
      return SectionItemModel.fromJson(json);
    }

    throw ArgumentError(
      'El JSON debe contener "section" o "item": $json',
    );
  }

  Map<String, dynamic> toJson() {
    if (this is SectionModel) {
      return (this as SectionModel).toJson();
    }
    if (this is SectionItemModel) {
      return (this as SectionItemModel).toJson();
    }
    throw UnsupportedError(
      'Tipo de SectionEntryModel no soportado en toJson: $runtimeType',
    );
  }

  SectionEntry toEntity();
}

@freezed
abstract class SectionModel extends SectionEntryModel with _$SectionModel {
  const SectionModel._() : super();
  const factory SectionModel({
    @JsonKey(name: 'section') required String section,
    @JsonKey(name: 'items', fromJson: _entriesFromJson)
    @Default([])
    List<SectionEntryModel> items,
  }) = _SectionModel;

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  @override
  Section toEntity() {
    return Section(
      title: section,
      items: items.map((i) => i.toEntity()).toList(),
    );
  }

  factory SectionModel.fromEntity(Section entity) => SectionModel(
        section: entity.title,
        items: entity.items.map<SectionEntryModel>((entry) {
          return switch (entry) {
            final Section s => SectionModel.fromEntity(s),
            final SectionItem i => SectionItemModel.fromEntity(i),
            _ => throw StateError('Tipo de SectionEntry no soportado: $entry'),
          };
        }).toList(),
      );
}

@freezed
abstract class SectionItemModel extends SectionEntryModel
    with _$SectionItemModel {
  const SectionItemModel._() : super();

  const factory SectionItemModel({
    @JsonKey(name: 'item') @Default('') String item,
    @JsonKey(name: 'couldHaveComments') bool? couldHaveComments,
    @JsonKey(name: 'status') String? status,
  }) = _SectionItemModel;

  factory SectionItemModel.fromJson(Map<String, dynamic> json) =>
      _$SectionItemModelFromJson(json);

  @override
  SectionItem toEntity() => SectionItem(
        title: item,
        couldHaveComments: couldHaveComments ?? false,
        status: ValidationStatusExtension.fromText(status ?? '') ??
            ValidationStatus.withoutValidation,
      );

  factory SectionItemModel.fromEntity(SectionItem entity) => SectionItemModel(
        item: entity.title,
        couldHaveComments: entity.couldHaveComments,
        status: entity.status.text,
      );
}

List<SectionEntryModel> _entriesFromJson(dynamic rawItems) {
  if (rawItems is! List) return [];
  return rawItems.map((e) => SectionEntryModel.fromJson(e)).toList();
}
