import 'package:dukoin/presentation/state/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group("Theme notifier", () {
    group("toggleTheme()", () {
      test(
        "it should not update the theme mode when no value is given",
        () async {
          SharedPreferences.setMockInitialValues({});
          SharedPreferences mockPrefs = await SharedPreferences.getInstance();
          ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

          sut.toggleTheme(null);

          expect(sut.themeMode, ThemeMode.system);
          expect(mockPrefs.getInt('themeMode'), null);
        },
      );

      test("It should update to Dark when true value is given", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences mockPrefs = await SharedPreferences.getInstance();
        ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

        sut.toggleTheme(true);

        expect(sut.themeMode, ThemeMode.dark);
        expect(mockPrefs.getInt('themeMode'), 2);
      });

      test("It should update to Light when false value is given", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences mockPrefs = await SharedPreferences.getInstance();
        ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

        sut.toggleTheme(false);

        expect(sut.themeMode, ThemeMode.light);
        expect(mockPrefs.getInt('themeMode'), 1);
      });
    });
    group("load theme", () {
      test(
        "It should load Theme.system as default when no value is found",
        () async {
          SharedPreferences.setMockInitialValues({});
          SharedPreferences mockPrefs = await SharedPreferences.getInstance();
          ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

          expect(sut.themeMode, ThemeMode.system);
        },
      );
      test("It should load Theme.dark when Dark value is found", () async {
        SharedPreferences.setMockInitialValues({'themeMode': ThemeMode.dark.index});
        SharedPreferences mockPrefs = await SharedPreferences.getInstance();
        ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

        expect(sut.themeMode, ThemeMode.dark);
      });
      test("It should load Theme.light when Light value is found", () async {
        SharedPreferences.setMockInitialValues({'themeMode': ThemeMode.light.index});
        SharedPreferences mockPrefs = await SharedPreferences.getInstance();
        ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

        expect(sut.themeMode, ThemeMode.light);
      });
      test("It should ignore invalid stored value and keep default", () async {
        SharedPreferences.setMockInitialValues({'themeMode': 999});
        SharedPreferences mockPrefs = await SharedPreferences.getInstance();
        ThemeNotifier sut = ThemeNotifier(prefs: mockPrefs);

        expect(sut.themeMode, ThemeMode.system);
      });
    });
  });
}
