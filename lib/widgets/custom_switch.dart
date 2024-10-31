import 'package:flutter/material.dart';
import 'package:study/helpers/utils/mixins/ui_mixin.dart';
import 'package:study/helpers/widgets/my_spacing.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  final double width, height;
  final double thumbSize;
  final double spacingOfThumbTrack;

  final Color? activeBorderColor, inactiveBorderColor;

  CustomSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.width = 56,
    this.height = 28,
    this.thumbSize = 22, // this.activeTrackColor,
    // this.inactiveTrackColor,
    // this.activeThumbColor,
    // this.inactiveThumbColor,
    this.spacingOfThumbTrack = 4,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  CustomSwitch.normal({
    super.key,
    required this.value,
    this.onChanged,
    this.width = 48,
    this.height = 24,
    this.thumbSize = 20, // this.activeTrackColor,
    // this.inactiveTrackColor,
    // this.activeThumbColor,
    // this.inactiveThumbColor,
    this.spacingOfThumbTrack = 4,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  CustomSwitch.small({
    super.key,
    required this.value,
    this.onChanged,
    this.width = 32,
    this.height = 16,
    this.thumbSize = 13.5, // this.activeTrackColor,
    // this.inactiveTrackColor,
    // this.activeThumbColor,
    // this.inactiveThumbColor,
    this.spacingOfThumbTrack = 2.5,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin, UIMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Switch(value: true, onChanged: (v){});
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: MySpacing.all(widget.spacingOfThumbTrack),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.value
                    ? rightBarTheme.activeSwitchBorderColor
                    : rightBarTheme.onDisabled,
                width: 0.6),
            borderRadius: BorderRadius.circular(widget.height / 2),
            color:
                !widget.value ? rightBarTheme.disabled : colorScheme.primary),
        child: Align(
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: widget.thumbSize,
            height: widget.thumbSize,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !widget.value
                    ? rightBarTheme.onDisabled
                    : colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
