/// Liste durumları ve geçiş kuralları (spec §6.1).
///
/// Kanonik kodlar veritabanına bu adlarıyla saklanır (draft/planned/
/// shopping/completed/archived); görünen adlar l10n'dan gelir.
enum ListStatus {
  draft,
  planned,
  shopping,
  completed,
  archived;

  /// Veritabanı kodundan çözer; bilinmeyen kodda [ArgumentError].
  static ListStatus fromDb(String value) {
    final parsed = tryFromDb(value);
    if (parsed == null) {
      throw ArgumentError('bilinmeyen liste durumu: $value');
    }
    return parsed;
  }

  /// Veritabanı kodundan çözer; bilinmeyen kodda null.
  static ListStatus? tryFromDb(String value) {
    for (final s in ListStatus.values) {
      if (s.name == value) return s;
    }
    return null;
  }

  /// İzinli geçişler (spec §6.1 durum makinesi):
  /// taslak→planlandı; planlandı→alışverişte; alışverişte→tamamlandı;
  /// her aktif durumdan arşive; arşivden tekrar taslağa.
  static const Map<ListStatus, Set<ListStatus>> _transitions = {
    draft: {planned, archived},
    planned: {shopping, draft, archived},
    shopping: {completed, planned, archived},
    completed: {archived},
    archived: {draft},
  };

  bool canTransitionTo(ListStatus next) =>
      next == this || _transitions[this]!.contains(next);
}
