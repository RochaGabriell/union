/* Flutter Imports */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Core Imports */
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/common/widgets/form_field.dart';
import 'package:union/core/utils/injections.dart';

/* Package Imports */
import 'package:union/features/group/presentation/bloc/group_bloc.dart';
import 'package:union/features/group/domain/entities/group_entity.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({super.key});

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final creatorIdController = getIt.get<UserCubit>().user?.id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              _buildNameField(),
              const SizedBox(height: 24),
              _buildDescriptionField(),
              const SizedBox(height: 24),
              _buildSaveButton(state, context),
            ],
          ),
        );
      },
    );
  }

  CustomFormField _buildNameField() {
    return CustomFormField(
      icon: const Icon(Icons.group),
      label: 'Nome',
      hint: 'Nome do grupo',
      controller: nameController,
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um nome';
        }
        return null;
      },
    );
  }

  CustomFormField _buildDescriptionField() {
    return CustomFormField(
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
    );
  }

  GradientButton _buildSaveButton(GroupState state, BuildContext context) {
    return GradientButton(
      text: 'Salvar',
      isLoading: state is GroupLoadingState,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<GroupBloc>().add(
                GroupCreateEvent(
                  group: GroupEntity(
                    name: nameController.text,
                    description: descriptionController.text,
                    creatorId: creatorIdController ?? '',
                    members: [],
                  ),
                ),
              );
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
