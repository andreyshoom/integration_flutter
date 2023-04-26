import 'package:int_flutter/platform/service.dart';
import 'package:int_flutter/platform/web/web_interop.dart';

class PlatformServiceImpl implements PlatformService {
  final _manager = InteropManager();

  @override
  Stream<String> getStream() => _manager.buttonClicked;
}
