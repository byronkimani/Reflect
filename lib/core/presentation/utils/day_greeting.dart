/// Time-of-day greeting for the Today screen header.
String dayGreetingForHour(int hour) {
  if (hour >= 12 && hour < 17) return 'Good afternoon';
  if (hour >= 17) return 'Good evening';
  return 'Good morning';
}
