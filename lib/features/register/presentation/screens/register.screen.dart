import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:solar_check/core/config/di/injection.dart';
import 'package:solar_check/core/user/presentation/bloc/auth_bloc.dart';
import 'package:solar_check/features/register/presentation/bloc/register_form_bloc.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterFormBloc>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<AuthBloc>().add(AuthEvent.validate());
              }
            },
            builder: (context, state) {
              final bloc = context.read<RegisterFormBloc>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
