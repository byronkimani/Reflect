import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/utils/day_greeting.dart';

void main() {
  test('dayGreetingForHour returns morning before noon', () {
    expect(dayGreetingForHour(8), 'Good morning');
    expect(dayGreetingForHour(11), 'Good morning');
  });

  test('dayGreetingForHour returns afternoon between noon and 5pm', () {
    expect(dayGreetingForHour(12), 'Good afternoon');
    expect(dayGreetingForHour(16), 'Good afternoon');
  });

  test('dayGreetingForHour returns evening from 5pm onward', () {
    expect(dayGreetingForHour(17), 'Good evening');
    expect(dayGreetingForHour(22), 'Good evening');
  });
}
