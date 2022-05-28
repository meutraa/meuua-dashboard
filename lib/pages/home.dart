import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:meuua/main.dart';
import 'package:meuua/mixin_value_notifier.dart';
import 'package:meuua/pages/channel_settings.dart';
import 'package:meuua/pages/channels.dart';
import 'package:meuua/pages/commands.dart';
import 'package:meuua/pages/faq.dart';
import 'package:adaptive_components/adaptive_components.dart';

import '../drawer.dart';
import '../model/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with ValueNotifierMixin {
  int _currentPage = 0;
  String title = 'Meuua';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  User? _selectedUser;

  @override
  ValueNotifier get notifier => profile.notifier;

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
      drawer: (context) {
        if (small) {
          return MeuuaDrawer(
            currentPage: _currentPage,
            onDestinationSelected: onDestinationSelected,
            selectedUser: _selectedUser,
          );
        }
        return null;
      }(context),
      appBar: (context) {
        if (small) {
          return AppBar(
            foregroundColor: Colors.white,
            centerTitle: true,
            automaticallyImplyLeading: true,
            backgroundColor: Theme.of(context).canvasColor,
            title: Text(title),
          );
        }
        return null;
      }(context),
      body: Row(
        children: [
          AdaptiveContainer(
            constraints: const AdaptiveConstraints(
              xsmall: false,
              small: false,
              medium: true,
              large: true,
              xlarge: true,
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
