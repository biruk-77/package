import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';

import '../models/nav_bar_item.dart';
import '../theme/futuristic_theme.dart';
import '../painters/background_glow_painter.dart';
import '../painters/liquid_metal_painter.dart';
import '../painters/floating_painter.dart';
import '../painters/obsidian_painter.dart';
import '../painters/quantum_painter.dart';
import '../painters/prism_painter.dart';
import '../painters/hologram_painter.dart';
import '../painters/chronos_painter.dart';
import '../painters/synapse_painter.dart';
import '../painters/monolith_painter.dart';
import '../painters/singularity_painter.dart';
import '../painters/sumi_painter.dart';
import '../painters/cosmos_painter.dart';
import '../painters/kinetic_painter.dart';
import '../models/nav_bar_style.dart';
import '../models/icon_animation_type.dart';

class FuturisticNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<NavBarItem> items;
  final FuturisticTheme theme;
  final bool showGlow;
  final bool showLiquid;
  final NavBarStyle style;
  final Duration animationDuration;
  final TextStyle? textStyle;
  final double iconSize;
  final double barElevation;
  final IconAnimationType iconAnimationType;
  final Color? barBackgroundColor; // Override theme background

  // Uber Customization
  final double glowStrength;
  final double borderWidth;
  final double blurSigma;
  final bool enableMotionBlur;
  final double iconLabelSpacing;

  const FuturisticNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.theme = const FuturisticTheme.cyberpunk(),
    this.showGlow = true,
    this.showLiquid = true,
    this.style = NavBarStyle.liquid,
    this.animationDuration = const Duration(milliseconds: 600),
    this.textStyle,
    this.iconSize = 24.0,
    this.barElevation = 0.0,
    this.iconAnimationType = IconAnimationType.scale,
    this.barBackgroundColor,
    this.glowStrength = 1.0,
    this.borderWidth = 1.5,
    this.blurSigma = 10.0,
    this.enableMotionBlur = false,
    this.iconLabelSpacing = 4.0,
  });

  @override
  State<FuturisticNavBar> createState() => _FuturisticNavBarState();
}

class _FuturisticNavBarState extends State<FuturisticNavBar>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _pressController;
  late AnimationController _xController;
  late Animation<double> _xAnimation;
  late Animation<double> _pressAnimation;
  late Ticker _globalTicker;
  double _idleTime = 0.0;

  double _dragX = 0.0;
  bool _isDragging = false;
  int? _dragHoverIndex;

  late FuturisticTheme _theme;
  static const double barHeight = 80.0;
  late double barWidth;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme;

    _xController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _xAnimation =
        Tween<double>(
          begin: widget.selectedIndex.toDouble(),
          end: widget.selectedIndex.toDouble(),
        ).animate(
          CurvedAnimation(parent: _xController, curve: Curves.easeInOutCubic),
        );

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 800),
    );
    _pressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.elasticOut,
      ),
    );

    _globalTicker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          _idleTime = elapsed.inMicroseconds / 1000000.0;
        });
      }
    });
    _globalTicker.start();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void didUpdateWidget(FuturisticNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _xAnimation =
          Tween<double>(
            begin: _xAnimation.value,
            end: widget.selectedIndex.toDouble(),
          ).animate(
            CurvedAnimation(parent: _xController, curve: Curves.easeInOutCubic),
          );
      _xController.forward(from: 0.0);
    }
    if (oldWidget.theme != widget.theme) {
      setState(() => _theme = widget.theme);
    }
  }

  @override
  void dispose() {
    _xController.dispose();
    _pressController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    _globalTicker.dispose();
    super.dispose();
  }

  void _handleTap(int index) {
    if (index == widget.selectedIndex) return;
    HapticFeedback.mediumImpact();
    _pressController.forward().then((_) => _pressController.reverse());
    widget.onItemSelected(index);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) {
      _isDragging = true;
      HapticFeedback.mediumImpact();
    }
    setState(() {
      _dragX += details.delta.dx;
      _dragX = _dragX.clamp(0.0, barWidth);
      int hoverIndex = (_dragX / (barWidth / widget.items.length)).floor();
      hoverIndex = hoverIndex.clamp(0, widget.items.length - 1);
      if (_dragHoverIndex != hoverIndex) {
        _dragHoverIndex = hoverIndex;
        HapticFeedback.selectionClick();
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragHoverIndex != null && _dragHoverIndex != widget.selectedIndex) {
      widget.onItemSelected(_dragHoverIndex!);
    }
    setState(() {
      _isDragging = false;
      _dragHoverIndex = null;
    });
  }

  /// Builds the icon widget for a navigation item
  /// Supports both traditional IconData and custom widgets
  Widget _buildIconWidget(NavBarItem item) {
    if (item.hasCustomIcon) {
      // Use custom icon widget directly
      return SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: FittedBox(fit: BoxFit.contain, child: item.customIcon!),
      );
    } else {
      // Use traditional Icon with IconData
      return Icon(item.icon!, size: widget.iconSize, color: Colors.white);
    }
  }

  /// Builds the label widget for a navigation item
  /// Supports both traditional String and custom widgets
  Widget? _buildLabelWidget(NavBarItem item) {
    if (item.hasCustomLabel) {
      // Use custom label widget directly
      return item.customLabel!;
    } else if (item.label != null) {
      // Use traditional Text widget
      return Text(
        item.label!,
        style:
            widget.textStyle ??
            TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              shadows: [
                Shadow(color: Colors.black.withOpacity(0.8), blurRadius: 4),
              ],
            ),
      );
    }
    return null; // No label
  }

  @override
  Widget build(BuildContext context) {
    barWidth = MediaQuery.of(context).size.width - 40;
    final double itemWidth = barWidth / widget.items.length;
    final double activeX = _xAnimation.value * itemWidth + itemWidth / 2;

    return Container(
      height: barHeight,
      width: barWidth,
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.showGlow)
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: BackgroundGlowPainter(
                activeX: activeX,
                totalItems: widget.items.length,
                theme: _theme,
                pulse: _pulseController.value,
                rotation: _rotationController.value * 2 * math.pi,
              ),
            ),

          if (widget.style == NavBarStyle.liquid) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: LiquidMetalPainter(
                progress: _xAnimation.value,
                totalItems: widget.items.length,
                squash: widget.showLiquid ? _pressAnimation.value : 0.0,
                theme: _theme,
                dragOffset: _isDragging ? _dragX : null,
                hoverIndex: _dragHoverIndex,
                useLiquidPath: widget.showLiquid,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.floating) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: FloatingPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.obsidian) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: widget.blurSigma,
                  sigmaY: widget.blurSigma,
                ),
                child: CustomPaint(
                  size: Size(barWidth, barHeight),
                  painter: ObsidianPainter(
                    animationValue: _xAnimation.value,
                    count: widget.items.length,
                    theme: _theme,
                    glowStrength: widget.glowStrength,
                    pressValue: _pressAnimation.value,
                    customColors: _theme.customColors,
                    effectToggles: _theme.effectToggles,
                  ),
                ),
              ),
            ),
          ] else if (widget.style == NavBarStyle.quantum) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: QuantumPainter(
                progress: _xAnimation.value,
                totalItems: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.prism) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: PrismPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.hologram) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: HologramPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.chronos) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: ChronosPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.synapse) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: SynapsePainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.monolith) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: MonolithPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.singularity) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: SingularityPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.sumi) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: SumiPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.cosmos) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: CosmosPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ] else if (widget.style == NavBarStyle.kinetic) ...[
            CustomPaint(
              size: Size(barWidth, barHeight),
              painter: KineticPainter(
                animationValue: _xAnimation.value,
                count: widget.items.length,
                idleTime: _idleTime,
                theme: _theme,
                pressValue: _pressAnimation.value,
                customColors: _theme.customColors,
                effectToggles: _theme.effectToggles,
              ),
            ),
          ],

          Positioned.fill(
            child: Row(
              children: widget.items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                final bool isActive = i == widget.selectedIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _handleTap(i),
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TweenAnimationBuilder<double>(
                          duration: Duration(
                            milliseconds:
                                (widget.animationDuration.inMilliseconds / 1.5)
                                    .toInt(),
                          ),
                          tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
                          curve: Curves.elasticOut,
                          builder: (context, activeVal, child) {
                            Matrix4 transform = Matrix4.identity();
                            switch (widget.iconAnimationType) {
                              case IconAnimationType.scale:
                                transform.scale(1.0 + 0.2 * activeVal);
                                transform.translate(0.0, -14.0 * activeVal);
                                break;
                              case IconAnimationType.rotate:
                                transform.rotateZ(activeVal * math.pi * 2);
                                transform.translate(0.0, -10.0 * activeVal);
                                break;
                              case IconAnimationType.slide:
                                transform.translate(0.0, -20.0 * activeVal);
                                break;
                              case IconAnimationType.fade:
                                transform.translate(0.0, -10.0 * activeVal);
                                break;
                              case IconAnimationType.flip:
                                transform.rotateY(activeVal * math.pi);
                                transform.translate(0.0, -14.0 * activeVal);
                                break;
                              case IconAnimationType.bounce:
                                final bounceY =
                                    math.sin(activeVal * math.pi) * -30.0;
                                transform.translate(0.0, bounceY);
                                break;
                              case IconAnimationType.magnetic:
                                transform.scale(1.0 + 0.3 * activeVal);
                                transform.translate(0.0, -18.0 * activeVal);
                                break;
                            }
                            final bool isPrism =
                                widget.style == NavBarStyle.prism;

                            // Build base icon (supports both traditional and custom)
                            final baseIcon = _buildIconWidget(item);

                            Widget iconWidget = Material(
                              type: MaterialType.transparency,
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: baseIcon,
                              ),
                            );

                            if (isPrism &&
                                activeVal > 0.1 &&
                                !item.hasCustomIcon) {
                              iconWidget = Stack(
                                children: [
                                  // Cyan Ghost
                                  Transform.translate(
                                    offset: Offset(-2 * activeVal, 0),
                                    child: Icon(
                                      item.icon,
                                      color: Colors.cyan.withOpacity(
                                        0.3 * activeVal,
                                      ),
                                      size: widget.iconSize + (6 * activeVal),
                                    ),
                                  ),
                                  // Magenta Ghost
                                  Transform.translate(
                                    offset: Offset(2 * activeVal, 0),
                                    child: Icon(
                                      item.icon,
                                      color: Colors.purpleAccent.withOpacity(
                                        0.3 * activeVal,
                                      ),
                                      size: widget.iconSize + (6 * activeVal),
                                    ),
                                  ),
                                  iconWidget,
                                ],
                              );
                            }

                            return Transform(
                              transform: transform,
                              alignment: Alignment.center,
                              child: iconWidget,
                            );
                          },
                        ),
                        if (isActive) ...[
                          SizedBox(height: widget.iconLabelSpacing),
                          Material(
                            type: MaterialType.transparency,
                            child: _buildLabelWidget(item) ?? const SizedBox(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
