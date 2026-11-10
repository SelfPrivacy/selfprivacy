import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/forms/telemetry_form.dart';
import '../../../helpers/fixtures/telemetry_fixtures.dart';

void main() {
  late TelemetryForm form;
  setUp(() {
    form = TelemetryForm(aTelemetrySettings(enable: true));
  });
  tearDown(() => form.dispose());

  test('typing replaces a saved secret and removing a header sends null', () {
    expect(form.value.headers, isEmpty);
    form.headers.first.control('value').value = ' secret ';
    form.removeHeader(1);
    expect(form.headers, hasLength(2));
    expect(form.form.valid, isTrue);
    expect(form.value.headers, {'authorization': ' secret ', 'obsolete': null});
  });
  test('duplicate normalized header names are invalid', () {
    form.addHeader();
    form.headers.last.control('name').value = 'Authorization';
    form.headers.last.control('value').value = 'new';
    expect(form.form.valid, isFalse);
  });
  test('clearing a replacement keeps the saved secret', () {
    form.headers.first.control('value').value = 'replacement';
    expect(form.value.headers, {'authorization': 'replacement'});
    form.headers.first.control('value').value = '';
    expect(form.value.headers, isEmpty);
    expect(form.form.valid, true);
    expect(form.hasChanges, false);
  });
  test('removal can be undone without erasing a replacement', () {
    final header = form.headers.first;
    header.control('value').value = 'replacement';
    form.removeHeader(0);
    expect(form.value.headers, {'authorization': null});
    expect(header.control('value').value, 'replacement');
    header.control('removed').value = false;
    expect(form.value.headers, {'authorization': 'replacement'});
  });
  test('new headers need a value and can be discarded', () {
    form.addHeader();
    form.headers.last.control('name').value = 'x-token';
    expect(form.form.valid, isFalse);
    form.removeHeader(form.headers.length - 1);
    expect(form.form.valid, true);
    expect(form.value.headers, isEmpty);
  });
  test('header injection is invalid unless that header will be removed', () {
    final header = form.headers.first;
    header.control('value').value = 'token\r\nInjected: true';
    expect(form.form.valid, isFalse);
    form.removeHeader(0);
    expect(form.form.valid, true);
    expect(form.value.headers, {'authorization': null});
  });
  for (final endpoint in [
    'http://example.org:4317',
    'https://example.org',
    'https://example.org:0',
    'https://example.org:65536',
    'https://user:pass@example.org:4317',
    'https://@example.org:4317',
    'https://example.org:4317/path',
    'https://example.org:4317?secret=a',
    'https://bad_host:4317',
    'https://-bad.example:4317',
    'https://bad-.example:4317',
    'https://bad..example:4317',
  ]) {
    test('rejects endpoint $endpoint', () {
      form.form.control('enable').value = true;
      form.form.control('endpoint').value = endpoint;
      expect(form.form.valid, isFalse);
    });
  }
  for (final endpoint in [
    'https://example.org:4317',
    'https://example.org:443',
    'https://[::1]:4317',
  ]) {
    test('accepts endpoint $endpoint', () {
      form.form.control('enable').value = true;
      form.form.control('endpoint').value = endpoint;
      expect(form.form.valid, isTrue);
    });
  }
  test('disabled permits empty endpoint; enabling requires one', () {
    form.form.control('enable').value = false;
    form.form.control('endpoint').value = '';
    expect(form.form.valid, isTrue);
    form.form.control('enable').value = true;
    expect(form.form.valid, isFalse);
  });
  test('disabled controls keep endpoint, flags, and header patches', () async {
    form.headers.first.control('value').value = ' secret ';
    form.form.control('logs').value = false;
    form.form.control('enable').value = false;
    await pumpEventQueue();
    expect(form.form.control('endpoint').disabled, true);
    expect(form.form.control('logs').disabled, true);
    expect(form.form.control('metrics').disabled, true);
    expect(form.value.endpoint, 'https://collector.example.org:4317');
    expect(form.value.uploadSystemLogs, false);
    expect(form.value.headers, {'authorization': ' secret '});
    form.form.control('enable').value = true;
    await pumpEventQueue();
    expect(form.form.control('endpoint').enabled, true);
    expect(form.headers.first.control('value').value, ' secret ');
  });

  test('queued header patches can be edited without reading saved secrets', () {
    final queued = TelemetryForm(
      aTelemetrySettings(),
      pending: aTelemetryUpdate(
        headers: {
          'authorization': 'replacement',
          'obsolete': null,
          'x-token': 'new',
        },
      ),
    );
    addTearDown(queued.dispose);
    expect(queued.value.headers, {
      'authorization': 'replacement',
      'obsolete': null,
      'x-token': 'new',
    });
    expect(queued.hasChanges, false);
    expect(queued.headers[1].control('removed').value, true);
    queued.headers.first.control('value').value = '';
    expect(queued.value.headers, {'obsolete': null, 'x-token': 'new'});
    queued.headers.first.control('value').value = 'replacement';
    queued.form.control('metrics').value = false;
    expect(queued.hasChanges, true);
  });
}
