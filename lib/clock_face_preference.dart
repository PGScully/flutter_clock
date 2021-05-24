import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockFaceProvider =
    StateNotifierProvider<ClockFacePreference, bool>((_) => ClockFacePreference());

class ClockFacePreference extends StateNotifier<bool> {
  ClockFacePreference() : super(false);

  bool get analog => state;

  set analog(bool analog) => state = analog;
}
