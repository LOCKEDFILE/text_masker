import 'package:flutter/material.dart';

class MaskPositionStore extends ChangeNotifier {
  final Map<String, Rect> _rects = {};

  void register(String id, Rect rect) {
    if (_rects[id] != rect) {
      _rects[id] = rect;
      notifyListeners();
    }
  }

  Rect? getRect(String id) => _rects[id];

  void triggerUpdate() => notifyListeners();
}

class MaskPositionProvider extends StatelessWidget {
  final Widget child;
  final MaskPositionStore state;

  const MaskPositionProvider(
      {super.key, required this.child, required this.state});

  static MaskPositionStore? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedMaskNotifier>()
        ?.notifier;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedMaskNotifier(
      notifier: state,
      child: child,
    );
  }
}

class _InheritedMaskNotifier extends InheritedNotifier<MaskPositionStore> {
  const _InheritedMaskNotifier({
    required MaskPositionStore notifier,
    required super.child,
  }) : super(notifier: notifier);
}
