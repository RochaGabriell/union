/* Flutter Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/* Core Imports */
import 'package:union/core/common/widgets/gradiente_button.dart';
import 'package:union/core/common/cubit/user/user_cubit.dart';
import 'package:union/core/enums/category_transaction.dart';
import 'package:union/core/common/widgets/form_field.dart';
import 'package:union/core/enums/type_transaction.dart';
import 'package:union/core/utils/injections.dart';

/* Features Imports */
import 'package:union/features/transaction/presentation/widgets/currency_input_field.dart';
import 'package:union/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:union/features/transaction/domain/entities/transaction_entity.dart';
import 'package:union/features/group/presentation/bloc/group_bloc.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final formKey = GlobalKey<FormState>();

  final categories = CategoryTransaction.values;
  final types = TypeTransaction.values;

  final descriptionController = TextEditingController();
  final valueController = TextEditingController();
  final dateController = TextEditingController();
  final groupIdController = TextEditingController();
  final userIdController = getIt.get<UserCubit>().user?.id;

  int? typeSelector;
  int? categorySelector;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    final String? userId = getIt.get<UserCubit>().user?.id;
    if (userId != null) {
      getIt<GroupBloc>().add(GroupsGetEvent(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildDescriptionField(),
                const SizedBox(height: 24),
                CurrencyInputField(valueController: valueController),
                const SizedBox(height: 24),
                _buildDateField(context),
                const SizedBox(height: 24),
                _buildCategoryDropdown(),
                const SizedBox(height: 24),
                _buildTypeDropdown(),
                const SizedBox(height: 24),
                _buildGroupDropdown(),
                const SizedBox(height: 24),
                _buildSaveButton(state, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return CustomFormField(
      icon: const Icon(Icons.description),
      label: 'Descrição',
      hint: 'Descrição da Despesa',
      autofocus: true,
      controller: descriptionController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma descrição';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selectedDate != null) {
          dateController.text = selectedDate.toIso8601String();
        }
      },
      child: AbsorbPointer(
        child: CustomFormField(
          icon: const Icon(Icons.date_range),
          label: 'Data',
          hint: 'Data da Despesa',
          controller: dateController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma data';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<CategoryTransaction>(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.category),
        labelText: 'Categoria',
      ),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(
            category.name[0].toUpperCase() + category.name.substring(1),
          ),
        );
      }).toList(),
      onChanged: (value) => categorySelector = value?.index,
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecione uma categoria';
        }
        return null;
      },
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<TypeTransaction>(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.category),
        labelText: 'Tipo',
      ),
      items: types.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(
            type.name[0].toUpperCase() + type.name.substring(1),
          ),
        );
      }).toList(),
      onChanged: (value) => typeSelector = value?.index,
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecione um tipo';
        }
        return null;
      },
    );
  }

  Widget _buildGroupDropdown() {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        if (state is GroupLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupSuccessGetGroupsState) {
          return DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.group),
              labelText: 'Grupo',
            ),
            items: state.groups.map((group) {
              return DropdownMenuItem(
                value: group.id,
                child: Text(group.name),
              );
            }).toList(),
            onChanged: (value) => groupIdController.text = value!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione um grupo';
              }
              return null;
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildSaveButton(TransactionState state, BuildContext context) {
    return GradientButton(
      text: 'Salvar',
      isLoading: state is TransactionLoadingState,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          String value = valueController.text.replaceAll(RegExp(r'[^0-9]'), '');
          context.read<TransactionBloc>().add(
                TransactionCreateEvent(
                  transaction: TransactionEntity(
                    description: descriptionController.text,
                    value: double.parse(value),
                    date: DateTime.parse(dateController.text),
                    category: CategoryTransaction.values[categorySelector ?? 0],
                    type: TypeTransaction.values[typeSelector ?? 0],
                    groupId: groupIdController.text,
                    userId: userIdController ?? '',
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
    descriptionController.dispose();
    dateController.dispose();
    groupIdController.dispose();
    super.dispose();
  }
}
