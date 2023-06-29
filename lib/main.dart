import 'package:flutter/material.dart';

import 'my_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
