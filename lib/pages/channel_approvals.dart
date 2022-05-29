import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../avatar.dart';
import '../model/user.dart';

class ChannelApprovalsPage extends StatefulWidget {
  final String channelId;

  const ChannelApprovalsPage({
    required this.channelId,
    super.key,
  });

  @override
  State<ChannelApprovalsPage> createState() => ChannelApprovalsPageState();
}

class ChannelApprovalsPageState extends State<ChannelApprovalsPage>
    with AutomaticKeepAliveClientMixin {
  List<User>? _users;

  @override
  bool get wantKeepAlive => _users != null;

  @override
  void initState() {
    super.initState();

    RestClient(Dio())
        .getApprovals(channelId: widget.channelId)
        .then((List<User> users) {
      if (!mounted) {
        return;
      }
      setState(() => _users = users);
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
          'Approved Bots',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const Divider(
          indent: 32,
          endIndent: 32,
          height: 24,
        ),
        ..._users
                ?.map((u) => ListTile(
                      key: ValueKey(u.id),
                      leading: Avatar(
                        url: u.profileImageUrl,
                        size: 48,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            u.displayName,
                            maxLines: 3,
                          ),
                          Text(
                            '${u.viewCount} views',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(
                        u.description,
                        maxLines: 3,
                      ),
                    ))
                .toList() ??
            [],
      ],
    );
  }
}
