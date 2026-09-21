import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../ocr_text_source.dart';

/// ML Kit metin tanıma adaptörü (spec §6.9: bundled Latin model, ağdan model
/// indirmesi yok; internetsiz çalışır). Native kaynak [dispose] ile kapatılır.
class MlKitTextSource implements OcrTextSource {
  final TextRecognizer _recognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  @override
  Future<OcrScanResult> scan(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final result = await _recognizer.processImage(inputImage);
    return OcrScanResult(
      lines: [
        for (final block in result.blocks)
          for (final line in block.lines)
            OcrLine(
              text: line.text,
              boundingBoxTop: line.boundingBox.top.toDouble(),
              boundingBoxLeft: line.boundingBox.left.toDouble(),
            ),
      ],
    );
  }

  void dispose() {
    _recognizer.close();
  }

}
