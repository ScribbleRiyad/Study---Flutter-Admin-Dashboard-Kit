import 'package:flutter/material.dart';
import 'package:study/helpers/widgets/my_display_type.dart';
import 'package:study/helpers/widgets/my_screen_media.dart';
import 'package:study/helpers/widgets/my_screen_media_type.dart';

class MyFlexItem extends StatelessWidget {
  final Widget child;
  final String? sizes;
  final String? displays;

  Map<MyScreenMediaType, int> get flex =>
      MyScreenMedia.getFlexedDataFromString(sizes);

  Map<MyScreenMediaType, MyDisplayType> get display =>
      MyScreenMedia.getDisplayDataFromString(displays);

  MyFlexItem({
    super.key,
    required this.child,
    this.sizes,
    this.displays,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
