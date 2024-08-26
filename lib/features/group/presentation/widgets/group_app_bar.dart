/* Package Imports */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

/* Project Imports */
import 'package:union/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:union/config/routes/router.dart' as routes;

class GroupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int filterSelected;
  final Function(int) onFilterChange;

  const GroupAppBar({
    super.key,
    required this.filterSelected,
    required this.onFilterChange,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      title: const Text('Grupos'),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pushNamed(context, routes.profile);
          },
        ),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogoutEvent());
            Navigator.pushNamedAndRemoveUntil(
              context,
              routes.login,
              (route) => false,
            );
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChoiceChip('Todos', 0),
                const SizedBox(width: 8),
                _buildChoiceChip('Criados', 1),
                const SizedBox(width: 8),
                _buildChoiceChip('Participando', 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ChoiceChip _buildChoiceChip(String label, int value) {
    return ChoiceChip(
      label: Text(label),
      selected: filterSelected == value,
      onSelected: (selected) => onFilterChange(value),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
