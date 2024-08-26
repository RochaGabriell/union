/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/core/common/widgets/form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AutofillGroup(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 20),
                _buildSaveButton(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  CustomFormField _buildEmailField() {
    return CustomFormField(
      icon: const Icon(Icons.email),
      label: 'Email',
      hint: 'Digite seu email',
      autofillHints: const [AutofillHints.username],
      controller: _emailController,
      validator: _validator,
    );
  }

  CustomFormField _buildPasswordField() {
    return CustomFormField(
      icon: const Icon(Icons.lock),
      label: 'Senha',
      hint: 'Digite sua senha',
      obscure: true,
      autofillHints: const [AutofillHints.password],
      controller: _passwordController,
      validator: _validator,
    );
  }

  GradientButton _buildSaveButton(AuthState state, BuildContext context) {
    return GradientButton(
      text: 'Entrar',
      isLoading: state is AuthLoadingState,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(
                AuthLoginEvent(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
        }
      },
    );
  }

  String? _validator(value) {
    if (value!.isEmpty) {
      return 'Preencha o campo';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
