import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/presentation/widgets/global_widgets.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';

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

                      LandingEmptyProjects()
                      // LandingProjects()
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
        TitleWithSubtitle(title: 'Tus proyectos', subTitle: 'Ver todos'),
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
