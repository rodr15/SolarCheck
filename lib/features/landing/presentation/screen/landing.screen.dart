import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/presentation/widgets/global_widgets.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';
import 'package:solar_check/features/projects/domain/entities/project.entity.dart';
import 'package:solar_check/features/projects/domain/entities/validation_status.dart';
import 'package:solar_check/features/projects/presentation/bloc/projects/projects_bloc.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => sl<ProjectsBloc>()..add(ProjectsEvent.load()),
            child: LandingContent(),
          ),
        ),
      ),
    );
  }
}

class LandingContent extends StatelessWidget {
  const LandingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (context, state) {
          return state.maybeWhen(
              loaded: (projects) {
                final String name = sl<AuthBloc>().state.maybeWhen(
                    authenticated: (name, email) => name, orElse: () => '');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabecera fija
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
                    const SizedBox(height: 12),

                    // AQUÍ ESTÁ LA CLAVE: 'Expanded' le da un espacio delimitado
                    // al SingleChildScrollView para que pueda hacer su trabajo de scroll.
                    Expanded(
                      child: projects.isEmpty
                          ? const LandingEmptyProjects()
                          : LandingProjects(
                              projects: projects,
                            ),
                    ),
                  ],
                );
              },
              orElse: () => const CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

class LandingProjects extends StatelessWidget {
  const LandingProjects({
    super.key,
    required this.projects,
  });

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0), // Margen seguro general
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleWithSubtitle(
              title: 'Tus proyectos',
              subTitle: 'Ver todos',
            ),
            const SizedBox(height: 8),
            ...projects.map((p) => Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6), // Controlamos el margen de la tarjeta
                  child: Padding(
                    padding:
                        const EdgeInsets.all(12), // Padding interno equilibrado
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // USAMOS WRAP EN LUGAR DE ROW: Evita desbordamientos si hay muchos chips
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: ValidationStatus.values
                              .map((s) => ValidateStatusChip(
                                    status: s,
                                    optionalText: '${s.text}: 0',
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text('Continuar inspeccion'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () => context.goNamed('CreateProject'),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_outlined),
                    SizedBox(width: 8),
                    Text('Crea nuevo proyecto'), // Corregido el typo "newo"
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16), // Espacio inferior de respiro
          ],
        ),
      ),
    );
  }
}
