import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../ocr_deskew.dart';
import '../ocr_text_source.dart';

/// ML Kit metin tanıma adaptörü (spec §6.9: bundled Latin model, ağdan model
/// indirmesi yok; internetsiz çalışır). Native kaynak [dispose] ile kapatılır.
/// Satır kutuları medyan eğime göre düzletilir: hafif eğik fişte fiyat
/// sütunu ad sütunundan yüksek çıkar ve satır eşlemesi yanlış ürüne bakardı.
class MlKitTextSource implements OcrTextSource {
  final TextRecognizer _recognizer = TextRecognizer(
    script: TextRecognitionScript.latin,
  );

  @override
  Future<OcrScanResult> scan(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final result = await _recognizer.processImage(inputImage);
    final lines = [
      for (final block in result.blocks)
        for (final line in block.lines)
          OcrLine(
            text: line.text,
            boundingBoxTop: line.boundingBox.top.toDouble(),
            boundingBoxLeft: line.boundingBox.left.toDouble(),
            boundingBoxHeight: line.boundingBox.height.toDouble(),
            boundingBoxWidth: line.boundingBox.width.toDouble(),
          ),
    ];
    final angles = [
      for (final block in result.blocks)
        for (final line in block.lines)
          line.angle,
    ];
    return OcrScanResult(
      lines: deskewLines(lines, medianAngleDegrees(angles)),
    );
  }

  Future<void> dispose() => _recognizer.close();
}
