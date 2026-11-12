import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/presentation/widgets/global_widgets.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';
import 'package:solar_check/features/projects/presentation/bloc/catalog/catalog_bloc.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocProvider(
            create: (context) => sl<CatalogBloc>()..add(CatalogEvent.load()),
            child: CatalogContent(),
          ),
        ),
      ),
    );
  }
}

class CatalogContent extends StatelessWidget {
  const CatalogContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (catalog) {
            // return CollapsibleSectionWidget(
            //     section: SectionItem.fromMap(catalog.catalog));
            return Text(catalog.catalog.toString());
          },
          error: (error) =>
              Text('Error cargando el catalogo, por favor intentelo más tarde'),
          orElse: () => CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class SectionItem {
  final String title;
  final String? description;
  final ValidationStatus? valdation;
  final List<SectionItem> subSections;

  SectionItem({
    required this.title,
    this.description,
    this.subSections = const [],
    this.valdation,
  });

  // Constructor para mapear desde Map<String, dynamic>
  factory SectionItem.fromMap(Map<String, dynamic> map) {
    return SectionItem(
      title: map['title'] ?? '',
      description: map['description'],
      // Si ValidationStatus es un Enum, puedes parsearlo así (asumiendo que guardas el nombre o el índice):
      valdation: map['valdation'] != null
          ? ValidationStatus.values.firstWhere(
              (e) => e.name == map['valdation'],
              orElse: () => ValidationStatus.values.first,
            )
          : null,
      // Mapeo recursivo de las subsecciones
      subSections: map['subSections'] != null
          ? (map['subSections'] as List<dynamic>)
              .map((subMap) =>
                  SectionItem.fromMap(subMap as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  // Opcional: Método para convertirlo nuevamente a Map (muy útil para APIs o almacenamiento local)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'valdation': valdation?.name,
      'subSections': subSections.map((sub) => sub.toMap()).toList(),
    };
  }
}

class CollapsibleSectionWidget extends StatelessWidget {
  final SectionItem section;

  const CollapsibleSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    if (section.subSections.isNotEmpty) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title:
              TitleWithSubtitle(title: section.title, subTitle: 'Completado'),
          children: section.subSections.map((subSection) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: CollapsibleSectionWidget(section: subSection),
            );
          }).toList(),
        ),
      );
    } else {
      return StepCard(
        title: section.title,
        subtitle: section.description,
        bottomExtracontent: section.valdation != null
            ? ValidateStatusChip(status: section.valdation!)
            : null,
      );
    }
  }
}
