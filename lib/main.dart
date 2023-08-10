// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/presentation/bloc/dialog_bloc.dart';
import 'package:messenger/presentation/bloc/dialogs_bloc.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/dialog_info.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/dialogs_list.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'dart:async';

Timer? timer;

DialogBloc dialogBloc = DialogBloc();
DialogsBloc dialogsBloc = DialogsBloc(dialogBloc);
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DialogBloc>(
          create: (context) => dialogBloc,
        ),
        BlocProvider<DialogsBloc>(
          create: (context) => dialogsBloc,
        ),
      ],
      child: const MyApp(),
    ),
  );
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer t) => dialogsBloc.add(AddRandomFrases()),
    );

    return const Scaffold(
      body: Center(
        child: Row(
          children: [DialogList(), DialogInfo()],
        ),
      ),
    );
  }
}
