import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:solar_check/core/di/injection.dart';
import 'package:solar_check/features/register/presentation/bloc/register_form_bloc.dart';
import 'package:solar_check/features/start/presentation/bloc/start_up_bloc.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 1. Aquí se crea e inyecta la única instancia del Bloc mediante GetIt
      create: (_) => sl<RegisterFormBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<StartUpBloc>()..add(StartUpEvent.started());
                print('Go to other route');
              }
            },

            // 2. BORRADO: Ya no pases 'bloc: sl<...>()'. BlocBuilder buscará automáticamente en el context.
            builder: (context, state) {
              // 3. OBTENER EL BLOC CORRECTO: Buscamos el Bloc que provee el BlocProvider de arriba
              final bloc = context.read<RegisterFormBloc>();

              print(
                  'from bloc ${state.isValid}'); // Usa directamente el state del builder

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Campo de Nombre
                  TextField(
                    onChanged: (value) =>
                        bloc.add(RegisterFormEvent.nameChanged(value)),
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                      hintText: 'Ej. Ing. Carlos Pérez',
                      errorText: state.name.displayError != null
                          ? 'El nombre no puede estar vacío'
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Campo de Correo
                  TextField(
                    onChanged: (value) =>
                        bloc.add(RegisterFormEvent.emailChanged(value)),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      hintText: 'Ej. c.perez@solarcheck.com',
                      errorText: state.email.displayError != null
                          ? 'Ingrese un correo electrónico válido'
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón de Envío / Guardado
                  ElevatedButton(
                    onPressed: state.isValid
                        ? () =>
                            bloc.add(const RegisterFormEvent.formSubmitted())
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: !state.isValid && state.status.isInProgress
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Guardar y Continuar',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
