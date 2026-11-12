import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';

class TitleWithSubtitle extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final String subTitle;
  final Function()? subTitleOnPressed;

  const TitleWithSubtitle({
    super.key,
    required this.title,
    this.titleIcon,
    required this.subTitle,
    this.subTitleOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (titleIcon != null) ...[
              Icon(
                titleIcon,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        subTitleOnPressed != null
            ? TextButton(
                onPressed: subTitleOnPressed,
                child: Text(subTitle),
              )
            : Text(
                subTitle,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
      ],
    );
  }
}

class LandingEmptyProjects extends StatelessWidget {
  const LandingEmptyProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Card(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    shape: BoxShape.circle,
                    border: BoxBorder.all(
                      color: Theme.of(context).hoverColor,
                      width: 15,
                    ),
                  ),
                  child: Icon(
                    Icons.solar_power,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No hay proyectos registrados',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Comienza una nueva inspección técnica en terreno. Todos tus datos se guardarán en tus dispositivo',
                      style: Theme.of(context).textTheme.bodyMedium!,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => context.goNamed('CreateProject'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_outlined),
                        Text('Crea nuevo proyecto'),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Flujo rápido en 3 pasos'),
                  Text('Guia rapida',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
              StepCard(
                stepNumber: '1',
                title: 'Crea el proyecto',
                subtitle: 'Inicia el proyecto y el tipo',
              ),
              StepCard(
                stepNumber: '2',
                title: 'Evaluacion visual',
                subtitle: 'Valida rapidamente',
                bottomExtracontent: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 2,
                    children: ValidationStatus.values
                        .map((s) => ValidateStatusChip(status: s))
                        .toList()),
              ),
              StepCard(
                stepNumber: '3',
                title: 'Exporta el excel',
                subtitle: 'Genera el excel y envialo directo por whatsapp',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ValidateStatusChip extends StatelessWidget {
  final ValidationStatus status;
  final String? optionalText;
  const ValidateStatusChip({
    super.key,
    required this.status,
    this.optionalText,
  });

  @override
  Widget build(BuildContext context) {
    final color = status.getColor(context);

    return Chip(
      avatar: Icon(status.icon, color: color, size: 18),
      label: Text(optionalText ?? status.text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              )),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide.none,
    );
  }
}

class StepCard extends StatelessWidget {
  final String? stepNumber;
  final String title;
  final String? subtitle;
  final Widget? bottomExtracontent;
  final Widget? sideExtraContent;

  const StepCard({
    super.key,
    this.stepNumber,
    required this.title,
    this.subtitle,
    this.bottomExtracontent,
    this.sideExtraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (stepNumber != null && stepNumber!.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).highlightColor,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  stepNumber!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty)
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (bottomExtracontent != null) ...[bottomExtracontent!]
                  ],
                ),
              ),
            ),
            if (sideExtraContent != null) sideExtraContent!
          ],
        ),
      ),
    );
  }
}
