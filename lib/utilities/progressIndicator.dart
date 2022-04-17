import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';

circleProgress() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        backgroundColor: SpotmiesTheme.themeMode
            ? SpotmiesTheme.primary
            : SpotmiesTheme.primaryVariant,
        color: SpotmiesTheme.themeMode
            ? SpotmiesTheme.primaryVariant
            : SpotmiesTheme.primary,
      ),
    ),
  );
}

linearProgress() {
  return Scaffold(
    body: Center(
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[100],
        color: Colors.indigo[900],
      ),
    ),
  );
}

refreshIndicator() {
  return Scaffold(
    body: Center(
        child: RefreshProgressIndicator(
            backgroundColor: Colors.grey[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade900))),
  );
}
