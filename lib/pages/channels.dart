import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../avatar.dart';
import '../model/user.dart';

class ChannelsPage extends StatefulWidget {
  final Function(User user) onUserSelected;

  const ChannelsPage({
    required this.onUserSelected,
    super.key,
  });

  @override
  State<ChannelsPage> createState() => ChannelsPageState();
}

class ChannelsPageState extends State<ChannelsPage>
    with AutomaticKeepAliveClientMixin {
  List<User>? _users;

  ChannelsPageState();

  @override
  bool get wantKeepAlive => _users != null;

  @override
  void initState() {
    RestClient(Dio())
        .getChannels()
        .then((List<User> users) => setState(() => _users = users));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _users?.length ?? 0,
      itemBuilder: (context, index) => _users == null
          ? const CircularProgressIndicator()
          : ListTile(
              onTap: () => widget.onUserSelected(_users![index]),
              leading: Avatar(
                url: _users![index].profileImageUrl,
                size: 48,
              ),
              title: Text(_users![index].displayName),
              subtitle: Text(_users![index].description),
              trailing: Text(
                '${_users![index].viewCount} views',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
    );
  }
}
