import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('appodeal_flutter');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  late List<MethodCall> calls;
  late Map<String, Object?> responses;

  setUp(() {
    calls = <MethodCall>[];
    responses = <String, Object?>{};
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return responses[call.method];
    });
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  group('Appodeal.setEndpoint', () {
    test('sends setEndpoint with the endpoint argument', () async {
      const url = 'https://provided-endpoint.example.com';

      await Appodeal.setEndpoint(url);

      expect(calls, hasLength(1));
      expect(calls.single.method, 'setEndpoint');
      expect(calls.single.arguments, {'endpoint': url});
    });

    test('completes once the platform has handled the call', () async {
      await expectLater(
          Appodeal.setEndpoint('https://example.com'), completes);
      expect(calls.map((c) => c.method), ['setEndpoint']);
    });

    test('forwards an empty string unchanged', () async {
      await Appodeal.setEndpoint('');

      expect(calls.single.method, 'setEndpoint');
      expect(calls.single.arguments, {'endpoint': ''});
    });

    test('is delivered before a subsequent initialize call', () async {
      responses['getEndpoint'] = 'https://example.com';

      await Appodeal.setEndpoint('https://example.com');
      Appodeal.initialize(appKey: 'key', adTypes: [AppodealAdType.Interstitial]);
      // Give the fire-and-forget initialize call a chance to reach the channel.
      await Appodeal.getEndpoint();

      expect(calls.map((c) => c.method),
          ['setEndpoint', 'initialize', 'getEndpoint']);
    });
  });

  group('Appodeal.getEndpoint', () {
    test('returns the endpoint reported by the platform', () async {
      responses['getEndpoint'] = 'https://provided-endpoint.example.com';

      final endpoint = await Appodeal.getEndpoint();

      expect(endpoint, 'https://provided-endpoint.example.com');
      expect(calls.single.method, 'getEndpoint');
      expect(calls.single.arguments, isNull);
    });
  });

  group('Appodeal Bidon endpoint', () {
    test('setBidonEndpoint sends the endpoint argument', () async {
      const url = 'https://bidon.example.com/api';

      Appodeal.setBidonEndpoint(url);
      // setBidonEndpoint is fire-and-forget; flush it through the channel.
      await Appodeal.getBidonEndpoint();

      expect(calls.first.method, 'setBidonEndpoint');
      expect(calls.first.arguments, {'endpoint': url});
    });

    test('getBidonEndpoint returns the platform value', () async {
      responses['getBidonEndpoint'] = 'https://bidon.example.com/api';

      expect(await Appodeal.getBidonEndpoint(), 'https://bidon.example.com/api');
      expect(calls.single.method, 'getBidonEndpoint');
    });

    test('getBidonEndpoint returns null when nothing is set', () async {
      expect(await Appodeal.getBidonEndpoint(), isNull);
    });
  });
}
