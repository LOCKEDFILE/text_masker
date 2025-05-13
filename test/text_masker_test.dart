import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_masker/text_masker.dart';

void main() {
  testWidgets('MaskedText renders only when target is present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TextMaskingScope(
          child: Stack(
            children: [
              MaskedTarget(
                id: 'target',
                child: Container(
                  key: const Key('target_container'),
                  height: 100,
                  width: 100,
                  color: Colors.black,
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                child: MaskedText(
                  idList: ['target'],
                  text: 'Hello',
                  textStyle: TextStyle(color: Colors.black),
                  maskColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // 텍스트가 실제로 렌더링되었는지 확인
    final textFinder = find.text('Hello');
    expect(textFinder, findsOneWidget);

    // 타겟이 존재하는지도 확인
    final targetFinder = find.byKey(const Key('target_container'));
    expect(targetFinder, findsOneWidget);
  });
}
