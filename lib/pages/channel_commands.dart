import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../model/command.dart';

class ChannelCommandsPage extends StatefulWidget {
  final String channelId;

  const ChannelCommandsPage({
    required this.channelId,
    super.key,
  });

  @override
  State<ChannelCommandsPage> createState() => ChannelCommandsPageState();
}

class ChannelCommandsPageState extends State<ChannelCommandsPage>
    with AutomaticKeepAliveClientMixin {
  List<Command>? _commands;

  @override
  bool get wantKeepAlive => _commands != null;

  @override
  void initState() {
    super.initState();

    RestClient(Dio())
        .getCommands(channelId: widget.channelId)
        .then((List<Command> commands) {
      if (!mounted) {
        return;
      }
      setState(() => _commands = commands);
    }).catchError((dynamic obj) {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        const SizedBox(height: 24),
        Text(
          'Commands',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
        ),
        ..._commands
                ?.map((c) => ListTile(
                      title: SelectableText(c.name),
                      subtitle: SelectableText(c.template),
                    ))
                .toList() ??
            []
      ],
    );
  }
}
