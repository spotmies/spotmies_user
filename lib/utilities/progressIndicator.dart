import 'package:flutter/material.dart';

circleProgress() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.indigo[100],
        color: Colors.indigo[900],
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[900]))),
  );
}
