import 'dart:math';
import 'dart:typed_data';

class Ulid {
  final Uint8List _bytes;

  Ulid._(this._bytes) {
    assert(_bytes.length == 16);
  }

  factory Ulid() {
    final bytes = Uint8List(16);
    final random = Random.secure();

    for (var i = 0; i < 16; i++) {
      bytes[i] = random.nextInt(256);
    }

    return Ulid._(bytes);
  }

  @override
  int get hashCode => _bytes.join().hashCode;
}
