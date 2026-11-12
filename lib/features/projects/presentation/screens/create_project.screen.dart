import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/presentation/widgets/title_with_subtitle.dart';
import 'package:solar_check/features/projects/presentation/bloc/register/register_project_bloc.dart';
import 'package:solar_check/features/projects/presentation/widgets/option_card.dart';

class CreateProject extends StatelessWidget {
  const CreateProject({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<RegisterProjectBloc>(),
        child: CreateProjectContent(),
      ),
    );
  }
}

class CreateProjectContent extends StatelessWidget {
  const CreateProjectContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterProjectBloc, RegisterProjectState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.goNamed('Catalog');
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegisterProjectBloc>();
          String type = state.type.value;
          return Padding(
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
                      onChanged: (name) =>
                          bloc.add(RegisterProjectEvent.nameChanged(name)),
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
                      value: 'Utility scale',
                      isSelected: 'Utility scale' == type,
                      icon: Icons.grid_view,
                      color: Theme.of(context).colorScheme.primary,
                      onClick: () => bloc.add(
                        RegisterProjectEvent.typeChanged('Utility scale'),
                      ),
                    ),
                    OptionCard(
                      text: 'Generacion distribuida',
                      value: 'Generacion distribuida',
                      isSelected: 'Generacion distribuida' == type,
                      icon: Icons.factory,
                      color: Theme.of(context).colorScheme.primary,
                      onClick: () => bloc.add(
                        RegisterProjectEvent.typeChanged(
                            'Generacion distribuida'),
                      ),
                    ),
                    OptionCard(
                      text: 'Autoconsumo',
                      value: 'Autoconsumo',
                      isSelected: 'Autoconsumo' == type,
                      icon: Icons.house,
                      color: Theme.of(context).colorScheme.primary,
                      onClick: () => bloc.add(
                        RegisterProjectEvent.typeChanged('Autoconsumo'),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () => bloc.add(
                            RegisterProjectEvent.formSubmitted(),
                          )
                      : null,
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
          );
        },
      ),
    );
  }
}
