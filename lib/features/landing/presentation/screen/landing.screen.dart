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
                    projects.isEmpty
                        ? LandingEmptyProjects()
                        : LandingProjects(
                            projects: projects,
                          )
                  ],
                );
              },
              orElse: () => CircularProgressIndicator.adaptive());
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
    return Column(
      children: [
        TitleWithSubtitle(title: 'Tus proyectos', subTitle: 'Ver todos'),
        ...projects.map((p) => Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                          children: ValidationStatus.values
                              .map((s) => ValidateStatusChip(
                                    status: s,
                                    optionalText: '${s.text}: 0',
                                  ))
                              .toList()),
                      ElevatedButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text('Continuar inspeccion'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
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
    );
  }
}
