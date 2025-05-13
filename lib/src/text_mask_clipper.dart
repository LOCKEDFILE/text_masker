part of 'masked_text.dart';

class _TextMaskClipper extends CustomClipper<Rect> {
  final double top;
  final double left;
  final double width;
  final double height;

  const _TextMaskClipper({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  @override
  Rect getClip(Size size) => Rect.fromLTWH(left, top, width, height);

  @override
  bool shouldReclip(covariant _TextMaskClipper oldClipper) =>
      top != oldClipper.top ||
      left != oldClipper.left ||
      width != oldClipper.width ||
      height != oldClipper.height;
}
