import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloc_task/controllers/student_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentView(),
    );
  }
}

class StudentView extends StatelessWidget {
  StudentView ({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController controller = Get.put(StudentController());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Text(
                  'Students: ${controller.students.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                )),
          ),
          const Divider(height: 1),
          Expanded(
            child: Obx(() {
              if (controller.students.isEmpty) {
                return const Center(child: Text('No students available'));
              }
              return ListView.builder(
                itemCount: controller.students.length,
                itemBuilder: (context, index) {
                  final student = controller.students[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 1,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade50,
                        child: Text(
                          _getInitials(student.name),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        student.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Age: ${student.age}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showStudentDialog(context, controller, student: student),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.deleteStudent(student.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _showStudentDialog(context, controller),
      ),
    );
  }
  
  String _getInitials(String name) {
    List<String> names = name.split(" ");
    if (names.length >= 2) {
      return "${names[0][0]}${names[1][0]}".toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : "";
  }


  void _showStudentDialog(BuildContext context, StudentController controller, {Student? student}) {
    final nameController = TextEditingController(text: student?.name ?? '');
    final ageController = TextEditingController(text: student?.age.toString() ?? '');

    Get.defaultDialog(
      title: student == null ? 'Add Student' : 'Edit Student',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                if (nameController.text.isNotEmpty && ageController.text.isNotEmpty) {
                  int? age = int.tryParse(ageController.text);
                  if (age != null) {
                    if (student == null) {
                      controller.addStudent(nameController.text, age);
                    } else {
                      controller.updateStudent(student.id, nameController.text, age);
                    }
                    Get.back();
                  }
                }
              },
              child: Text(student == null ? 'Add' : 'Update', style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}