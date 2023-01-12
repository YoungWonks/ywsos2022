import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/core/settings/themes/theme_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ThemeService])
import 'unit_test.mocks.dart';

void main() {
  group('Theming', () {
    test('Initialize themes', () async {
      final themeService = MockThemeService();

      when(themeService.isSavedDarkMode()).thenReturn(false);
    });

    test('Theme changes when changeThemeMode is called', () {
      final themeService = MockThemeService();
      themeService.changeThemeMode();
      when(themeService.isSavedDarkMode()).thenReturn(true);
    });
  });
}
