import 'package:flutter/material.dart';
import 'avatar.dart';
import 'main.dart';
import 'mixin_value_notifier.dart';

import 'model/user.dart';

class DrawerHeaderer extends StatefulWidget {
  const DrawerHeaderer({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerHeaderer> createState() => _DrawererHeaderState();
}

class _DrawererHeaderState extends State<DrawerHeaderer>
    with ValueNotifierMixin<DrawerHeaderer, User?> {
  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 220,
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Avatar(url: value?.profileImageUrl, size: 96),
              const SizedBox(height: 16),
              if (value != null)
                Text(
                  value?.displayName ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
            ],
          ),
        ),
      );
}
