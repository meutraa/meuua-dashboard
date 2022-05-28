import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuua/avatar.dart';
import 'package:meuua/main.dart';
import 'package:meuua/mixin_value_notifier.dart';
import 'package:meuua/model/channel_settings.dart';

import '../api.dart';
import '../model/user.dart';

class ChannelSettingsPage extends StatefulWidget {
  final User user;

  const ChannelSettingsPage({
    super.key,
    required this.user,
  });

  @override
  State<ChannelSettingsPage> createState() => ChannelSettingsPageState();
}

class ChannelSettingsPageState extends State<ChannelSettingsPage>
    with ValueNotifierMixin<ChannelSettingsPage, User?> {
  ChannelSettings? _settings;
  final TextEditingController _openaiTokenController = TextEditingController();
  bool _isSaving = false;

  @override
  ValueNotifier<User?> get notifier => profile.notifier;

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  void getSettings() async {
    final settings = await RestClient(Dio()).getChannelSettings(widget.user.id);
    setState(() {
      if (settings.openaiToken.valid) {
        _openaiTokenController.text = settings.openaiToken.string;
      }
      _settings = settings;
    });
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Avatar(url: widget.user.profileImageUrl, size: 192),
                  const SizedBox(height: 16),
                  Text(widget.user.displayName,
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 8),
                  if (widget.user.description.isNotEmpty)
                    Text(
                      widget.user.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  if (_settings != null) const SizedBox(height: 48),
                  if (_settings != null)
                    const ListTile(
                      title: Text('OpenAI Token'),
                      subtitle: Text(
                        'Without this, meuua will not use AI generated messages',
                      ),
                    ),
                  if (_settings != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 24),
                      child: TextField(
                        maxLines: 1,
                        enabled: value?.id == widget.user.id,
                        autocorrect: false,
                        controller: _openaiTokenController,
                      ),
                    ),
                  if (_settings != null) const SizedBox(height: 48),
                  if (_settings != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.only(end: 16),
                          child: Icon(Icons.health_and_safety),
                        ),
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
                  if (_settings != null) const SizedBox(height: 48),
                  if (_settings != null)
                    Text(
                      'Auto Reply',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  if (_settings != null)
                    if (_settings != null)
                      SwitchListTile(
                        title: const Text('Auto Reply'),
                        subtitle: const Text(
                          'With this enabled, meuua will send messages without being prompted',
                        ),
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
                          min: 1.0,
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
                                setState(() {
                                  _settings = settings;
                                  _isSaving = false;
                                });
                              }).catchError((obj) {
                                setState(() {
                                  _isSaving = false;
                                });
                                if (obj is DioError) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      obj.response?.data ??
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
}
