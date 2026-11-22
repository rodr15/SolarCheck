import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/config/router/router.constants.dart';
import 'package:solar_check/core/presentation/widgets/global_widgets.dart';
import 'package:solar_check/features/projects/domain/entities/section.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';
import 'package:solar_check/features/projects/presentation/bloc/Questionary/questionary_bloc.dart';

class InspectionCalificationScreen extends StatelessWidget {
  const InspectionCalificationScreen({
    super.key,
    required this.inspectionId,
    this.selectedSection,
  });

  final String inspectionId;
  final SectionItem? selectedSection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuestionaryBloc>()
        ..add(
          QuestionaryEvent.started(
            inspectionId,
            item: selectedSection,
          ),
        ),
      child: InspectionCalificationScaffold(),
    );
  }
}

class InspectionCalificationScaffold extends StatelessWidget {
  const InspectionCalificationScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<QuestionaryBloc>().add(QuestionaryEvent.forceSave());
            context.pop();
          },
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: const SafeArea(
        child: CalificationContent(),
      ),
    );
  }
}

class CalificationContent extends StatefulWidget {
  const CalificationContent({super.key});

  @override
  State<CalificationContent> createState() => _CalificationContentState();
}

class _CalificationContentState extends State<CalificationContent> {
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _commentsController.dispose();
    super.dispose();
  }

  void _onSelectStatus(BuildContext context, ValidationStatus status) {
    final rawComments = _commentsController.text.trim();
    final comments = rawComments.isEmpty ? null : rawComments;
    context.read<QuestionaryBloc>().add(
          QuestionaryEvent.next(
            status: status,
            comments: comments,
          ),
        );

    _commentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionaryBloc, QuestionaryState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (item, _, __) {
            if (item.comments != null) {
              _commentsController.text = item.comments!;
            }
          },
          finish: () => context.goNamed(RouterConstants.landing),
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (inspectionItem, currentIndex, totalItems) => LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight - 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      _InspectionTitleCard(title: inspectionItem.title),
                      Column(
                        spacing: 12,
                        children: [
                          if (inspectionItem.couldHaveComments)
                            _FieldObservationsCard(
                              controller: _commentsController,
                            ),
                          _ValidationOptionsList(
                            onSelect: (status) =>
                                _onSelectStatus(context, status),
                          ),
                          const _AutoAdvanceHint(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          error: (error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                error,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          orElse: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

class _InspectionTitleCard extends StatelessWidget {
  const _InspectionTitleCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldObservationsCard extends StatelessWidget {
  const _FieldObservationsCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 10,
          children: [
            const TitleWithSubtitle(
              title: 'Observaciones de campo',
              subTitle: 'Opcional',
            ),
            TextField(
              controller: controller,
              minLines: 3,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Ej. Observaciones de la validación...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValidationOptionsList extends StatelessWidget {
  const _ValidationOptionsList({required this.onSelect});

  final ValueChanged<ValidationStatus> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: ValidationStatus.selectableValues
          .map(
            (status) => _ValidationOptionButton(
              status: status,
              onPressed: () => onSelect(status),
            ),
          )
          .toList(),
    );
  }
}

class _ValidationOptionButton extends StatelessWidget {
  const _ValidationOptionButton({
    required this.status,
    required this.onPressed,
  });

  final ValidationStatus status;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = status.getColor(context);
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.1),
          foregroundColor: color,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(status.icon, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                status.text,
                textAlign: TextAlign.end,
                style: textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AutoAdvanceHint extends StatelessWidget {
  const _AutoAdvanceHint();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Row(
      spacing: 8,
      children: [
        Icon(
          Icons.touch_app_outlined,
          color: primaryColor,
        ),
        const Expanded(
          child: Text(
            'Toca una opción para calificar y avanzar al siguiente item automaticamente',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
