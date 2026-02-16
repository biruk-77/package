import 'package:flutter_test/flutter_test.dart';
import 'package:nav_bar/nav_bar.dart';

void main() {
  test('NavBarItem can be created with icon and label', () {
    final item = NavBarItem(icon: const IconData(0xe318), label: 'Home');
    expect(item.label, 'Home');
    expect(item.hasCustomIcon, false);
  });

  test('NavBarItem can be created with custom icon', () {
    final item = NavBarItem(customIcon: const SizedBox(), label: 'Custom');
    expect(item.hasCustomIcon, true);
  });
}
