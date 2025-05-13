import 'package:flutter/material.dart';
import 'package:text_masker/src/mask_position_store.dart';
part 'text_mask_clipper.dart';


class MaskedText extends StatelessWidget {
  final String text;
  final List<String> idList;
  final TextStyle? textStyle;
  final Color maskColor;

  const MaskedText({
    super.key,
    required this.text,
    required this.idList,
    this.textStyle,
    this.maskColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final registry = MaskPositionProvider.of(context);

    return AnimatedBuilder(
      animation: registry!,
      builder: (context, _) {
        final selfBox = context.findRenderObject() as RenderBox?;
        final selfOffset = selfBox?.localToGlobal(Offset.zero) ?? Offset.zero;
        final screenSize = MediaQuery.of(context).size;

        return Stack(
          children: [
            Text(text, style: textStyle),
            for (final id in idList)
              if (registry.getRect(id) case final rect?)
                _buildMasked(rect, selfOffset, screenSize),
          ],
        );
      },
    );
  }

  Widget _buildMasked(Rect rect, Offset selfOffset, Size screenSize) {
    final localTop = rect.top - selfOffset.dy;
    final localLeft = rect.left - selfOffset.dx;
    final localBottom = rect.bottom - selfOffset.dy;
    final localRight = rect.right - selfOffset.dx;

    final double width = (localRight - localLeft).clamp(0, double.infinity);
    final double height = (localBottom - localTop).clamp(0, double.infinity);

    return ClipRect(
      clipper: _TextMaskClipper(
        top: localTop,
        left: localLeft,
        width: width,
        height: height,
      ),
      child: Text(text, style: textStyle?.copyWith(color: maskColor)),
    );
  }
}
