import 'package:mocktail/mocktail.dart';

String get locationMatcher => any<String>(named: 'location');

String get keyMatcher => any<String>(named: 'key');

String get valueMatcher => any<String>(named: 'value');
