import 'dart:ui';
import 'package:flutter/material.dart';

class NeumorphicGlassNavbar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final NeumorphicGlassNavbarSettings settings;
  final double height;

  const NeumorphicGlassNavbar({
    super.key,
    required this.items,
    this.height = 61,
    this.currentIndex = 0,
    this.onTap,
    this.settings = const NeumorphicGlassNavbarSettings(),
  });

@override
Widget build(BuildContext context) {
  final isDark = settings.adaptToTheme && Theme.of(context).brightness == Brightness.dark;
  final tintColor = settings.tintColor.withOpacity(settings.opacity);
  final isReducedTransparency = MediaQuery.of(context).accessibleNavigation;
  final blur = settings.maxBlurIntensity.clamp(0.0, 5.0);
  final borderRadius = BorderRadius.vertical(top: Radius.circular(settings.borderRadius));

  return ClipRRect(
    borderRadius: borderRadius,
    child: SizedBox(
      height: height + MediaQuery.of(context).padding.bottom,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withOpacity(settings.opacity.clamp(0.0, 0.5))
                  : tintColor,
              borderRadius: borderRadius,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                  width: 0.3,
                ),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: isReducedTransparency ? 0.0 : blur,
                sigmaY: isReducedTransparency ? 0.0 : blur,
              ),
              child: Container(),
            ),
          ),
          if (settings.enableSpecularHighlights && !isReducedTransparency)
            CustomPaint(
              painter: SpecularHighlightPainter(
                scrollOffset: 0.0,
                vibrancyIntensity: settings.vibrancyIntensity.clamp(0.0, 0.5),
              ),
              child: Container(),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final isSelected = index == currentIndex;
                  return Flexible(
                    child: GestureDetector(
                      onTap: () => onTap?.call(index),
                      child: AnimatedScale(
                        scale: isSelected ? 0.92 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                        child: _buildItem(
                          context,
                          index: index,
                          isSelected: isSelected,
                          isDark: isDark,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
   ),
  );
}
  Widget _buildItem(
  BuildContext context, {
  required int index,
  required bool isSelected,
  required bool isDark,
}) {
  final icon = items[index].icon;
  final label = items[index].label ?? '';

  final Color baseIconColor = isDark ? Colors.white : Colors.black;
  final Color baseTextColor = isDark ? Colors.white : Colors.black;

  final Color iconColor = baseIconColor.withOpacity(isSelected ? settings.selectedOpacity : 0.5);
  final Color textColor = baseTextColor.withOpacity(isSelected ? 0.9 : 0.6);

  final Color selectedBgColor = isDark
      ? Colors.black.withOpacity(0.2)
      : Colors.white.withOpacity(0.4);

  final boxDecoration = isSelected
      ? BoxDecoration(
          color: selectedBgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.4)
                  : Colors.grey.withOpacity(0.25),
              offset: const Offset(3, 3),
              blurRadius: 5,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.6),
              offset: const Offset(-2, -2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
        )
      : const BoxDecoration();

  return Container(
    width: isSelected ? 75 : null,
    height: isSelected ? 75 : null,
    margin: EdgeInsets.symmetric(
      vertical: isSelected ? 4 : 8,
      horizontal: 4,
    ),
    decoration: isSelected ? boxDecoration : null,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
              size: settings.iconSize.clamp(20.0, 32.0),
              color: iconColor,
            ),
            child: icon,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isSelected ? 9 : 8,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
}

class SpecularHighlightPainter extends CustomPainter {
  final double scrollOffset;
  final double vibrancyIntensity;

  SpecularHighlightPainter({
    required this.scrollOffset,
    required this.vibrancyIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(vibrancyIntensity * 0.25),
          Colors.white.withOpacity(vibrancyIntensity * 0.7),
          Colors.white.withOpacity(vibrancyIntensity * 0.25),
        ],
        stops: const [0.0, 0.45, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: GradientRotation(scrollOffset * 0.003),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(50),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant SpecularHighlightPainter oldDelegate) {
    return scrollOffset != oldDelegate.scrollOffset ||
        vibrancyIntensity != oldDelegate.vibrancyIntensity;
  }
}

class NeumorphicGlassNavbarSettings {
  final double maxBlurIntensity;
  final double minBlurIntensity;
  final Color tintColor;
  final double borderRadius;
  final double opacity;
  final bool adaptToTheme;
  final double maxHeight;
  final double minHeight;
  final double vibrancyIntensity;
  final bool enableSpecularHighlights;
  final double iconSize;
  final double selectedOpacity;

  const NeumorphicGlassNavbarSettings({
    this.maxBlurIntensity = 12.0,
    this.minBlurIntensity = 6.0,
    this.tintColor = const Color(0xFFF4F4F4),
    this.borderRadius = 16.0,
    this.opacity = 0.25,
    this.adaptToTheme = true,
    this.maxHeight = kToolbarHeight + 20,
    this.minHeight = kToolbarHeight,
    this.vibrancyIntensity = 0.25,
    this.enableSpecularHighlights = true,
    this.iconSize = 20.0,
    this.selectedOpacity = 0.9,
  });
}
