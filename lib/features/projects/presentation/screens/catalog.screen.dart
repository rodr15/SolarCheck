import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/presentation/widgets/global_widgets.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/presentation/bloc/inspection/inspection_bloc.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resumen de la inspección'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocProvider(
            create: (context) =>
                sl<InspectionBloc>()..add(InspectionEvent.started(projectId)),
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
    return BlocBuilder<InspectionBloc, InspectionState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (inspection) {
            return ListView.builder(
              itemCount: inspection.inspectionAnswers.length,
              itemBuilder: (_, i) => CollapsibleSectionWidget(
                section: inspection.inspectionAnswers[i],
                isTop: true,
              ),
            );
            // return Column(
            //   children: [
            //     CollapsibleSectionWidget(
            //         section: inspection.inspectionAnswers.first),
            //   ],
            // );
          },
          error: (error) =>
              Text('Error cargando el catalogo, por favor intentelo más tarde'),
          orElse: () => CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}

class CollapsibleSectionWidget extends StatelessWidget {
  final SectionEntry section;
  final bool isTop;

  const CollapsibleSectionWidget({
    super.key,
    required this.section,
    this.isTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return switch (section) {
      final Section s => isTop
          ? Column(
              children: [
                TitleWithSubtitle(title: s.title, subTitle: ''),
                ...s.items.map((subSection) {
                  return CollapsibleSectionWidget(section: subSection);
                }),
              ],
            )
          : Card(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                title: TitleWithSubtitle(
                  title: s.title,
                  subTitle: '',
                ),
                children: s.items.map((subSection) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: CollapsibleSectionWidget(section: subSection),
                  );
                }).toList(),
              ),
            ),
      final SectionItem s => StepCard(
          title: s.title,
          sideExtraContent: ValidateStatusChip(status: s.status),
          // onTap: ()=> context.goNamed(''),
        ),
      _ => Text('Error'),
    };
  }
}
