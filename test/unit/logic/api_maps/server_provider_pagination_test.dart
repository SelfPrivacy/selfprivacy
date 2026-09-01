import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/pagination.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';

enum _Provider { hetzner, digitalOcean }

class _PaginationClientFactory {
  _PaginationClientFactory(
    this.provider, {
    this.emptyDroplets = false,
    this.failSecondDropletPage = false,
    this.invalidDropletNextPage = false,
  });

  final _Provider provider;
  final bool emptyDroplets;
  final bool failSecondDropletPage;
  final bool invalidDropletNextPage;
  final requests = <RequestOptions>[];

  Dio call(final BaseOptions options) => Dio(options)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (
              final RequestOptions request,
              final RequestInterceptorHandler handler,
            ) {
              requests.add(request);
              final page = request.queryParameters['page'] as int;
              if (failSecondDropletPage &&
                  request.path == '/droplets' &&
                  page == 2) {
                handler.reject(
                  DioException(
                    requestOptions: request,
                    type: DioExceptionType.connectionError,
                    error: 'second page failed',
                  ),
                );
                return;
              }
              handler.resolve(
                Response<dynamic>(
                  requestOptions: request,
                  statusCode: 200,
                  data: switch (provider) {
                    _Provider.hetzner => _hetznerResponse(request.path, page),
                    _Provider.digitalOcean => _digitalOceanResponse(
                      request.path,
                      page,
                    ),
                  },
                ),
              );
            },
      ),
    );

  Map<String, dynamic> _hetznerResponse(final String path, final int page) => {
    switch (path) {
      '/servers' => 'servers',
      '/volumes' => 'volumes',
      '/locations' => 'locations',
      '/server_types' => 'server_types',
      _ => throw StateError('Unexpected request: $path'),
    }: [
      switch (path) {
        '/servers' => _hetznerServer(page),
        '/volumes' => _hetznerVolume(page),
        '/locations' => _hetznerLocation(page),
        '/server_types' => _hetznerServerType(page),
        _ => throw StateError('Unexpected request: $path'),
      },
    ],
    'meta': {
      'pagination': {'next_page': page == 1 ? 2 : null},
    },
  };

  Map<String, dynamic> _digitalOceanResponse(
    final String path,
    final int page,
  ) => {
    switch (path) {
      '/droplets' => 'droplets',
      '/volumes' => 'volumes',
      '/regions' => 'regions',
      '/sizes' => 'sizes',
      _ => throw StateError('Unexpected request: $path'),
    }: emptyDroplets && path == '/droplets'
        ? <Object>[]
        : [
            switch (path) {
              '/droplets' => {'id': page, 'name': 'droplet-$page'},
              '/volumes' => _digitalOceanVolume(page),
              '/regions' => _digitalOceanLocation(page),
              '/sizes' => _digitalOceanServerType(page),
              _ => throw StateError('Unexpected request: $path'),
            },
          ],
    'links': {
      'pages': {
        if (page == 1 && !(emptyDroplets && path == '/droplets'))
          'next': invalidDropletNextPage && path == '/droplets'
              ? 'https://api.digitalocean.com/v2$path?per_page=200'
              : 'https://api.digitalocean.com/v2$path?page=2&per_page=200',
      },
    },
  };
}

Map<String, dynamic> _hetznerLocation(final int page) => {
  'name': 'fsn$page',
  'country': 'DE',
  'city': 'City $page',
  'description': 'Location $page',
  'network_zone': 'eu-central',
};

Map<String, dynamic> _hetznerServerType(final int page) => {
  'name': 'cpx$page',
  'description': 'CPX $page',
  'architecture': 'x86',
  'cores': page,
  'memory': page * 2,
  'disk': page * 20,
  'prices': <Object>[],
  'locations': <Object>[],
};

Map<String, dynamic> _hetznerServer(final int page) => {
  'id': page,
  'name': 'server-$page',
  'status': 'running',
  'created': '2026-09-01T12:00:00Z',
  'server_type': _hetznerServerType(page),
  'location': _hetznerLocation(page),
  'public_net': {'ipv4': null},
  'volumes': <int>[],
};

Map<String, dynamic> _hetznerVolume(final int page) => {
  'id': page,
  'size': page * 10,
  'server': null,
  'name': 'volume-$page',
  'linux_device': null,
  'location': _hetznerLocation(page),
};

Map<String, dynamic> _digitalOceanLocation(final int page) => {
  'slug': 'nyc$page',
  'name': 'New York $page',
};

Map<String, dynamic> _digitalOceanServerType(final int page) => {
  'regions': ['nyc$page'],
  'memory': page * 1024.0,
  'description': 'Basic $page',
  'disk': page * 25,
  'price_monthly': page * 6.0,
  'slug': 's-${page}vcpu',
  'vcpus': page,
};

Map<String, dynamic> _digitalOceanVolume(final int page) => {
  'id': 'volume-$page',
  'name': 'volume-$page',
  'size_gigabytes': page * 10,
  'droplet_ids': <int>[],
  'region': _digitalOceanLocation(page),
};

void main() {
  setUp(() {
    getIt.registerSingleton<ConsoleModel>(ConsoleModel());
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('Hetzner reads every page from each collection endpoint', () async {
    final clients = _PaginationClientFactory(_Provider.hetzner);
    final api = HetznerApi(token: 'token', clientFactory: clients.call);

    final servers = await api.getServers();
    final volumes = await api.getVolumes();
    final locations = await api.getAvailableLocations();
    final serverTypes = await api.getAvailableServerTypes();

    expect(servers.data.map((final item) => item.id), [1, 2]);
    expect(volumes.data.map((final item) => item.id), [1, 2]);
    expect(locations.data.map((final item) => item.name), ['fsn1', 'fsn2']);
    expect(serverTypes.data.map((final item) => item.name), ['cpx1', 'cpx2']);
    _expectPaginationRequests(clients.requests, perPage: 50);
  });

  test('DigitalOcean reads every page and preserves volume filters', () async {
    final clients = _PaginationClientFactory(_Provider.digitalOcean);
    final api = DigitalOceanApi(token: 'token', clientFactory: clients.call);

    final servers = await api.getServers();
    final volumes = await api.getVolumes(status: 'available');
    final locations = await api.getAvailableLocations();
    final serverTypes = await api.getAvailableServerTypes();

    expect(
      servers.data.map((final item) => (item as Map<String, dynamic>)['id']),
      [1, 2],
    );
    expect(volumes.data.map((final item) => item.id), ['volume-1', 'volume-2']);
    expect(locations.data.map((final item) => item.slug), ['nyc1', 'nyc2']);
    expect(serverTypes.data.map((final item) => item.slug), [
      's-1vcpu',
      's-2vcpu',
    ]);
    _expectPaginationRequests(clients.requests, perPage: 200);
    final volumeRequests = clients.requests.where(
      (final request) => request.path == '/volumes',
    );
    expect(
      volumeRequests.every(
        (final request) => request.queryParameters['status'] == 'available',
      ),
      isTrue,
    );
  });

  test('a later page failure does not return partial data', () async {
    final clients = _PaginationClientFactory(
      _Provider.digitalOcean,
      failSecondDropletPage: true,
    );
    final api = DigitalOceanApi(token: 'token', clientFactory: clients.call);

    final result = await api.getServers();

    expect(result.success, isFalse);
    expect(result.data, isEmpty);
  });

  test('an empty collection succeeds after one request', () async {
    final clients = _PaginationClientFactory(
      _Provider.digitalOcean,
      emptyDroplets: true,
    );
    final api = DigitalOceanApi(token: 'token', clientFactory: clients.call);

    final result = await api.getServers();

    expect(result.success, isTrue);
    expect(result.data, isEmpty);
    expect(clients.requests, hasLength(1));
  });

  test('malformed next-page metadata fails without partial data', () async {
    final clients = _PaginationClientFactory(
      _Provider.digitalOcean,
      invalidDropletNextPage: true,
    );
    final api = DigitalOceanApi(token: 'token', clientFactory: clients.call);

    final result = await api.getServers();

    expect(result.success, isFalse);
    expect(result.data, isEmpty);
    expect(clients.requests, hasLength(1));
  });

  test('the shared paginator rejects a non-advancing next page', () async {
    await expectLater(
      getAllPages<int>(
        (final page) async => PaginatedPage(items: [page], nextPage: page),
      ),
      throwsA(isA<FormatException>()),
    );
  });
}

void _expectPaginationRequests(
  final List<RequestOptions> requests, {
  required final int perPage,
}) {
  expect(requests, hasLength(8));
  for (var index = 0; index < requests.length; index += 2) {
    expect(requests[index].queryParameters['page'], 1);
    expect(requests[index + 1].queryParameters['page'], 2);
  }
  expect(
    requests.every(
      (final request) => request.queryParameters['per_page'] == perPage,
    ),
    isTrue,
  );
}
