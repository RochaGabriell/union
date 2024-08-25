/* Flutter Imports */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* Package Imports */
// import 'package:flutter_bloc/flutter_bloc.dart';

/* Project Imports */
// import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/core/common/widgets/form_field.dart';

class RecoveryForm extends StatefulWidget {
  const RecoveryForm({super.key});

  @override
  State<RecoveryForm> createState() => _RecoveryFormState();
}

class _RecoveryFormState extends State<RecoveryForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomFormField(
            icon: const Icon(Icons.email),
            label: 'Email',
            hint: 'Digite seu email',
            autofillHints: const [AutofillHints.email],
            controller: _emailController,
            validator: _validator,
          ),
          const SizedBox(height: 20),
          GradientButton(
            text: 'Resetar senha',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                TextInput.finishAutofillContext();
                showModalRecovery(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showModalRecovery(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final TextTheme textTheme = Theme.of(context).textTheme;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Fechar', style: textTheme.labelSmall),
                  ),
                ],
              ),
              Text(
                'Email enviado com sucesso!',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enviamos um e-mail de confirmação para:',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Text(
                _emailController.text,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Verifique sua caixa de entrada e siga as instruções para redefinir sua senha.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        );
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
    super.dispose();
  }
}
