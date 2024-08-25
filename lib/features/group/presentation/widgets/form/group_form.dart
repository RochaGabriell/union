/* Package Imports */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union/core/common/widgets/form_field.dart';
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';

class GroupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final GroupState state;
  final String creatorIdController;

  const GroupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.state,
    required this.creatorIdController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomFormField(
            icon: const Icon(Icons.group),
            label: 'Nome',
            hint: 'Nome do grupo',
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomFormField(
            icon: const Icon(Icons.description),
            label: 'Descrição',
            hint: 'Descrição do grupo',
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma descrição';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Salvar',
            isLoading: state is GroupLoadingState,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<GroupBloc>().add(
                      GroupCreateEvent(
                        group: GroupEntity(
                          name: nameController.text,
                          description: descriptionController.text,
                          creatorId: creatorIdController,
                          members: [],
                        ),
                      ),
                    );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
