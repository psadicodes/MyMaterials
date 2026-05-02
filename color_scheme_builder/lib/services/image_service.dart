import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:material_color_utilities/material_color_utilities.dart';

class ImageService {
  // Returns up to 5 ranked source color suggestions (ARGB ints)
  static Future<List<int>> extractSourceColors(Uint8List bytes) async {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return [];

    // Down-sample to at most 112×112 for performance
    final thumb = decoded.width > 112 || decoded.height > 112
        ? img.copyResize(decoded, width: 112, height: 112)
        : decoded;

    final pixels = <int>[];
    for (int y = 0; y < thumb.height; y++) {
      for (int x = 0; x < thumb.width; x++) {
        final p = thumb.getPixel(x, y);
        final a = p.a.toInt();
        if (a < 128) continue; // skip transparent
        final r = p.r.toInt();
        final g = p.g.toInt();
        final b = p.b.toInt();
        pixels.add(0xFF000000 | (r << 16) | (g << 8) | b);
      }
    }
    if (pixels.isEmpty) return [];

    final result = await QuantizerCelebi().quantize(pixels, 128);
    final ranked = Score.score(result.colorToCount, desired: 5);
    return ranked;
  }
}
