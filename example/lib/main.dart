import 'package:flutter/material.dart';
import 'package:nav_bar/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futuristic Nav Bar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  FuturisticTheme _currentTheme = const FuturisticTheme.cyberpunk();

  // Customization options
  bool _showGlow = true;
  bool _showLiquid = true;
  NavBarStyle _currentStyle = NavBarStyle.liquid;
  IconAnimationType _iconAnimType = IconAnimationType.scale;

  double _glowStrength = 1.0;
  double _borderWidth = 1.5;
  double _blurSigma = 10.0;
  double _iconLabelSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Base
      body: Stack(
        children: [
          // PREMIUM ANIMATED BACKGROUND
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    _currentTheme.accentColor.withValues(alpha: 0.15),
                    _currentTheme.backgroundColor,
                  ],
                ),
              ),
            ),
          ),

          // SCIMMER/GRID OVERLAY for depth
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: _BackgroundPatternPainter()),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ULTIMATE NAV BAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                  Text(
                    'Precision Customization Engine',
                    style: TextStyle(
                      color: _currentTheme.accentColor,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // THEMES
                  _buildSectionTitle('DESIGN SYSTEM'),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildThemeButton(
                        'CYBERPUNK',
                        const FuturisticTheme.cyberpunk(),
                      ),
                      _buildThemeButton(
                        'AURORA',
                        const FuturisticTheme.aurora(),
                      ),
                      _buildThemeButton(
                        'MOLTEN',
                        const FuturisticTheme.molten(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // VISUAL STYLES
                  _buildSectionTitle('CORE ARCHITECTURE'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<NavBarStyle>(
                      value: _currentStyle,
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: const Color(0xFF1A1A2E),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      items: NavBarStyle.values.map((style) {
                        return DropdownMenuItem(
                          value: style,
                          child: Text(style.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _currentStyle = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // UBER CUSTOMIZATION SLIDERS
                  _buildSectionTitle('PRECISION PARAMETERS'),
                  _buildSlider(
                    'Glow Strength',
                    _glowStrength,
                    (v) => setState(() => _glowStrength = v),
                  ),
                  _buildSlider(
                    'Border Width',
                    _borderWidth,
                    (v) => setState(() => _borderWidth = v),
                    max: 5,
                  ),
                  _buildSlider(
                    'Blur Intensity',
                    _blurSigma,
                    (v) => setState(() => _blurSigma = v),
                    max: 30,
                  ),
                  _buildSlider(
                    'Item Spacing',
                    _iconLabelSpacing,
                    (v) => setState(() => _iconLabelSpacing = v),
                    max: 20,
                  ),

                  const SizedBox(height: 20),
                  _buildSectionTitle('INTERACTION ENGINE'),
                  SwitchListTile(
                    title: const Text(
                      'Glow Aura',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _showGlow,
                    activeThumbColor: _currentTheme.accentColor,
                    onChanged: (val) => setState(() => _showGlow = val),
                  ),
                  SwitchListTile(
                    title: const Text(
                      'Surface Deformation',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _showLiquid,
                    activeThumbColor: _currentTheme.accentColor,
                    onChanged: (val) => setState(() => _showLiquid = val),
                  ),

                  _buildSectionTitle('ANIMATION ENGINE'),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<IconAnimationType>(
                      value: _iconAnimType,
                      isExpanded: true,
                      underline: const SizedBox(),
                      dropdownColor: const Color(0xFF1A1A2E),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      items: IconAnimationType.values.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _iconAnimType = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 120), // Spacing for navbar
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: FuturisticNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) =>
                    setState(() => _selectedIndex = index),
                theme: _currentTheme,
                showGlow: _showGlow,
                showLiquid: _showLiquid,
                style: _currentStyle,
                iconAnimationType: _iconAnimType,
                glowStrength: _glowStrength,
                borderWidth: _borderWidth,
                blurSigma: _blurSigma,
                iconLabelSpacing: _iconLabelSpacing,
                items: [
                  NavBarItem(icon: Icons.grid_view_rounded, label: 'HUB'),
                  NavBarItem(icon: Icons.bolt, label: 'CORE'),
                  NavBarItem(
                    icon: Icons.layers_rounded,
                    label: 'DATA',
                    hasNotification: true,
                    notificationCount: 5,
                  ),
                  // DEMO: Custom icon widget!
                  NavBarItem(
                    customIcon: const Text(
                      '🎨',
                      style: TextStyle(fontSize: 28),
                    ),
                    label: 'ART',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton(String label, FuturisticTheme theme) {
    final bool isSelected = _currentTheme.name == theme.name;
    return InkWell(
      onTap: () => setState(() => _currentTheme = theme),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? _currentTheme.accentColor
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    Function(double) onChanged, {
    double max = 2.0,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(color: _currentTheme.accentColor, fontSize: 12),
            ),
          ],
        ),
        Slider(
          value: value,
          max: max,
          activeColor: _currentTheme.accentColor,
          inactiveColor: Colors.white10,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5;

    const double step = 30.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
