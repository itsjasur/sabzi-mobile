import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String? hintText;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final int? hintMaxLines;
  final bool expands;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final double? textSize;
  final FontWeight? fontWeight;

  const CustomTextFormField({
    super.key,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.hintMaxLines = 1,
    this.expands = false,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.textSize = 15,
    this.fontWeight,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: textSize,
            fontWeight: fontWeight,
          ),
          cursorColor: Theme.of(context).colorScheme.onSurface,
          cursorWidth: 1.5,
          cursorHeight: 19,
          expands: expands,
          maxLines: maxLines,
          maxLength: maxLength,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            hintText: hintText,
            hintMaxLines: hintMaxLines,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: textSize,
              fontWeight: fontWeight,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Theme.of(context).colorScheme.secondary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        if (errorText != null)
          Row(
            spacing: 3,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                PhosphorIcons.info(PhosphorIconsStyle.fill),
                size: 18,
                color: Colors.red,
              ),
              Flexible(
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
