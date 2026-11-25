/// OCR çıktısının nötr temsili (spec §6.8, §6.9): gerçek motor (ML Kit)
/// adaptörü bu tiplere çevirir; mantık katmanı motordan bağımsızdır.
class OcrLine {
  const OcrLine({
    required this.text,
    this.boundingBoxTop,
    this.boundingBoxLeft,
    this.boundingBoxHeight,
    this.boundingBoxWidth,
  });

  final String text;

  /// Etiketteki konum: fiyat önceliği için kullanılır (üst-sol önce).
  final double? boundingBoxTop;
  final double? boundingBoxLeft;
  final double? boundingBoxHeight;
  final double? boundingBoxWidth;
}

class OcrScanResult {
  const OcrScanResult({required this.lines});

  final List<OcrLine> lines;
}

abstract class OcrTextSource {
  Future<OcrScanResult> scan(String imagePath);
}

/// Reads nothing.
///
/// Used on capture-first paths where the image model reads the photo: the
/// on-device recognizer would only slow the capture down, and it is not
/// needed to decide whether the capture succeeded.
class NoOcrTextSource implements OcrTextSource {
  const NoOcrTextSource();

  @override
  Future<OcrScanResult> scan(String imagePath) async =>
      const OcrScanResult(lines: []);
}

