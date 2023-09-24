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

// https://en.wikipedia.org/wiki/Base32
String _hex16 = '0123456789abcdef';
String _crockfordBase32 = '0123456789ABCDEFGHJKMNPQRSTVWXYZ'.toLowerCase();

List<String> _hex = List<String>.generate(16, (int i) => _hex16[i]);
List<String> _base32 =
    List<String>.generate(32, (int i) => _crockfordBase32[i]);

List<int> _lowercaseCodes =
    List<int>.generate(32, (int i) => _crockfordBase32[i].codeUnits.first);
List<int> _base32Decode =
    List<int>.generate(256, (int i) => _lowercaseCodes.indexOf(i));
