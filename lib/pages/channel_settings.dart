import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:adaptive_components/adaptive_components.dart';

import '../api.dart';
import '../avatar.dart';
import '../main.dart';
import '../mixin_value_notifier.dart';
import '../model/channel_settings.dart';
import '../model/user.dart';
import 'channel_approvals.dart';
import 'channel_commands.dart';

class ChannelSettingsPage extends StatefulWidget {
  final User user;

  const ChannelSettingsPage({
    required this.user,
    super.key,
  });

  @override
  State<ChannelSettingsPage> createState() => ChannelSettingsPageState();
}

class ChannelSettingsPageState extends State<ChannelSettingsPage>
    with ValueNotifierMixin<ChannelSettingsPage, User?> {
  ChannelSettings? _settings;
  final TextEditingController _openaiTokenController = TextEditingController();
  bool _isSaving = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  Future<void> getSettings() async {
    final settings = await RestClient(Dio()).getChannelSettings(widget.user.id);
    if (!mounted) {
      return;
    }
    setState(() {
      if (settings.openaiToken.valid) {
        _openaiTokenController.text = settings.openaiToken.string;
      }
      _settings = settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    // check adaptive size
    final type = getBreakpointEntry(context).adaptiveWindowType;
    final small = type == AdaptiveWindowType.medium ||
        type == AdaptiveWindowType.small ||
        type == AdaptiveWindowType.xsmall;

    final settingsPage = SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Avatar(
                  url: widget.user.profileImageUrl,
                  size: 160,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.user.displayName,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 8),
                if (widget.user.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.user.description,
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (_settings != null) const SizedBox(height: 32),
                if (_settings != null)
                  const ListTile(
                    title: Text('OpenAI Token'),
                    subtitle: Text(
                      'Without this, meuua will not use AI generated messages',
                    ),
                  ),
                if (_settings != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      enabled: value?.id == widget.user.id,
                      autocorrect: false,
                      controller: _openaiTokenController,
                    ),
                  ),
                if (_settings != null) const SizedBox(height: 48),
                if (_settings != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Safety',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                if (_settings != null)
                  ListTile(
                    title: const Text('Reply Safety'),
                    subtitle: const Text(
                      'A higher safety will attempt to be more friendly',
                    ),
                    trailing: DropdownButton<int>(
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text('Very Safe'),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text('Safe'),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('Unsafe'),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text('Unfiltered'),
                          ),
                        ],
                        value: _settings!.replySafety,
                        onChanged: (val) {
                          if (value?.id == widget.user.id) {
                            setState(() {
                              if (val != null) {
                                _settings!.replySafety = val;
                              }
                            });
                          }
                        }),
                  ),
                if (_settings != null) const SizedBox(height: 32),
                if (_settings != null)
                  SwitchListTile(
                    title: Text(
                      'Auto Reply',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.background,
                    value: _settings!.autoReplyEnabled,
                    onChanged: (_) {
                      if (value?.id == widget.user.id) {
                        setState(() {
                          _settings!.autoReplyEnabled =
                              !_settings!.autoReplyEnabled;
                        });
                      }
                    },
                  ),
                if (_settings != null)
                  const ListTile(
                    subtitle: Text(
                      'With this enabled, meuua will send messages without being prompted',
                    ),
                  ),
                if (_settings != null) const SizedBox(height: 16),
                if (_settings != null)
                  ListTile(
                    leading: const Icon(Icons.hourglass_bottom),
                    title: Text(
                        '${(100 / _settings!.autoReplyFrequency).toStringAsFixed(0)}% as often as the average viewer'),
                    subtitle: Slider(
                        label:
                            '${(100 / _settings!.autoReplyFrequency).toStringAsFixed(0)}%',
                        max: 5,
                        min: 1,
                        divisions: 40,
                        value: _settings!.autoReplyFrequency,
                        onChanged: (val) {
                          if (value?.id == widget.user.id) {
                            setState(() {
                              _settings!.autoReplyFrequency = val;
                            });
                          }
                        }),
                  ),
                if (_settings != null) const SizedBox(height: 16),
                if (_settings != null && value?.id == widget.user.id)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: _isSaving
                        ? null
                        : () {
                            setState(() {
                              _isSaving = true;
                            });
                            // on error, display a snackbar
                            _settings?.openaiToken.string =
                                _openaiTokenController.text;
                            _settings?.openaiToken.valid = true;
                            RestClient(Dio())
                                .patchChannelSettings(
                              channelId: widget.user.id,
                              authorization: accessToken.val ?? '',
                              settings: _settings!,
                            )
                                .then((settings) {
                              if (!mounted) {
                                return;
                              }
                              setState(() {
                                _settings = settings;
                                _isSaving = false;
                              });
                            }).catchError((dynamic obj) {
                              setState(() {
                                _isSaving = false;
                              });
                              if (obj is DioError) {
                                final data = obj.response?.data as String?;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    data ??
                                        obj.response?.statusMessage
                                            ?.toString() ??
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
                          },
                    label: const Text('Save'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    if (small) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_command_key),
              label: 'Commands',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Approvals',
            ),
          ],
          onTap: (index) {
            setState(() => _currentPage = index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          },
        ),
        body: PageView(
          controller: _pageController,
          children: [
            settingsPage,
            ChannelCommandsPage(channelId: widget.user.id),
            ChannelApprovalsPage(channelId: widget.user.id),
          ],
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(child: settingsPage),
        Flexible(child: ChannelCommandsPage(channelId: widget.user.id)),
        Flexible(child: ChannelApprovalsPage(channelId: widget.user.id)),
      ],
    );
  }
}
