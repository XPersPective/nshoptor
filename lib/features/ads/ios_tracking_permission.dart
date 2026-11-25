import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class IosTrackingPermission {
  IosTrackingPermission({
    required this.isActive,
    required this.readStatus,
    required this.request,
  });

  final bool Function() isActive;
  final Future<TrackingStatus> Function() readStatus;
  final Future<TrackingStatus> Function() request;
  Future<bool>? _pending;

  Future<bool> resolve() =>
      _pending ??= _resolve().whenComplete(() => _pending = null);

  Future<bool> _resolve() async {
    try {
      final status = await readStatus();
      if (status != TrackingStatus.notDetermined) return true;
      if (!isActive()) return false;
      return await request() != TrackingStatus.notDetermined;
    } catch (_) {
      // Advertising stays off if the native authorization state is unavailable.
      return false;
    }
  }
}
