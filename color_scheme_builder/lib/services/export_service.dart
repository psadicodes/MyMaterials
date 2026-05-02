import '../models/color_token.dart';
import '../models/scheme_config.dart';
import 'scheme_service.dart';

class ExportService {
  static String _argbToCompose(int argb) {
    return 'Color(0x${argb.toRadixString(16).toUpperCase().padLeft(8, '0')})';
  }

  // Suffix map: scheme key → variable suffix (e.g. "Light", "LightMediumContrast")
  static const Map<String, String> _suffix = {
    'light':               'Light',
    'lightMediumContrast': 'LightMediumContrast',
    'lightHighContrast':   'LightHighContrast',
    'dark':                'Dark',
    'darkMediumContrast':  'DarkMediumContrast',
    'darkHighContrast':    'DarkHighContrast',
  };

  // ── Color.kt ───────────────────────────────────────────────────────────────
  static String generateColorKt(SchemeConfig config) {
    final schemes = SchemeService.buildExportSchemes(config);
    final buf = StringBuffer();
    buf.writeln('package com.example.compose');
    buf.writeln('import androidx.compose.ui.graphics.Color');
    buf.writeln();

    for (final entry in _suffix.entries) {
      final tokens = schemes[entry.key]!;
      final suffix = entry.value;
      for (final t in tokens) {
        final varName = '${t.name}$suffix';
        buf.writeln('val $varName = ${_argbToCompose(t.argb)}');
      }
      buf.writeln();
    }
    return buf.toString();
  }

  // ── Theme.kt ───────────────────────────────────────────────────────────────
  static String generateThemeKt() {
    final buf = StringBuffer();
    buf.writeln('package com.example.compose');
    buf.writeln('import android.app.Activity');
    buf.writeln('import android.os.Build');
    buf.writeln('import androidx.compose.foundation.isSystemInDarkTheme');
    buf.writeln('import androidx.compose.material3.MaterialTheme');
    buf.writeln('import androidx.compose.material3.lightColorScheme');
    buf.writeln('import androidx.compose.material3.darkColorScheme');
    buf.writeln('import androidx.compose.material3.dynamicDarkColorScheme');
    buf.writeln('import androidx.compose.material3.dynamicLightColorScheme');
    buf.writeln('import androidx.compose.material3.Typography');
    buf.writeln('import androidx.compose.runtime.Composable');
    buf.writeln('import androidx.compose.runtime.Immutable');
    buf.writeln('import androidx.compose.ui.graphics.Color');
    buf.writeln('import androidx.compose.ui.graphics.toArgb');
    buf.writeln('import androidx.compose.ui.platform.LocalContext');
    buf.writeln();

    buf.write(_colorSchemeBlock('private val lightScheme', 'lightColorScheme', 'Light'));
    buf.writeln();
    buf.write(_colorSchemeBlock('private val darkScheme', 'darkColorScheme', 'Dark'));
    buf.writeln();
    buf.write(_colorSchemeBlock('private val mediumContrastLightColorScheme', 'lightColorScheme', 'LightMediumContrast'));
    buf.writeln();
    buf.write(_colorSchemeBlock('private val highContrastLightColorScheme', 'lightColorScheme', 'LightHighContrast'));
    buf.writeln();
    buf.write(_colorSchemeBlock('private val mediumContrastDarkColorScheme', 'darkColorScheme', 'DarkMediumContrast'));
    buf.writeln();
    buf.write(_colorSchemeBlock('private val highContrastDarkColorScheme', 'darkColorScheme', 'DarkHighContrast'));
    buf.writeln();

    // ColorFamily data class + unspecified_scheme
    buf.writeln('@Immutable');
    buf.writeln('data class ColorFamily(');
    buf.writeln('    val color: Color,');
    buf.writeln('    val onColor: Color,');
    buf.writeln('    val colorContainer: Color,');
    buf.writeln('    val onColorContainer: Color');
    buf.writeln(')');
    buf.writeln();
    buf.writeln('val unspecified_scheme = ColorFamily(');
    buf.writeln('    Color.Unspecified, Color.Unspecified, Color.Unspecified, Color.Unspecified');
    buf.writeln(')');
    buf.writeln();

    // AppTheme composable
    buf.writeln('@Composable');
    buf.writeln('fun AppTheme(');
    buf.writeln('    darkTheme: Boolean = isSystemInDarkTheme(),');
    buf.writeln('    // Dynamic color is available on Android 12+');
    buf.writeln('    dynamicColor: Boolean = true,');
    buf.writeln('    content: @Composable() () -> Unit');
    buf.writeln(') {');
    buf.writeln('  val colorScheme = when {');
    buf.writeln('      dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {');
    buf.writeln('          val context = LocalContext.current');
    buf.writeln('          if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)');
    buf.writeln('      }');
    buf.writeln('      darkTheme -> darkScheme');
    buf.writeln('      else -> lightScheme');
    buf.writeln('  }');
    buf.writeln();
    buf.writeln('  MaterialTheme(');
    buf.writeln('    colorScheme = colorScheme,');
    buf.writeln('    typography = AppTypography,');
    buf.writeln('    content = content');
    buf.writeln('  )');
    buf.writeln('}');
    return buf.toString();
  }

  static String _colorSchemeBlock(String varDecl, String fn, String suffix) {
    final buf = StringBuffer();
    buf.writeln('$varDecl = $fn(');
    for (final name in kColorSchemeTokenNames) {
      buf.writeln('    $name = $name$suffix,');
    }
    buf.writeln(')');
    return buf.toString();
  }

  // ── Type.kt ────────────────────────────────────────────────────────────────
  static String generateTypeKt(FontConfig fontConfig) {
    final buf = StringBuffer();
    buf.writeln('package com.example.ui.theme');
    buf.writeln();
    buf.writeln('import androidx.compose.material3.Typography');
    buf.writeln('import androidx.compose.ui.text.TextStyle');
    buf.writeln('import androidx.compose.ui.text.font.FontFamily');
    buf.writeln('import androidx.compose.ui.text.font.FontWeight');
    buf.writeln('import androidx.compose.ui.unit.sp');
    buf.writeln();

    final display = fontConfig.displayFont;
    final body = fontConfig.bodyFont;

    if (display.isGoogleFont || body.isGoogleFont) {
      buf.writeln('import androidx.compose.ui.text.googlefonts.GoogleFont');
      buf.writeln('import androidx.compose.ui.text.googlefonts.Font');
      buf.writeln();
      buf.writeln('val provider = GoogleFont.Provider(');
      buf.writeln('    providerAuthority = "com.google.android.gms.fonts",');
      buf.writeln('    providerPackage = "com.google.android.gms",');
      buf.writeln('    certificates = R.array.com_google_android_gms_fonts_certs');
      buf.writeln(')');
      buf.writeln();
    }

    if (!display.isGoogleFont) {
      buf.writeln('import androidx.compose.ui.text.font.Font');
    }

    // displayFontFamily
    buf.writeln('val displayFontFamily = FontFamily(');
    if (display.isGoogleFont) {
      buf.writeln('    Font(');
      buf.writeln('        googleFont = GoogleFont("${display.name}"),');
      buf.writeln('        fontProvider = provider,');
      buf.writeln('    )');
    } else {
      final resName = _toResName(display.localFileName ?? display.name);
      buf.writeln('    Font(R.font.$resName, FontWeight.Normal),');
    }
    buf.writeln(')');
    buf.writeln();

    // bodyFontFamily
    buf.writeln('val bodyFontFamily = FontFamily(');
    if (body.isGoogleFont) {
      buf.writeln('    Font(');
      buf.writeln('        googleFont = GoogleFont("${body.name}"),');
      buf.writeln('        fontProvider = provider,');
      buf.writeln('    )');
    } else {
      final resName = _toResName(body.localFileName ?? body.name);
      buf.writeln('    Font(R.font.$resName, FontWeight.Normal),');
    }
    buf.writeln(')');
    buf.writeln();

    buf.writeln('// Default Material 3 typography values');
    buf.writeln('val baseline = Typography()');
    buf.writeln();
    buf.writeln('val AppTypography = Typography(');
    for (final style in _displayStyles) {
      buf.writeln('    $style = baseline.$style.copy(fontFamily = displayFontFamily),');
    }
    for (final style in _bodyStyles) {
      buf.writeln('    $style = baseline.$style.copy(fontFamily = bodyFontFamily),');
    }
    buf.writeln(')');
    return buf.toString();
  }

  static const _displayStyles = [
    'displayLarge', 'displayMedium', 'displaySmall',
    'headlineLarge', 'headlineMedium', 'headlineSmall',
    'titleLarge', 'titleMedium', 'titleSmall',
  ];

  static const _bodyStyles = [
    'bodyLarge', 'bodyMedium', 'bodySmall',
    'labelLarge', 'labelMedium', 'labelSmall',
  ];

  static String _toResName(String name) =>
      name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');

  // ── font_certs.xml ─────────────────────────────────────────────────────────
  static String generateFontCertsXml() => r'''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <array name="com_google_android_gms_fonts_certs">
        <item>@array/com_google_android_gms_fonts_certs_dev</item>
        <item>@array/com_google_android_gms_fonts_certs_prod</item>
    </array>
    <string-array name="com_google_android_gms_fonts_certs_dev">
        <item>
            MIIEqDCCA5CgAwIBAgIJANWFuGx90071MA0GCSqGSIb3DQEBBAUAMIGUMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEQMA4GA1UEChMHQW5kcm9pZDEQMA4GA1UECxMHQW5kcm9pZDEQMA4GA1UEAxMHQW5kcm9pZDEiMCAGCSqGSIb3DQEJARYTYW5kcm9pZEBhbmRyb2lkLmNvbTAeFw0wODA0MTUyMzM2NTZaFw0zNTA5MDEyMzM2NTZaMIGUMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEQMA4GA1UEChMHQW5kcm9pZDEQMA4GA1UECxMHQW5kcm9pZDEQMA4GA1UEAxMHQW5kcm9pZDEiMCAGCSqGSIb3DQEJARYTYW5kcm9pZEBhbmRyb2lkLmNvbTCCASAwDQYJKoZIhvcNAQEBBQADggENADCCAQgCggEBANbOLggKv+IxTdGNs8/TGFy0PTP6DHThvbbR24kT9ixcOd9W+EaBPWW+wPPKQmsHxajtWjmQwWfna8mZuSeJS48LIgAZlKkpFeVyxW0qMBujb8X8ETrWy550NaFtI6t9+u7hZeTfHwqNvacKhp1RbE6dBRGWynwMVX8XW8N1+UjFaq6GCJukT4qmpN2afb8sCjUigq0GuMwYXrFVee74bQgLHWGJwPmvmLHC69EH6kWr22ijx4OKXlSIx2xT1AsSHee70w5iDBiK4aph27yH3TxkXy9V89TDdexAcKk/cVHYNnDBapcavl7y0RiQ4biu8ymM8Ga/nmzhRKya6G0cGw8CAQOjgfwwgfkwHQYDVR0OBBYEFI0cxb6VTEM8YYY6FbBMvAPyT+CyMIHJBgNVHSMEgcEwgb6AFI0cxb6VTEM8YYY6FbBMvAPyT+CyoYGapIGXMIGUMQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEQMA4GA1UEChMHQW5kcm9pZDEQMA4GA1UECxMHQW5kcm9pZDEQMA4GA1UEAxMHQW5kcm9pZDEiMCAGCSqGSIb3DQEJARYTYW5kcm9pZEBhbmRyb2lkLmNvbYIJANWFuGx90071MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEEBQADggEBABnTDPEF+3iSP0wNfdIjIz1AlnrPzgAIHVvXxunW7SBrDhEglQZBbKJEk5kT0mtKoOD1JMrSu1xuTKEBahWRbqHsXclaXjoBADb0kkjVEJu/Lh5hgYZnOjvlba8Ld7HCKePCVePoTJBdI4fvugnL8TsgK05aIskyY0hKI9L8KfqfGTl1lzOv2KoWD0KWwtAWPoGChZxmQ+nBli+gwYMzM1vAkP+aayLe0a1EQimlOalO762r0GXO0ks+UeXde2Z4e+8S/pf7pITEI/tP+MxJTALw9QUWEv9lKTk+jkbqxbsh8nfBUapfKqYn0eidpwq2AzVp3juYl7//fKnaPhJD9gs=
        </item>
    </string-array>
    <string-array name="com_google_android_gms_fonts_certs_prod">
        <item>
            MIIEQzCCAyugAwIBAgIJAMLgh0ZkSjCNMA0GCSqGSIb3DQEBBAUAMHQxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRQwEgYDVQQKEwtHb29nbGUgSW5jLjEQMA4GA1UECxMHQW5kcm9pZDEQMA4GA1UEAxMHQW5kcm9pZDAeFw0wODA4MjEyMzEzMzRaFw0zNjAxMDcyMzEzMzRaMHQxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRQwEgYDVQQKEwtHb29nbGUgSW5jLjEQMA4GA1UECxMHQW5kcm9pZDEQMA4GA1UEAxMHQW5kcm9pZDCCASAwDQYJKoZIhvcNAQEBBQADggENADCCAQgCggEBAKtWLgDYO6IIrgqWbxJOKdoR8qtW0I9Y4sypEwPpt1TTcvZApxsdyxMJZ2JORland2qSGT2y5b+3JKkedxiLDmpHpDsz2WCbdxgxRczfey5YZnTJ4VZbH0xqWVW/8lGmPav5xVwnIiJS6HXk+BVKZF+JcWjAsb/GEuq/eFdpuzSqeYTcfi6idkyugwfYwXFU1+5fZKUaRKYCwkkFQVfcAs1fXA5V+++FGfvjJ/CxURaSxaBvGdGDhfXE28LWuT9ozCl5xw4Yq5OGazvV24mZVSoOO0yZ31j7kYvtwYK6NeADwbSxDdJEqO4k//0zOHKrUiGYXtqw/A0LFFtqoZKFjnkCAQOjgdkwgdYwHQYDVR0OBBYEFMd9jMIhF1Ylmn/Tgt9r45jk14alMIGmBgNVHSMEgZ4wgZuAFMd9jMIhF1Ylmn/Tgt9r45jk14aloXikdjB0MQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEUMBIGA1UEChMLR29vZ2xlIEluYy4xEDAOBgNVBAsTB0FuZHJvaWQxEDAOBgNVBAMTB0FuZHJvaWSCCQDC4IdGZEowjTAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBAUAA4IBAQBt0lLO74UwLDYKqs6Tm8/yzKkEu116FmH4rkaymUIE0P9KaMftGlMexFlaYjzmB2OxZyl6euNXEsQH8gjwyxCUKRJNexBiGcCEyj6z+a1fuHHvkiaai+KL8W1EyNmgjmyy8AW7P+LLlkR+ho5zEHatRbM/YAnqGcFh5iZBqpknHf1SKMXFh4dd239FJ1jWYfbMDMy3NS5CTMQ2XFI1MvcyUTdZPErjQfTbQe3aDQsQcafEQPD+nqActifKZ0Np0IS9L9kR/wbNvyz6ENwPiTrjV2KRkEjH78ZMcUQXg0L3BYHJ3lc69Vs5Ddf9uUGGMYldX3WfMBEmh/9iFBDAaTCK
        </item>
    </string-array>
</resources>''';
}
