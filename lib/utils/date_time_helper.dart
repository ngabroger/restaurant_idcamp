class DateTimeHelper {
  static DateTime format() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 11, 00);

    final initialDelay = targetTime.isBefore(now)
        ? targetTime.add(const Duration(days: 1)).difference(now)
        : targetTime.difference(now);

    return now.add(initialDelay);
  }
}
