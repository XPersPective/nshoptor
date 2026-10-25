import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:napp_core/napp_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/l10n/generated/app_localizations.dart';

/// NAppKit core-v1.0.1 has no forced-refresh API. Expire only its freshness
/// marker for an explicit user reload; keep the payload for offline fallback.
Future<List<OtherApp>> loadDiscoveryApps(
  OtherAppsRepository repository, {
  required String ownPackage,
  bool forceRefresh = false,
}) {
  if (forceRefresh) repository.cacheStore?.remove('napp.other_apps_cache_at');
  return repository.load(ownPackage: ownPackage);
}

/// Keeps NAppKit's bounded remote/cache policy, with app-owned platform rules.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
    required this.identity,
    required this.repository,
    this.launcher,
  });
  final AppIdentity identity;
  final OtherAppsRepository repository;
  final Future<bool> Function(Uri)? launcher;

  static List<OtherApp> forPlatform(
    List<OtherApp> apps, {
    required bool isIos,
  }) => apps
      .where(
        (app) => isIos
            ? RegExp(r'^[1-9]\d*$').hasMatch(app.appStoreId ?? '')
            : RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z0-9_]+)+$')
                  .hasMatch(app.androidPackage ?? ''),
      )
      .toList();

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late Future<List<OtherApp>> _apps = _load();
  bool _opening = false;
  Future<List<OtherApp>> _load({bool forceRefresh = false}) =>
      loadDiscoveryApps(
        widget.repository,
        ownPackage: widget.identity.packageName,
        forceRefresh: forceRefresh,
      );

  Future<void> _open(OtherApp app) async {
    if (_opening) return;
    final url = app.storeUrl(
      isIos: defaultTargetPlatform == TargetPlatform.iOS,
    );
    if (url == null) return;
    setState(() => _opening = true);
    try {
      final opened =
          await (widget.launcher ??
              (uri) => launchUrl(uri, mode: LaunchMode.externalApplication))(
            Uri.parse(url),
          );
      if (!opened) throw StateError('store_unavailable');
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(NappLocalizations.of(context).commonErrorGeneric),
              showCloseIcon: true,
            ),
          );
      }
    } finally {
      if (mounted) setState(() => _opening = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navDiscover)),
      body: FutureBuilder<List<OtherApp>>(
        future: _apps,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final apps = DiscoverScreen.forPlatform(
            snapshot.data ?? [],
            isIos: defaultTargetPlatform == TargetPlatform.iOS,
          );
          if (apps.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.apps_outlined,
                      size: 40,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      NappLocalizations.of(context).otherAppsEmpty,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      key: const Key('discover_retry'),
                      onPressed: () => setState(() {
                        _apps = _load(forceRefresh: true);
                      }),
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.retryAction),
                    ),
                  ],
                ),
              ),
            );
          }
          final locale = Localizations.localeOf(context).toLanguageTag();
          return RefreshIndicator(
            onRefresh: () async {
              final next = _load(forceRefresh: true);
              setState(() {
                _apps = next;
              });
              await next;
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: apps.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final app = apps[index];
                return Card(
                  child: ListTile(
                    key: Key('discover_${app.id}'),
                    contentPadding: const EdgeInsets.all(16),
                    leading: SizedBox(
                      width: 48,
                      height: 48,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: app.iconUrl == null
                            ? const Icon(Icons.apps_outlined)
                            : Image.network(
                                app.iconUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) =>
                                    const Icon(Icons.apps_outlined),
                              ),
                      ),
                    ),
                    title: Text(app.nameIn(locale)),
                    subtitle: Text(app.descriptionIn(locale)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _opening ? null : () => _open(app),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
