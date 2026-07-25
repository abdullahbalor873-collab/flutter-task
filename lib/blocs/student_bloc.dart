import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_task/models/student_model.dart';
import 'student_event.dart';
import 'student_state.dart';
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final List<Student> _students = [
    Student(id: '1', name: 'John Doe', age: 21),
    Student(id: '2', name: 'Sarah Johnson', age: 19),
    Student(id: '3', name: 'Michael Brown', age: 22),
  ];

  StudentBloc() : super(StudentInitial()) {
    on<LoadStudentsEvent>((event, emit) {
      emit(StudentLoadedState(students: List.from(_students)));
    });

    on<AddStudentEvent>((event, emit) {
      final newStudent = Student(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        age: event.age,
      );
      _students.add(newStudent);
      emit(StudentLoadedState(students: List.from(_students)));
    });

    on<UpdateStudentEvent>((event, emit) {
      final index = _students.indexWhere((s) => s.id == event.id);
      if (index != -1) {
        _students[index] = Student(id: event.id, name: event.name, age: event.age);
        emit(StudentLoadedState(students: List.from(_students)));
      }
    });

    on<DeleteStudentEvent>((event, emit) {
      _students.removeWhere((s) => s.id == event.id);
      emit(StudentLoadedState(students: List.from(_students)));
    });
  }
}