import 'package:flutter/material.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/money/decimal_fixed.dart';
import '../../../core/money/currency.dart';
import '../../../core/money/money_format.dart';
import '../../../core/money/money.dart';

import 'package:drift/drift.dart' show OrderingTerm;

import '../../../data/db/app_database.dart';

/// Fiyat geçmişi ekranı (spec §6.10): son gözlemlerin listesi ve özet.
/// Parasal değerler birim fiyatın minor unit'idir; hiçbir yerde `double` yok.
class PriceHistoryScreen extends StatelessWidget {
  const PriceHistoryScreen({
    super.key,
    required this.db,
    required this.productId,
    this.productName,
  });

  final AppDatabase db;
  final int productId;
  final String? productName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(productName ?? l10n.priceHistoryTitle)),
      body: FutureBuilder<List<PriceObservation>>(
        future: _load(),
        builder: (context, snapshot) {
          final rows = snapshot.data;
          if (rows == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (rows.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.noObservations),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: rows.length,
            itemBuilder: (context, i) {
              final r = rows[i];
              final minor = DecimalFixed.parse(
                r.unitPrice,
              ).toMinorUnits(Currency.fromCode(r.currencyCode).minorUnitDigits);
              final money = formatMoney(
                Money.fromMinorUnits(minor, Currency.fromCode(r.currencyCode)),
                locale: Localizations.localeOf(context).languageCode,
              );
              final date = MaterialLocalizations.of(context)
                  .formatMediumDate(r.observedAt);
              return Card(
                child: ListTile(
                  key: Key('price_obs_${r.id}'),
                  title: Text(money),
                  subtitle: Text(r.unitCode),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_storeName(r)),
                      Text(date, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<PriceObservation>> _load() =>
      (db.select(db.priceObservations)
            ..where((t) => t.productId.equals(productId))
            ..orderBy([(t) => OrderingTerm.desc(t.observedAt)]))
          .get();

  String _storeName(PriceObservation r) => '';
}
