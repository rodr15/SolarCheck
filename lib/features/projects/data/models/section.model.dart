import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

part 'section.model.freezed.dart';
part 'section.model.g.dart';

@freezed
abstract class SectionModel with _$SectionModel {
  const SectionModel._();

  const factory SectionModel({
    @JsonKey(name: 'section') required String section,
    @JsonKey(name: 'items') required List<SectionItemModel> items,
  }) = _SectionModel;

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  Section toEntity() => Section(
        title: section,
        items: items.map((e) => e.toEntity()).toList(),
      );

  factory SectionModel.fromEntity(Section entity) => SectionModel(
        section: entity.title,
        items: entity.items.map(SectionItemModel.fromEntity).toList(),
      );
}

@freezed
abstract class SectionItemModel with _$SectionItemModel {
  const SectionItemModel._();

  const factory SectionItemModel({
    @JsonKey(name: 'item') String? item,
    @JsonKey(name: 'couldHaveComments') bool? couldHaveComments,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'comments') String? comments,
    @JsonKey(name: 'section') String? section,
    @JsonKey(name: 'items') List<SectionItemModel>? items,
  }) = _SectionItemModel;

  factory SectionItemModel.fromJson(Map<String, dynamic> json) =>
      _$SectionItemModelFromJson(json);

  SectionItem toEntity() => SectionItem(
        title: item!,
        couldHaveComments: couldHaveComments ?? false,
        status: ValidationStatusExtension.fromText(status ?? '') ??
            ValidationStatus.pending,
        comments: comments,
        subSectionTitle: section,
        subItems: items?.map((e) => e.toEntity()).toList() ?? [],
      );

  factory SectionItemModel.fromEntity(SectionItem entity) => SectionItemModel(
        item: entity.title,
        couldHaveComments: entity.couldHaveComments,
        status: entity.status.text,
        comments: entity.comments,
        section: entity.subSectionTitle,
        items: entity.subItems.map(SectionItemModel.fromEntity).toList(),
      );
}
