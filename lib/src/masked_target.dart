import 'package:flutter/material.dart';
import 'package:text_masker/src/mask_position_store.dart';

class MaskedTarget extends StatefulWidget {
  final String id;
  final Widget child;

  const MaskedTarget({super.key, required this.id, required this.child});

  @override
  State<MaskedTarget> createState() => _MaskedTargetState();
}

class _MaskedTargetState extends State<MaskedTarget> {
  final GlobalKey _key = GlobalKey();

  void _register() {
    final context = _key.currentContext;
    if (context == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final rect = box.localToGlobal(Offset.zero) & box.size;
    MaskPositionProvider.of(context)?.register(widget.id, rect);
  }

  @override
  Widget build(BuildContext context) {
    final registry = MaskPositionProvider.of(context);

    return AnimatedBuilder(
      animation: registry!,
      builder: (context, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _register());
        return KeyedSubtree(key: _key, child: widget.child);
      },
    );
  }
}
