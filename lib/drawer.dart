import 'package:flutter/material.dart';

import 'auth.dart';
import 'avatar.dart';
import 'drawer_header.dart';
import 'main.dart';
import 'mixin_value_notifier.dart';
import 'model/user.dart';

class MeuuaDrawer extends StatefulWidget {
  final int currentPage;
  final User? selectedUser;
  final Function(int) onDestinationSelected;

  const MeuuaDrawer({
    required this.currentPage,
    required this.selectedUser,
    required this.onDestinationSelected,
    super.key,
  });

  @override
  State<MeuuaDrawer> createState() => _MeuuaDrawerState();
}

class _MeuuaDrawerState extends State<MeuuaDrawer>
    with ValueNotifierMixin<MeuuaDrawer, User?> {
  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  @override
  Widget build(BuildContext context) => Drawer(
        child: Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              selectedColor: Theme.of(context).colorScheme.surface,
              style: ListTileStyle.drawer,
              selectedTileColor: Colors.deepOrange.shade100,
              iconColor: Colors.deepOrangeAccent.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          child: Column(
            children: [
              const DrawerHeaderer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  selected: widget.currentPage == 0,
                  onTap: () => widget.onDestinationSelected(0),
                  title: const Text('Channels'),
                  leading: const Icon(Icons.stream),
                ),
              ),
              const SizedBox(height: 8),
              if (widget.selectedUser != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    selected: widget.currentPage == 1,
                    title: Text(widget.selectedUser!.displayName),
                    leading: Avatar(
                      size: 36,
                      url: widget.selectedUser?.profileImageUrl,
                    ),
                  ),
                ),
              if (widget.selectedUser != null) const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  selected:
                      widget.currentPage == 1 && widget.selectedUser == null,
                  onTap: () => widget.onDestinationSelected(1),
                  title: const Text('Global Commands'),
                  leading: const Icon(Icons.keyboard_command_key),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  selected:
                      widget.currentPage == 2 && widget.selectedUser == null,
                  onTap: () => widget.onDestinationSelected(2),
                  title: const Text('Help'),
                  leading: const Icon(Icons.help_center),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  selected:
                      widget.currentPage == 3 && widget.selectedUser == null,
                  onTap: () => widget.onDestinationSelected(3),
                  title: const Text('FAQ'),
                  leading: const Icon(Icons.question_answer),
                ),
              ),
              const Spacer(),
              if (value != null)
                ElevatedButton.icon(
                  onPressed: logout,
                  label: const Text('Logout'),
                  icon: const Icon(Icons.logout),
                ),
              if (value == null)
                ElevatedButton.icon(
                  onPressed: () => login(context),
                  label: const Text('Login'),
                  icon: const Icon(Icons.login),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      );
}
