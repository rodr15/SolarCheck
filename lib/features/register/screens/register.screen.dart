import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:solar_check/features/register/bloc/register_form_bloc.dart';

class RegisterFormScreen extends StatelessWidget {
  const RegisterFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterFormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Ingeniero - Solar Check'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterFormBloc, RegisterFormState>(
            listener: (context, state) {
              // Reaccionamos cuando el proceso de guardado finaliza con éxito
              if (state.status.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '¡Datos guardados localmente con éxito! (100% Offline)',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                // Aquí podrías navegar a la siguiente pantalla de la inspección solar
              }

              // Si ocurre un error al guardar
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al guardar los datos localmente.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<RegisterFormBloc>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
      ),
    );
  }
}
