# Nav Bar 🚀

[![pub package](https://img.shields.io/pub/v/nav_bar.svg)](https://pub.dev/packages/nav_bar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A highly customizable, futuristic bottom navigation bar for Flutter with particle effects, liquid animations, and physics-driven dynamics.

---

## 📱 Style Showcase

The `nav_bar` package packs **13 unique styles**, each powered by a high-performance Custom Painter.

### 🌊 Liquid
Organic, flowing metal fluid that follows your selection with gooey physics.

![Liquid Demo](https://raw.githubusercontent.com/biruk-77/package/main/Liquid.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.liquid,
  showLiquid: true,
  // ... other params
)
```

### 🎈 Floating
A gravity-defying elevated pill with magnetic attraction and soft glow.

![Floating Demo](https://raw.githubusercontent.com/biruk-77/package/main/Floating.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.floating,
  glowStrength: 1.5,
)
```

### 🌑 Obsidian
Ultra-premium matte design with real-time blur and micro-grid depth.

![Obsidian Demo](https://raw.githubusercontent.com/biruk-77/package/main/Obsidian.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.obsidian,
  blurSigma: 15.0,
)
```

### ⚛️ Quantum
Particle-based energy trails and state-shifting atomic dynamics.

![Quantum Demo](https://raw.githubusercontent.com/biruk-77/package/main/Quantum.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.quantum,
)
```

### 💎 Prism
Chromatic aberration and crystalline light refraction effects.

![Prism Demo](https://raw.githubusercontent.com/biruk-77/package/main/Prism.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.prism,
)
```

### 📟 Hologram
Digitized scanlines and flickering light projections from the future.

![Hologram Demo](https://raw.githubusercontent.com/biruk-77/package/main/Hologram.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.hologram,
)
```

### ⏱️ Chronos
Time-warping motion trails and temporal mechanical distortions.

![Chronos Demo](https://raw.githubusercontent.com/biruk-77/package/main/Chronos.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.chronos,
)
```

### 🧠 Synapse
Neural network connections that spark and bridge on interaction.

![Synapse Demo](https://raw.githubusercontent.com/biruk-77/package/main/Synapse.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.synapse,
)
```

### 🗿 Monolith
Brutalist geometric shifts with deep architectural light-slit shadows.

![Monolith Demo](https://raw.githubusercontent.com/biruk-77/package/main/Monolith.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.monolith,
)
```

### 🕳️ Singularity
A gravity-well effect that bends space and light around the active item.

![Singularity Demo](https://raw.githubusercontent.com/biruk-77/package/main/Singularity.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.singularity,
)
```

### 🖌️ Sumi
Japanese ink-wash aesthetics with organic bleed and fluid physics.

![Sumi Demo](https://raw.githubusercontent.com/biruk-77/package/main/Sumi.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.sumi,
)
```

### 🌌 Cosmos
Deep space parallax starfields and galactic nebular glows.

![Cosmos Demo](https://raw.githubusercontent.com/biruk-77/package/main/Cosmos.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.cosmos,
)
```

### ⚙️ Kinetic
Force-based physics where tiles react to speed, inertia, and wave propagation.

![Kinetic Demo](https://raw.githubusercontent.com/biruk-77/package/main/Kinetic.gif)

```dart
FuturisticNavBar(
  style: NavBarStyle.kinetic,
)
```

---

## 🛠️ Uber Customization

The engine is fully open for tuning. You can control the physics and visuals down to the pixel:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `iconLabelSpacing` | `double` | `4.0` | Vertical gap between icon and label. |
| `glowStrength` | `double` | `1.0` | Multiplier for the glow aura intensity. |
| `borderWidth` | `double` | `1.5` | Thickness of the outer bar frame. |
| `blurSigma` | `double` | `10.0` | Gaussian blur intensity (for Obsidian). |
| `iconSize` | `double` | `24.0` | Base size for navigation icons. |
| `showGlow` | `bool` | `true` | Toggle the background aura. |
| `showLiquid` | `bool` | `true` | Toggle the liquid path deformation. |

---

## 🎨 Design Systems (Themes)

Choose from curated high-end themes:

*   **Cyberpunk**: Neon cyan and purple grid vibes.
*   **Aurora**: Soft arctic pastel gradients.
*   **Molten**: Fierce volcanic red and gold.

```dart
FuturisticNavBar(
  theme: FuturisticTheme.aurora(),
  // ...
)
```

---

## 🚀 Quick Start

```dart
import 'package:nav_bar/nav_bar.dart';

FuturisticNavBar(
  selectedIndex: _index,
  onItemSelected: (i) => setState(() => _index = i),
  items: [
    NavBarItem(icon: Icons.home, label: 'HOME'),
    NavBarItem(icon: Icons.search, label: 'SEARCH'),
    NavBarItem(icon: Icons.person, label: 'PROFILE'),
  ],
)
```

## 📜 License

MIT License - feel free to build something world-class with this!