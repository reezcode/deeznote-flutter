// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:deeznote/app/domain/states/common_state.dart';

/// RsEvent is state of data to help building the ui
class RsEvent<T> {
  Event event;
  T? data;
  RsEvent({
    this.event = Event.initial,
    this.data,
  });

  static RsEvent initial() {
    const e = Event.initial;
    return RsEvent(event: e);
  }

  static RsEvent loading() {
    const e = Event.loading;
    return RsEvent(event: e);
  }

  static RsEvent success<T>(T data) {
    const e = Event.success;
    var d = data;
    return RsEvent(event: e, data: d);
  }

  static RsEvent error<T>(T data) {
    const e = Event.error;
    var d = data;
    return RsEvent(event: e, data: d);
  }

  static RsEvent empty() {
    const e = Event.empty;
    return RsEvent(event: e);
  }

  static RsEvent clear() {
    const e = Event.initial;
    return RsEvent(event: e, data: null);
  }
}

/// RexEvent is reactiveX RsEvent that help RsEvent can observe
class RexEvent {
  final Rx<RsEvent> _event;
  RexEvent(RsEvent e) : _event = e.obs;

  RsEvent get value => _event.value;
  set value(RsEvent e) => _event.value = e;

  static RexEvent init() {
    return RexEvent(RsEvent.initial());
  }
}
