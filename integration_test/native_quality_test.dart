// One native debug build exercises all independent regressions. Flutter runs
// later test cases after a failure; the overall run still fails if any fail.
import 'receipt_realistic_test.dart' as synthetic;
import 'receipt_cord_test.dart' as photographed;
import 'report_pdf_test.dart' as report;

void main() {
  synthetic.main();
  photographed.main();
  report.main();
}
