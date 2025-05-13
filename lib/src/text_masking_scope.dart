import 'package:flutter/material.dart';
import 'package:text_masker/src/mask_position_store.dart';

class TextMaskingScope extends StatelessWidget {
  final Widget child;
  const TextMaskingScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final registryState = MaskPositionStore();
    return MaskPositionProvider(
      state: registryState,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          registryState.triggerUpdate(); // 스크롤 시 위치 갱신 트리거
          return false;
        },
        child: child,
      ),
    );
  }
}
