import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upskill_consultancy/src/shared/widgets/app_bottom_nav_bar.dart';

void main() {
  testWidgets('AppBottomNavBar renders 5 items and triggers taps',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();

    int selectedIndex = 0;

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('bn'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: Scaffold(
                bottomNavigationBar: StatefulBuilder(
                  builder: (context, setState) {
                    return AppBottomNavBar(
                      currentIndex: selectedIndex,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify nav bar is present
    expect(find.byType(AppBottomNavBar), findsOneWidget);

    // Verify side tab texts exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Courses'), findsOneWidget);
    expect(find.text('Services'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);

    // Verify center button exists via tooltip
    expect(find.byTooltip('My Learning'), findsOneWidget);

    // Tap on Courses
    await tester.tap(find.text('Courses'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 1);

    // Tap on My Learning (center floating button)
    await tester.tap(find.byTooltip('My Learning'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 2);

    // Tap on Services
    await tester.tap(find.text('Services'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 3);

    // Tap on Dashboard
    await tester.tap(find.text('Dashboard'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 4);

    // Tap back on Home
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(selectedIndex, 0);
  });
}
