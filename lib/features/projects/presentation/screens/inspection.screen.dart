import 'package:flutter/material.dart';
import 'package:solar_check/core/presentation/widgets/title_with_subtitle.dart';
import 'package:solar_check/features/projects/presentation/widgets/option_card.dart';

class Inspection extends StatelessWidget {
  const Inspection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 20,
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generales',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Señalización y seguridad',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TitleWithSubtitle(
                        title: 'Observaciones',
                        titleIcon: Icons.edit_note,
                        subTitle: 'Opcional',
                      ),
                      TextField(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  OptionCard(
                    text: 'Aprobado',
                    value: 'Aprobado',
                    icon: Icons.done,
                    isSelected: false,
                    color: Theme.of(context).colorScheme.primary,
                    selectedIcon: false,
                  ),
                  OptionCard(
                    text: 'No Aprobado',
                    value: 'No Aprobado',
                    icon: Icons.close,
                    isSelected: false,
                    color: Colors.red,
                    selectedIcon: false,
                  ),
                  OptionCard(
                    text: 'Pendiente',
                    value: 'Pendiente',
                    icon: Icons.query_builder_outlined,
                    isSelected: false,
                    color: Colors.orange,
                    selectedIcon: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
