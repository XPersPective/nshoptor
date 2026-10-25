enum ReportSpan { day, week, month, year, custom }

/// A half-open range of local calendar dates: [from, to).
final class ReportPeriod {
  ReportPeriod({required this.span, required this.from, required this.to}) {
    if (from.isUtc || to.isUtc) {
      throw ArgumentError('Report period bounds must use local time');
    }
    if (!from.isBefore(to)) {
      throw ArgumentError('Report period must have a positive range');
    }
    if (!_isDateBoundary(from) || !_isDateBoundary(to)) {
      throw ArgumentError('Report period bounds must be local date boundaries');
    }
  }

  final ReportSpan span;
  final DateTime from;
  final DateTime to;

  factory ReportPeriod.forSpan(ReportSpan span, DateTime anchor) {
    if (span == ReportSpan.custom) {
      throw ArgumentError.value(
        span,
        'span',
        'Custom periods need explicit bounds',
      );
    }
    if (anchor.isUtc) {
      throw ArgumentError.value(anchor, 'anchor', 'Expected local time');
    }

    final date = DateTime(anchor.year, anchor.month, anchor.day);
    final from = switch (span) {
      ReportSpan.day => date,
      ReportSpan.week => DateTime(
        date.year,
        date.month,
        date.day - (date.weekday - 1),
      ),
      ReportSpan.month => DateTime(date.year, date.month, 1),
      ReportSpan.year => DateTime(date.year, 1, 1),
      ReportSpan.custom => throw StateError('Handled above'),
    };
    final to = switch (span) {
      ReportSpan.day => DateTime(from.year, from.month, from.day + 1),
      ReportSpan.week => DateTime(from.year, from.month, from.day + 7),
      ReportSpan.month => DateTime(from.year, from.month + 1, 1),
      ReportSpan.year => DateTime(from.year + 1, 1, 1),
      ReportSpan.custom => throw StateError('Handled above'),
    };
    return ReportPeriod(span: span, from: from, to: to);
  }

  bool contains(DateTime instant) =>
      !instant.isBefore(from) && instant.isBefore(to);

  ReportPeriod shift(int steps) {
    if (span == ReportSpan.custom) {
      final days = DateTime.utc(
        to.year,
        to.month,
        to.day,
      ).difference(DateTime.utc(from.year, from.month, from.day)).inDays;
      final shiftedFrom = DateTime(
        from.year,
        from.month,
        from.day + days * steps,
      );
      final shiftedTo = DateTime(
        shiftedFrom.year,
        shiftedFrom.month,
        shiftedFrom.day + days,
      );
      return ReportPeriod(span: span, from: shiftedFrom, to: shiftedTo);
    }

    final anchor = switch (span) {
      ReportSpan.day => DateTime(from.year, from.month, from.day + steps),
      ReportSpan.week => DateTime(from.year, from.month, from.day + 7 * steps),
      ReportSpan.month => DateTime(from.year, from.month + steps, 1),
      ReportSpan.year => DateTime(from.year + steps, 1, 1),
      ReportSpan.custom => throw StateError('Handled above'),
    };
    return ReportPeriod.forSpan(span, anchor);
  }

  // Some timezone transitions skip midnight; DateTime normalizes the first
  // representable instant of that date rather than assuming every day has24h.
  static bool _isDateBoundary(DateTime date) =>
      date == DateTime(date.year, date.month, date.day);
}
