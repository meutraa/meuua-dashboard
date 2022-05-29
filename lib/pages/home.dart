import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';
import '../main.dart';
import '../mixin_value_notifier.dart';
import '../model/user.dart';
import 'channel_settings.dart';
import 'channels.dart';
import 'commands.dart';
import 'faq.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with ValueNotifierMixin<HomePage, User?> {
  int _currentPage = 0;
  String title = 'Meuua';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User? _selectedUser;

  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  void onDestinationSelected(int index) {
    setState(() {
      switch (index) {
        case 0:
          title = 'Channels';
          break;
        case 1:
          title = 'Global Commands';
          break;
        case 2:
          title = 'Help';
          break;
        case 3:
          title = 'FAQ';
          break;
      }
      _selectedUser = null;
      _currentPage = index;
    });
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final type = getBreakpointEntry(context).adaptiveWindowType;
    final small =
        type == AdaptiveWindowType.small || type == AdaptiveWindowType.xsmall;
    return Scaffold(
      key: _scaffoldKey,
      drawer: (BuildContext context) {
        if (small) {
          return MeuuaDrawer(
            currentPage: _currentPage,
            onDestinationSelected: onDestinationSelected,
            selectedUser: _selectedUser,
          );
        }
        return null;
      }(context),
      appBar: small ? AppBar(title: Text(title)) : null,
      body: Row(
        children: [
          AdaptiveContainer(
            constraints: const AdaptiveConstraints(
              xsmall: false,
              small: false,
            ),
            child: MeuuaDrawer(
              currentPage: _currentPage,
              onDestinationSelected: onDestinationSelected,
              selectedUser: _selectedUser,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentPage,
              children: [
                ChannelsPage(onUserSelected: (user) {
                  setState(() {
                    title = user.displayName;
                    _selectedUser = user;
                    _currentPage = 1;
                  });
                  _scaffoldKey.currentState?.closeDrawer();
                }),
                if (_selectedUser != null)
                  ChannelSettingsPage(
                    user: _selectedUser!,
                  ),
                const CommandsPage(),
                const Center(
                  child: Text('Page 3'),
                ),
                const FAQPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
