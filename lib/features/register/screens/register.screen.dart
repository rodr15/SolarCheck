import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:solar_check/core/di/injection.dart';
import 'package:solar_check/features/register/bloc/register_form_bloc.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterFormBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<RegisterFormBloc, RegisterFormState>(
              builder: (context, state) {
                final bloc = sl<RegisterFormBloc>();

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
                        // state.name.displayError detecta si debe mostrar el error según si el campo fue tocado
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
                      // state.isValid evalúa automáticamente gracias al FormzMixin
                      onPressed: state.isValid && !state.status.isInProgress
                          ? () =>
                              bloc.add(const RegisterFormEvent.formSubmitted())
                          : null, // Se deshabilita automáticamente si no es válido
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state.status.isInProgress
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
        );
      }),
    );
  }
}
