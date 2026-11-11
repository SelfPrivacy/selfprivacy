import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

void main() {
  setUp(() => getIt.registerSingleton<ConsoleModel>(ConsoleModel()));
  tearDown(getIt.reset);

  for (final provider in [
    ServerProviderType.hetzner,
    ServerProviderType.digitalOcean,
  ]) {
    for (final resource in ['server', 'volume']) {
      for (final status in [404, 500]) {
        test(
          '${provider.name} $resource deletion handles HTTP $status',
          () async {
            final requests = <RequestOptions>[];
            Dio clientFactory(final BaseOptions options) =>
                Dio(options)
                  ..interceptors.add(
                    InterceptorsWrapper(
                      onRequest: (final request, final handler) {
                        requests.add(request);
                        handler.reject(
                          DioException(
                            requestOptions: request,
                            response: Response<void>(
                              requestOptions: request,
                              statusCode: status,
                            ),
                            type: DioExceptionType.badResponse,
                          ),
                        );
                      },
                    ),
                  );
            final result = provider == ServerProviderType.hetzner
                ? resource == 'server'
                      ? await HetznerApi(
                          token: 'token',
                          clientFactory: clientFactory,
                        ).deleteServer(serverId: 7)
                      : await HetznerApi(
                          token: 'token',
                          clientFactory: clientFactory,
                        ).deleteVolume(41)
                : resource == 'server'
                ? await DigitalOceanApi(
                    token: 'token',
                    clientFactory: clientFactory,
                  ).deleteServer(7)
                : await DigitalOceanApi(
                    token: 'token',
                    clientFactory: clientFactory,
                  ).deleteVolume('volume-uuid');

            expect(result.success, status == 404);
            if (status != 404) {
              expect(result.code, status);
            }
            expect(requests, hasLength(1));
            expect(requests.single.method, 'DELETE');
            expect(requests.single.path, switch ((provider, resource)) {
              (ServerProviderType.hetzner, 'server') => '/servers/7',
              (ServerProviderType.hetzner, _) => '/volumes/41',
              (_, 'server') => '/droplets/7',
              _ => '/volumes/volume-uuid',
            });
          },
        );
      }
    }
  }
}
