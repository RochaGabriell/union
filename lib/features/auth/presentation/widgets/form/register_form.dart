/* Flutter Imports */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/core/common/widgets/form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameField(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordFiel(),
              const SizedBox(height: 20),
              _buildSaveButton(state, context),
            ],
          ),
        );
      },
    );
  }

  CustomFormField _buildNameField() {
    return CustomFormField(
      icon: const Icon(Icons.person),
      label: 'Nome',
      hint: 'Digite seu nome',
      controller: _nameController,
      validator: _validator,
    );
  }

  CustomFormField _buildEmailField() {
    return CustomFormField(
      icon: const Icon(Icons.email),
      label: 'Email',
      hint: 'Digite seu email',
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      controller: _emailController,
      validator: _validator,
    );
  }

  CustomFormField _buildPasswordFiel() {
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
      text: 'Cadastrar',
      isLoading: state is AuthLoadingState,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          TextInput.finishAutofillContext();
          context.read<AuthBloc>().add(
                AuthRegisterEvent(
                  name: _nameController.text,
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
