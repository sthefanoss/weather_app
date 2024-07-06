import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/controllers/concert_list_controller.dart';

void main() {
  group('ConcertListController', () {
    test('initial locations contains all cities,', () {
      final controller = ConcertListController();

      final locations = controller.concertPlaces;

      expect(locations, [
        'Silverstone, UK',
        'São Paulo, Brazil',
        'Melbourne, Australia',
        'Monte Carlo, Monaco',
      ]);
    });

    test(r'''search for 'foo' finds nothing ''', () {
      final controller = ConcertListController();

      controller.setFilter('foo');

      final locations = controller.concertPlaces;

      expect(locations, []);
    });

    test(r'''search is reset after clearing the filter''', () {
      final controller = ConcertListController();

      controller.setFilter('foo');
      controller.setFilter('');

      final locations = controller.concertPlaces;

      expect(locations, [
        'Silverstone, UK',
        'São Paulo, Brazil',
        'Melbourne, Australia',
        'Monte Carlo, Monaco',
      ]);
    });

    test(r'''filter is normalized''', () {
      final controller = ConcertListController();

      controller.setFilter('SÃO PAULO, BRAZIL');

      final locations = controller.concertPlaces;

      expect(locations, ['São Paulo, Brazil']);
    });

    test(r'''filter ignores diacritical marks''', () {
      final controller = ConcertListController();

      controller.setFilter('sao');

      final locations = controller.concertPlaces;

      expect(locations, ['São Paulo, Brazil']);
    });
  });
}
