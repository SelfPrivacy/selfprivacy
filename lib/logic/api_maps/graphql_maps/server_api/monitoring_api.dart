part of 'server_api.dart';

mixin MonitoringApi on GraphQLApiMap {
  Future<GenericResult<ServerMetrics?>> getServerMetrics({
    required final int step,
    required final DateTime start,
    required final DateTime end,
  }) async {
    QueryResult<Query$GetOverallCpuAndNetworkMetrics> response;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$GetOverallCpuAndNetworkMetrics(
        step: step,
        start: start,
        end: end,
      );
      final query = Options$Query$GetOverallCpuAndNetworkMetrics(
        variables: variables,
      );
      response = await client.query$GetOverallCpuAndNetworkMetrics(query);
      if (response.hasException) {
        logger(response.exception.toString());
        return GenericResult<ServerMetrics?>(success: false, data: null);
      }
      if (response.parsedData == null) {
        return GenericResult<ServerMetrics?>(success: false, data: null);
      }
      if (response.parsedData?.monitoring.cpuUsage.overallUsage
              is Fragment$MonitoringQueryError ||
          response.parsedData?.monitoring.networkUsage.overallUsage
              is Fragment$MonitoringQueryError) {
        return GenericResult<ServerMetrics?>(success: false, data: null);
      }
      final metrics = ServerMetrics.fromGraphQL(
        data: response.parsedData!.monitoring,
        stepsInSecond: step,
        start: start,
        end: end,
      );
      return GenericResult<ServerMetrics?>(success: true, data: metrics);
    } catch (e) {
      logger("Couldn't load sever metrics", error: e);
      return GenericResult<ServerMetrics?>(
        success: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<MemoryMetrics?>> getMemoryMetrics({
    required final int step,
    required final DateTime start,
    required final DateTime end,
  }) async {
    QueryResult<Query$GetMemoryMetrics> response;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$GetMemoryMetrics(
        step: step,
        start: start,
        end: end,
      );
      final query = Options$Query$GetMemoryMetrics(variables: variables);
      response = await client.query$GetMemoryMetrics(query);
      if (response.hasException) {
        logger(response.exception.toString());
        return GenericResult<MemoryMetrics?>(success: false, data: null);
      }
      if (response.parsedData == null) {
        return GenericResult<MemoryMetrics?>(success: false, data: null);
      }
      if (response.parsedData?.monitoring.memoryUsage.overallUsage
              is Fragment$MonitoringQueryError ||
          response.parsedData?.monitoring.memoryUsage.averageUsageByService
              is Fragment$MonitoringQueryError ||
          response.parsedData?.monitoring.memoryUsage.maxUsageByService
              is Fragment$MonitoringQueryError) {
        return GenericResult<MemoryMetrics?>(success: false, data: null);
      }
      final metrics = MemoryMetrics.fromGraphQL(
        data: response.parsedData!.monitoring,
        stepsInSecond: step,
        start: start,
        end: end,
      );
      return GenericResult<MemoryMetrics?>(success: true, data: metrics);
    } catch (e) {
      logger("Couldn't get memory metrics", error: e);
      return GenericResult<MemoryMetrics?>(
        success: false,
        data: null,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<DiskMetrics?>> getDiskMetrics({
    required final int step,
    required final DateTime start,
    required final DateTime end,
  }) async {
    QueryResult<Query$GetDiskMetrics> response;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$GetDiskMetrics(
        step: step,
        start: start,
        end: end,
      );
      final query = Options$Query$GetDiskMetrics(variables: variables);
      response = await client.query$GetDiskMetrics(query);
      if (response.hasException) {
        logger(response.exception.toString());
        return GenericResult<DiskMetrics?>(success: false, data: null);
      }
      if (response.parsedData == null) {
        return GenericResult<DiskMetrics?>(success: false, data: null);
      }
      if (response.parsedData?.monitoring.diskUsage.overallUsage
          is Fragment$MonitoringQueryError) {
        return GenericResult<DiskMetrics?>(success: false, data: null);
      }
      final metrics = DiskMetrics.fromGraphQL(
        data: response.parsedData!.monitoring,
        stepsInSecond: step,
        start: start,
        end: end,
      );
      return GenericResult<DiskMetrics?>(success: true, data: metrics);
    } catch (e) {
      logger("Couldn't get disk metrics", error: e);
      return GenericResult<DiskMetrics?>(
        success: false,
        data: null,
        message: e.toString(),
      );
    }
  }
}
