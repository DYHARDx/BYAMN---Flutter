import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:byamn/core/theme/app_string_dimensions.dart';
import 'package:byamn/core/theme/app_text_style.dart';

class RectangularAppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final Widget? prefixWidget;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String? errorText;
  final FocusNode? focusNode;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const RectangularAppTextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.label,
    this.hintText,
    this.prefixWidget,
    this.prefixIcon,
    this.suffixWidget,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.borderRadius = 8.0,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 12.0,
    ),
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorText,
    this.focusNode,
    this.autofocus = false,
    this.inputFormatters,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveFillColor =
        fillColor ?? theme.inputDecorationTheme.fillColor ?? Colors.transparent;
    final effectiveBorderColor =
        borderColor ?? theme.dividerColor.withOpacity(0.2);

    InputBorder _buildBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color, width: borderWidth),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      style: textStyle ?? theme.textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            labelStyle ??
            theme.textTheme.labelSmall?.copyWith(color: theme.hintColor),
        hintText: hintText,
        hintStyle:
            hintStyle ??
            theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor.withOpacity(0.8),
            ),
        filled: true,
        fillColor: effectiveFillColor,
        contentPadding: contentPadding,
        isDense: true,
        prefixIcon:
            prefixWidget ?? (prefixIcon != null ? Icon(prefixIcon) : null),
        suffixIcon:
            suffixWidget ?? (suffixIcon != null ? Icon(suffixIcon) : null),
        enabledBorder: _buildBorder(effectiveBorderColor),
        focusedBorder: _buildBorder(theme.colorScheme.primary),
        errorBorder: _buildBorder(Colors.redAccent.shade100),
        focusedErrorBorder: _buildBorder(Colors.redAccent.shade400),
        errorText: errorText,
        errorStyle: tStyleRegular(
          fontSize: Dimen.FONT_SIZE_11,
          color: Colors.red,
        ),
      ),
    );
  }
}
