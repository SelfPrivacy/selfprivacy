import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

class UpdateChannel {
  const UpdateChannel({
    required this.id,
    required this.updateUrl,
    required this.name,
    required this.description,
  });

  UpdateChannel.fromGraphQL(final Fragment$updateChannelFields channel)
    : this(
        id: channel.id,
        updateUrl: channel.updateUrl,
        name: channel.name,
        description: channel.description,
      );

  final String id;
  final String updateUrl;
  final String name;
  final String description;
}

class UpdateChannels {
  UpdateChannels({
    required this.currentChannel,
    required final Iterable<UpdateChannel> channels,
  }) : channels = List.unmodifiable(channels);

  UpdateChannels.fromGraphQL(
    final Query$GetUpdateChannels$system$updates updates,
  ) : this(
        currentChannel: UpdateChannel.fromGraphQL(updates.currentChannel),
        channels: updates.channels.map(UpdateChannel.fromGraphQL),
      );

  final UpdateChannel currentChannel;
  final List<UpdateChannel> channels;
}
