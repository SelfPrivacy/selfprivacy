import 'package:graphql/client.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/services.graphql.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

class ServerApi extends ApiMap {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken = '',
  }) {
    final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
    rootAddress = serverDomain?.domainName ?? '';
  }
  @override
  bool hasLogger;
  @override
  bool isWithToken;
  @override
  String customToken;
  @override
  String? rootAddress;

  Future<bool> _commonBoolRequest(final Function graphQLMethod) async {
    QueryResult response;
    bool result = false;

    try {
      response = await graphQLMethod();
      if (response.hasException) {
        print(response.exception.toString());
        result = false;
      } else {
        result = true;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<String?> getApiVersion() async {
    QueryResult response;
    String? apiVersion;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiVersion();
      if (response.hasException) {
        print(response.exception.toString());
      }
      apiVersion = response.data!['api']['version'];
    } catch (e) {
      print(e);
    }
    return apiVersion;
  }

  Future<List<ApiToken>> getApiTokens() async {
    QueryResult response;
    List<ApiToken> tokens = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiTokens();
      if (response.hasException) {
        print(response.exception.toString());
      }
      tokens = response.data!['api']['devices']
          .map<ApiToken>((final e) => ApiToken.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return tokens;
  }

  Future<List<ServerDiskVolume>> getServerDiskVolumes() async {
    QueryResult response;
    List<ServerDiskVolume> volumes = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetServerDiskVolumes();
      if (response.hasException) {
        print(response.exception.toString());
      }
      volumes = response.data!['storage']['volumes']
          .map<ServerDiskVolume>((final e) => ServerDiskVolume.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return volumes;
  }

  Future<void> mountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$MountVolume(name: volumeName);
      final mountVolumeMutation =
          Options$Mutation$MountVolume(variables: variables);
      await client.mutate$MountVolume(mountVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> unmountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$UnmountVolume(name: volumeName);
      final unmountVolumeMutation =
          Options$Mutation$UnmountVolume(variables: variables);
      await client.mutate$UnmountVolume(unmountVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> resizeVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$ResizeVolume(name: volumeName);
      final resizeVolumeMutation =
          Options$Mutation$ResizeVolume(variables: variables);
      await client.mutate$ResizeVolume(resizeVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<List<ServerJob>> getServerJobs() async {
    QueryResult response;
    List<ServerJob> jobs = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiJobs();
      if (response.hasException) {
        print(response.exception.toString());
      }
      jobs = response.data!['jobs']
          .map<ServerJob>((final e) => ServerJob.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return jobs;
  }

  Future<void> removeApiJob(final String uid) async {
    try {
      final GraphQLClient client = await getClient();
      //await client.query$GetApiJobsQuery();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> reboot() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$RebootSystem();
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> pullConfigurationUpdate() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$PullRepositoryChanges();
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> upgrade() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$RunSystemUpgrade();
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> switchService(final String uid, final bool needTurnOn) async {
    try {
      final GraphQLClient client = await getClient();
      if (needTurnOn) {
        final variables = Variables$Mutation$EnableService(serviceId: uid);
        final mutation = Options$Mutation$EnableService(variables: variables);
        await client.mutate$EnableService(mutation);
      } else {
        final variables = Variables$Mutation$DisableService(serviceId: uid);
        final mutation = Options$Mutation$DisableService(variables: variables);
        await client.mutate$DisableService(mutation);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> apply() async {
    try {
      final GraphQLClient client = await getClient();
      await client.mutate$RunSystemRebuild();
    } catch (e) {
      print(e);
    }
  }
}
