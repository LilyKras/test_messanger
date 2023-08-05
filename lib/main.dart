// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messenger/presentation/controllers/dialogs_controller.dart';
import 'package:messenger/presentation/screens/main_screen/dialog_info/dialog_info.dart';
import 'package:messenger/presentation/screens/main_screen/dialogs_list/dialogs_list.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'dart:async';

Timer? timer;
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
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

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // String? currCompanionId = (ref.watch(dialogController) as  DialogModel?) == null? null: (ref.watch(dialogController) as  DialogModel?)!.companionId;
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer t) => ref.watch(dialogsProv).addRandowFrase(),
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
