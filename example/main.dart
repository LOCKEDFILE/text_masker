import 'package:flutter/material.dart';
import 'package:text_masker/text_masker.dart';

void main() {
  runApp(const MaterialApp(
    home: MaskedTextDemoPage(),
  ));
}

class MaskedTextDemoPage extends StatelessWidget {
  const MaskedTextDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextMaskingScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Masked Text Demo')),
        body: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                ),
                Row(
                  children: [
                    MaskedTarget(
                      id: 'one',
                      child: Container(
                        height: 300,
                        color: Colors.black,
                        width: 200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20, width: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaskedTarget(
                      id: 'two',
                      child: Container(
                        height: 300,
                        color: Colors.black,
                        width: 300,
                      ),
                    ),
                  ],
                ),
                Container(height: 100),
                MaskedTarget(
                  id: 'three',
                  child: Container(height: 300, color: Colors.black),
                ),
                Container(height: 600),
              ],
            ),
            const Positioned(
              top: 0,
              left: 20,
              child: MaskedText(
                idList: ['one', 'two'],
                text: 'Masked Text',
                textStyle: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maskColor: Colors.white,
              ),
            ),
            const Positioned(
              top: 86,
              left: 20,
              child: MaskedText(
                idList: ['one', 'two', 'three'],
                text: 'Masked Text is here\nand there',
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: Colors.black,
                ),
                maskColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
