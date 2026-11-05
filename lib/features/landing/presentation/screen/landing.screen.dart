import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart'; // Tu bloc global

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                authenticated: (name, email) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Bienvenido, ',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      // If theres no projects

                      // LandingEmptyProjects()
                      LandingProjects()
                    ],
                  ),
                ),
                orElse: () => CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LandingProjects extends StatelessWidget {
  const LandingProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tus proyectos'),
            TextButton(
              child: Text('Ver todos'),
              onPressed: () {},
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_outlined),
                Text('Crea nuevo proyecto'),
              ],
            )),
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
                    onPressed: () {},
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
                extraContent: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValidateStatusChip(
                      icon: Icons.done,
                      text: 'Aprobado',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    ValidateStatusChip(
                      icon: Icons.close,
                      text: 'No Aprobado',
                      color: Colors.red,
                    ),
                    ValidateStatusChip(
                      icon: Icons.warning,
                      text: 'Pendiente',
                      color: Colors.orange,
                    ),
                  ],
                ),
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
  final IconData? icon;
  final String text;
  final Color color;

  const ValidateStatusChip({
    super.key,
    this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.all(2),
      label: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 15,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          ],
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
      backgroundColor: color,
    );
  }
}

class StepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String subtitle;
  final Widget? extraContent;

  const StepCard({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.subtitle,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).highlightColor,
                shape: BoxShape.rectangle,
              ),
              child: Text(
                stepNumber,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Container(
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
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (extraContent != null) ...[extraContent!]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
