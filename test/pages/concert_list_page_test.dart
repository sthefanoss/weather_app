import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/concert_list_page.dart';

void main() {
  group('ConcertListPage', () {
    testWidgets('mount concert list with all data', (tester) async {
      await tester.pumpWidget(GetMaterialApp(
        initialBinding: ConcertListBindings(),
        home: const ConcertListPage(),
      ));

      final titleFinder = find.text('Concert List');
      final textFieldFinder = find.text('Search');

      final firstCityText = find.text('Silverstone, UK');
      final secondCityText = find.text('São Paulo, Brazil');
      final thirdCityText = find.text('Melbourne, Australia');
      final fourthCityText = find.text('Monte Carlo, Monaco');

      final cityNotFoundText = find.text('No concerts found at this location.');

      expect(titleFinder, findsOneWidget);
      expect(textFieldFinder, findsOneWidget);
      expect(firstCityText, findsOneWidget);
      expect(secondCityText, findsOneWidget);
      expect(thirdCityText, findsOneWidget);
      expect(fourthCityText, findsOneWidget);
      expect(cityNotFoundText, findsNothing);
    });

    testWidgets('search for a city within the list', (tester) async {
      final widget = GetMaterialApp(
        initialBinding: ConcertListBindings(),
        home: const ConcertListPage(),
      );
      await tester.pumpWidget(widget);

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'São Paulo');
      await tester.pumpWidget(widget);

      final firstCityText = find.text('Silverstone, UK');
      final secondCityText = find.text('São Paulo, Brazil');
      final thirdCityText = find.text('Melbourne, Australia');
      final fourthCityText = find.text('Monte Carlo, Monaco');

      final cityNotFoundText = find.text('No concerts found at this location.');

      expect(firstCityText, findsNothing);
      expect(secondCityText, findsOneWidget);
      expect(thirdCityText, findsNothing);
      expect(fourthCityText, findsNothing);
      expect(cityNotFoundText, findsNothing);
    });

    testWidgets('search for a city not listed', (tester) async {
      final widget = GetMaterialApp(
        initialBinding: ConcertListBindings(),
        home: const ConcertListPage(),
      );
      await tester.pumpWidget(widget);

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Pelotas, Brazil');
      await tester.pumpWidget(widget);

      final firstCityText = find.text('Silverstone, UK');
      final secondCityText = find.text('São Paulo, Brazil');
      final thirdCityText = find.text('Melbourne, Australia');
      final fourthCityText = find.text('Monte Carlo, Monaco');

      final cityNotFoundText = find.text('No concerts found at this location.');

      expect(firstCityText, findsNothing);
      expect(secondCityText, findsNothing);
      expect(thirdCityText, findsNothing);
      expect(fourthCityText, findsNothing);
      expect(cityNotFoundText, findsOneWidget);
    });
  });
}
