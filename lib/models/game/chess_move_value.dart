// ignore: import_of_legacy_library_into_null_safe
import 'package:chess/chess.dart' as ch;

class MoveAndValue {
  ch.Move? move;
  int value;

  MoveAndValue({
    this.move,
    required this.value,
  });
}
