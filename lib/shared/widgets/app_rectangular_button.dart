import 'package:flutter/material.dart';
import 'package:byamn/core/theme/app_text_style.dart';

class RectangularAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double maxWidth;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? icon;

  const RectangularAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.enabled = true,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    this.maxWidth = 260,
    this.color,
    this.textColor,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = color ?? theme.colorScheme.primary;
    final txtColor = textColor ?? Colors.white;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: SizedBox(
        width: double.infinity, // take full width up to maxWidth
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled ? bgColor : bgColor.withOpacity(0.6),
            foregroundColor: txtColor,
            disabledBackgroundColor: bgColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
          ),
          onPressed: enabled && !loading ? onPressed : null,
          child: loading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        style: tStyleSemiBold(color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
