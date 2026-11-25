import 'package:flutter/services.dart';

const _channel = MethodChannel('nshoptor/device_trial');

Future<String?> readTrialDeviceId() async {
  try {
    return await _channel.invokeMethod<String>('getDeviceTrialId');
  } on MissingPluginException {
    return null;
  } on PlatformException {
    return null;
  }
}
