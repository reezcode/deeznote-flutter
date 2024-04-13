import 'package:deeznote/app/data/models/state_model.dart';
import 'package:deeznote/app/domain/states/common_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Object none = Object();

/// Return by one or more condition with seamlessly
dynamic when(dynamic value, Map<dynamic, Function> cases) {
  if (cases[value] != null) {
    return cases[value]!();
  } else {
    return cases[none]!();
  }
}

dynamic incase(Map<bool, Function> cases) {
  if (cases.containsKey(true)) {
    return cases[true]!();
  } else if (cases.containsKey(false)) {
    return cases[false]!();
  } else {
    throw ArgumentError('No matching case found');
  }
}

/// Observe the state of an event and return a widget based on the state
/// </br> Observe using RsEvent which have 5 states: initial, loading, success, error, empty
/// Success and error state have their own data that can be access by event.value and event.state
Widget observe({
  required RexEvent event,
  Widget? initial,
  Widget? loading,
  Widget Function(dynamic data)? success,
  Widget Function(String msg)? error,
  Widget Function()? empty,
}) {
  return Obx(() {
    return when(event.value.event, {
      Event.initial: () => initial ?? const SizedBox(),
      Event.loading: () => loading,
      Event.success: () => success!(event.value.data),
      Event.error: () => error!(event.value.data),
      Event.empty: () => empty,
    });
  });
}

/// Flow the event by emitting state
/// </br> Use this function to change the state of an event
Future<void> flow(
    RexEvent e, Function(void Function(RsEvent newEvent) emit) func) async {
  func((RsEvent newEvent) {
    e.value = newEvent;
  });
}
