import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/utils/string_utils.dart';

void main() {
  group('StringUtils', () {
    test('withoutDiacriticalMarks', () {
      expect('áéíóú'.withoutDiacriticalMarks, 'aeiou');
      expect('ãõ'.withoutDiacriticalMarks, 'ao');
      expect('ç'.withoutDiacriticalMarks, 'c');
      expect('à'.withoutDiacriticalMarks, 'a');
      expect('ü'.withoutDiacriticalMarks, 'u');
    });
  });
}
