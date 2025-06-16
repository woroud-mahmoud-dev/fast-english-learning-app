import 'package:flutter/material.dart';

goNext(context, namePage) {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return namePage;
  }));
}

goAndFinish(context, namePage) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {
    return    namePage();
  }), (route) => false);
}