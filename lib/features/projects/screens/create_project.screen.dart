import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/presentation/widgets/title_with_subtitle.dart';
import 'package:solar_check/features/projects/widgets/option_card.dart';

class CreateProject extends StatelessWidget {
  const CreateProject({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 50,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    'Crear un nuevo proyecto',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  TitleWithSubtitle(
                    title: 'Nombre del proyecto',
                    titleIcon: Icons.solar_power,
                    subTitle: 'REQUERIDO',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.assignment_ind),
                      labelText: 'Nombre del proyecto',
                      hintText: 'Pegasus',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          'Identificador principal para tus reportes de inspección'),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  TitleWithSubtitle(
                    title: 'Tipo de proyecto',
                    titleIcon: Icons.category_outlined,
                    subTitle: 'PLANTILLA BASE',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OptionCard(
                    text: 'Utility scale',
                    icon: Icons.grid_view,
                    isSelected: true,
                  ),
                  OptionCard(
                    text: 'Generacion distribuida',
                    icon: Icons.factory,
                    isSelected: false,
                  ),
                  OptionCard(
                    text: 'Autoconsumo',
                    icon: Icons.house,
                    isSelected: false,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.goNamed('Inspection'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(Icons.play_circle_fill_outlined),
                    Text('Iniciar inspección'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
