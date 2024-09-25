import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_app/components/custom_icon_button.dart';
import 'package:sabzi_app/providers/theme_provider.dart';
import 'package:sabzi_app/theme.dart';

class ThemeToggleButton extends StatelessWidget {
  final Color? iconColor;
  final double? iconSize;
  const ThemeToggleButton({super.key, this.iconColor, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorPalette.of(context);

    return CustomIconButton(
      onTap: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
      icon: Theme.of(context).brightness == Brightness.light ? PhosphorIcons.moon(PhosphorIconsStyle.regular) : PhosphorIcons.sun(PhosphorIconsStyle.regular),
      color: iconColor ?? colors.secondary,
    );
  }
}
