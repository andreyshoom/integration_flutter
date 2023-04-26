@JS('ClicksNamespace')
library interop;

import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:js/js.dart';

@JS('JsInteropEvent')
class _JsInteropEvent {
  external String value;
}

@JS('JsInteropEventType')
class EventType {
  // ignore: non_constant_identifier_names
  external static String get InteropEvent;
}

typedef _ClicksManagerEventListener = void Function(_JsInteropEvent event);

@JS('JsInteropManager')
class _JsInteropManager {
  external _JsInteropManager get buttonElement;
  external _JsInteropManager get inputElement;

//  external dynamic get buttonElement; // в уроке было dynamic

  external void addEventListener(
    String event,
    _ClicksManagerEventListener listener,
  );

  external void removeEventListener(
    String event,
    _ClicksManagerEventListener listener,
  );
}

class _EventStreamProvider {
  final _JsInteropManager _eventTarget;
  final List<StreamController<dynamic>> _controllers = [];

  _EventStreamProvider.forTarget(this._eventTarget);

  Stream<T> forEvent<T extends _JsInteropEvent>(String eventType) {
    late StreamController<T> controller;
    void _onEventReceived(event) {
      controller.add(event as T);
    }

    final _interroped = allowInterop(_onEventReceived);

    controller = StreamController.broadcast(
      onCancel: () => _eventTarget.removeEventListener(
        eventType,
        _interroped,
      ),
      onListen: () => _eventTarget.addEventListener(
        eventType,
        _interroped,
      ),
    );
    _controllers.add(controller);

    return controller.stream;
  }

  void dispose() {
    _controllers.forEach((controller) => controller.close());
  }
}

class InteropManager {
  final _interop = _JsInteropManager();
  late Stream<String> _buttonClicked;

  InteropManager() {
    final _streamProvider = _EventStreamProvider.forTarget(_interop);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-input',
      (viewId) => _interop.inputElement,
    );
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-button',
      (viewId) => _interop.buttonElement,
    );

    _buttonClicked = _streamProvider
        .forEvent<_JsInteropEvent>(
          'InteropEvent',
        )
        .map((event) => event.value);
  }

  Stream<String> get buttonClicked => _buttonClicked;
}
