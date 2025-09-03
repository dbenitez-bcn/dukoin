class TimeInterval {
  final DateTime start;
  final DateTime end;

  TimeInterval(this.start, this.end);

  Duration get duration => end.difference(start);
  /*
  bool contains(DateTime dateTime) =>
      (dateTime.isAtSameMomentAs(start) || dateTime.isAfter(start)) &&
          (dateTime.isBefore(end) || dateTime.isAtSameMomentAs(end));

 */
}
