import 'package:flutter/services.dart';
import 'package:int_flutter/platform/service.dart';

class PlatformServiceImpl implements PlatformService {
  static const stream = EventChannel('CALL_EVENTS');

  @override
  Stream<String> getStream() =>
      stream.receiveBroadcastStream().map((event) => event as String);
}
