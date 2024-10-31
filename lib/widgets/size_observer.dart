import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef SizeCallback = void Function(Size size);

class _RenderSizeObserver extends RenderProxyBox {
  _RenderSizeObserver({
    RenderBox? child,
    required this.onLayoutChangedCallback,
  }) : super(child);

  final SizeCallback onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (size != _oldSize) {
      onLayoutChangedCallback(size);
    }
    _oldSize = size;
  }
}

class SizeObserver extends SingleChildRenderObjectWidget {
  const SizeObserver({
    super.key,
    required Widget super.child,
    required this.onSized,
  });

  final SizeCallback onSized;

  @override
  _RenderSizeObserver createRenderObject(BuildContext context) {
    return _RenderSizeObserver(
      onLayoutChangedCallback: onSized,
    );
  }
}
