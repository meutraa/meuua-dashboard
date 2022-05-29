import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'model/channel_settings.dart';
import 'model/command.dart';
import 'model/twitch_user_response.dart';
import 'model/user.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://api.meuua.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/channels')
  Future<List<User>> getChannels();

  @GET('/channels/{id}')
  Future<ChannelSettings> getChannelSettings(@Path('id') String channelId);

  @PATCH('/channels/{id}')
  Future<ChannelSettings> patchChannelSettings({
    @Path('id') required String channelId,
    @Header('Authorization') required String authorization,
    @Body() required ChannelSettings settings,
  });

  @PUT('/channels/{id}')
  Future<void> register({
    @Path('id') required String channelId,
    @Header('Authorization') required String authorization,
  });

  @DELETE('/channels/{id}')
  Future<void> unregister({
    @Path('id') required String channelId,
    @Header('Authorization') required String authorization,
  });

  @GET('/commands')
  Future<List<Command>> getGlobalCommands();

  @GET('/channels/{id}/commands')
  Future<List<Command>> getCommands({
    @Path('id') required String channelId,
  });

  @GET('/channels/{id}/approvals')
  Future<List<User>> getApprovals({
    @Path('id') required String channelId,
  });

  @GET('https://api.twitch.tv/helix/users')
  Future<TwitchUserResponse> getProfile(
    @Header('Authorization') String accessToken,
    @Header('Client-Id') String clientId,
  );
}
