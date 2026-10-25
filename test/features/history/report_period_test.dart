import 'package:flutter_test/flutter_test.dart';
import 'package:nshoptor/features/history/reports/report_period.dart';

void main() {
  test('day and ISO week spans normalize anchors to local calendar bounds', () {
    final day = ReportPeriod.forSpan(
      ReportSpan.day,
      DateTime(2026, 10, 25, 18, 41),
    );
    expect(day.from, DateTime(2026, 10, 25));
    expect(day.to, DateTime(2026, 10, 26));

    // 2021-01-01 was Friday; ISO weeks begin on Monday.
    final week = ReportPeriod.forSpan(ReportSpan.week, DateTime(2021, 1, 1));
    expect(week.from, DateTime(2020, 12, 28));
    expect(week.to, DateTime(2021, 1, 4));
  });

  test('month and year spans handle rollover and leap years', () {
    final december = ReportPeriod.forSpan(
      ReportSpan.month,
      DateTime(2024, 12, 31, 23, 59),
    );
    expect(december.from, DateTime(2024, 12, 1));
    expect(december.to, DateTime(2025, 1, 1));

    final leapMonth = ReportPeriod.forSpan(
      ReportSpan.month,
      DateTime(2024, 2, 29),
    );
    expect(leapMonth.from, DateTime(2024, 2, 1));
    expect(leapMonth.to, DateTime(2024, 3, 1));

    final leapYear = ReportPeriod.forSpan(
      ReportSpan.year,
      DateTime(2024, 2, 29),
    );
    expect(leapYear.from, DateTime(2024, 1, 1));
    expect(leapYear.to, DateTime(2025, 1, 1));
  });

  test('period end is exclusive and contains compares instants', () {
    final period = ReportPeriod.forSpan(ReportSpan.day, DateTime(2026, 5, 4));
    expect(period.contains(DateTime(2026, 5, 4)), isTrue);
    expect(period.contains(DateTime(2026, 5, 4, 23, 59, 59)), isTrue);
    expect(period.contains(DateTime(2026, 5, 5)), isFalse);
    expect(period.contains(DateTime(2026, 5, 4, 12).toUtc()), isTrue);
  });

  test('standard span shifts are reversible across calendar rollovers', () {
    final month = ReportPeriod.forSpan(ReportSpan.month, DateTime(2024, 1, 31));
    final february = month.shift(1);
    expect(february.from, DateTime(2024, 2, 1));
    expect(february.to, DateTime(2024, 3, 1));
    expect(february.shift(-1).from, month.from);
    expect(february.shift(-1).to, month.to);

    final week = ReportPeriod.forSpan(ReportSpan.week, DateTime(2021, 1, 1));
    final next = week.shift(1);
    expect(next.from, DateTime(2021, 1, 4));
    expect(next.to, DateTime(2021, 1, 11));
    expect(next.shift(-1).from, week.from);
    expect(next.shift(-1).to, week.to);
  });

  test('custom spans shift by their exclusive calendar-day length', () {
    final custom = ReportPeriod(
      span: ReportSpan.custom,
      from: DateTime(2024, 3, 8),
      to: DateTime(2024, 3, 11),
    );
    final next = custom.shift(1);
    expect(next.from, DateTime(2024, 3, 11));
    expect(next.to, DateTime(2024, 3, 14));
    expect(next.shift(-1).from, custom.from);
    expect(next.shift(-1).to, custom.to);
    expect(custom.shift(0).from, custom.from);
    expect(custom.shift(0).to, custom.to);
  });

  test(
    'custom span needs explicit bounds and bounds must be local midnights',
    () {
      expect(
        () => ReportPeriod.forSpan(ReportSpan.custom, DateTime(2026, 10, 25)),
        throwsArgumentError,
      );
      expect(
        () => ReportPeriod(
          span: ReportSpan.custom,
          from: DateTime(2026, 10, 26),
          to: DateTime(2026, 10, 25),
        ),
        throwsArgumentError,
      );
      expect(
        () => ReportPeriod(
          span: ReportSpan.custom,
          from: DateTime(2026, 10, 25, 1),
          to: DateTime(2026, 10, 26),
        ),
        throwsArgumentError,
      );
      expect(
        () => ReportPeriod(
          span: ReportSpan.custom,
          from: DateTime.utc(2026, 10, 25),
          to: DateTime.utc(2026, 10, 26),
        ),
        throwsArgumentError,
      );
    },
  );
}
