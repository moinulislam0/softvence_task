import 'package:flutter/material.dart';
import 'package:softvence_task/common_widget/switch/src/theme/theme.dart';

class AppSwitch extends StatefulWidget {
  final bool initialValue;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final Color? focusColor;

  final Color? hoverColor;

  final double? splashRadius;

  final AppSwitchTheme? switchTheme;

  const AppSwitch({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.switchTheme,
  });

  @override
  AppSwitchState createState() => AppSwitchState();
}

class AppSwitchState extends State<AppSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didUpdateWidget(AppSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  void _handleChanged(bool? newValue) {
    if (newValue != null && widget.enabled) {
      setState(() {
        _value = newValue;
      });
      widget.onChanged?.call(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final scaleValue = widget.switchTheme?.scale ?? 0.7;
    const double thumbSize = 10.0;

    return Transform.scale(
      scale: scaleValue,
      child: Switch(
        value: _value,
        onChanged: widget.enabled ? _handleChanged : null,
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
          return const Icon(
            Icons.circle,
            color: Colors.transparent,
            size: thumbSize,
          );
        }),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return widget.switchTheme?.activeThumbColor ??
                theme.colorScheme.primary;
          }
          return widget.switchTheme?.inactiveThumbColor ??
              theme.colorScheme.onSurface;
        }),
        activeTrackColor:
            widget.switchTheme?.activeTrackColor ??
            theme.colorScheme.primary.withOpacity(
              0.5,
            ), // withValues এর বদলে withOpacity
        inactiveTrackColor:
            widget.switchTheme?.inactiveTrackColor ??
            theme.colorScheme.onSurface.withOpacity(
              0.3,
            ), // withValues এর বদলে withOpacity
        trackOutlineWidth: WidgetStateProperty.all(
          widget.switchTheme?.trackOutlineWidth ?? 0,
        ),
        trackOutlineColor: WidgetStateProperty.all(
          widget.switchTheme?.trackOutlineColor ?? Colors.transparent,
        ),
        materialTapTargetSize:
            widget.switchTheme?.materialTapTargetSize ??
            MaterialTapTargetSize.shrinkWrap,
        focusColor: widget.focusColor,
        hoverColor: widget.hoverColor,
        splashRadius: widget.splashRadius,
      ),
    );
  }
}
