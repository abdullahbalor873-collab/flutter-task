import 'package:bloc_task/blocs/student_bloc.dart';
import 'package:bloc_task/blocs/student_event.dart';
import 'package:bloc_task/views/student_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc()..add(LoadStudentsEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StudentManagementScreen(),
      ),
    );
  }
}