import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../model/command.dart';

class CommandsPage extends StatefulWidget {
  const CommandsPage({super.key});

  @override
  State<CommandsPage> createState() => CommandsPageState();
}

class CommandsPageState extends State<CommandsPage>
    with AutomaticKeepAliveClientMixin {
  List<Command>? _commands;

  @override
  bool get wantKeepAlive => _commands != null;

  @override
  void initState() {
    RestClient(Dio()).getGlobalCommands().then((List<Command> commands) {
      if (!mounted) {
        return;
      }
      setState(() => _commands = commands);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _commands?.length ?? 0,
      itemBuilder: (context, index) => _commands == null
          ? const CircularProgressIndicator()
          : ListTile(
              title: SelectableText(
                _commands![index].name,
              ),
              subtitle: SelectableText(_commands![index].template),
            ),
    );
  }
}
