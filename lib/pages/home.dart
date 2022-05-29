import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:adaptive_components/adaptive_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../drawer.dart';
import '../main.dart';
import '../model/user.dart';
import 'channel_settings.dart';
import 'channels.dart';
import 'commands.dart';
import 'development.dart';
import 'faq.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentPage = 0;
  int _previousPage = 0;
  String title = 'Channels';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController();
  final registeredNotifier = ValueNotifier<int>(0);
  bool _registered = true;

  static const titles = [
    'Channels',
    'Global Commands',
    'Help',
    'Development',
    'FAQ',
  ];

  User? _selectedUser;

  void onDestinationSelected(int index) {
    setState(() {
      title = titles[index];
      _selectedUser = null;
      _previousPage = _currentPage;
      _currentPage = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    });
    _scaffoldKey.currentState?.closeDrawer();
  }

  void join() {
    RestClient(Dio())
        .register(channelId: profile.val!.id, authorization: accessToken.val!)
        .then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _registered = true;
        registeredNotifier.value++;
      });
    }).catchError((dynamic obj) {
      if (obj is DioError) {
        final data = obj.response?.data as String?;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            data ??
                obj.response?.statusMessage?.toString() ??
                'An error occurred',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final type = getBreakpointEntry(context).adaptiveWindowType;
    final small =
        type == AdaptiveWindowType.small || type == AdaptiveWindowType.xsmall;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _currentPage != 0
          ? null
          : !_registered
              ? ElevatedButton.icon(
                  icon: const Icon(Icons.celebration),
                  label: const Text('Join'),
                  onPressed: join,
                )
              : null,
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
      appBar: small
          ? AppBar(
              title: Text(title),
              leading: _selectedUser != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => onDestinationSelected(_previousPage),
                    )
                  : null,
              // surfaceTintColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            )
          : null,
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
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                ChannelsPage(
                  onUserRegistered: (registered) => setState(
                    () => _registered = registered,
                  ),
                  registerNotifier: registeredNotifier,
                  onUserSelected: (user) {
                    setState(
                      () {
                        title = user.displayName;
                        _selectedUser = user;
                        _previousPage = _currentPage;
                        _currentPage = 1;
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                      },
                    );
                    _scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                if (_selectedUser != null)
                  ChannelSettingsPage(
                    user: _selectedUser!,
                  ),
                const CommandsPage(),
                const Center(
                  child: Text('Page 3'),
                ),
                const DevelopmentPage(),
                const FAQPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
