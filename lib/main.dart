import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/category_binding.dart';
import 'views/category_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Categories Task',
      initialRoute: '/categories',
      getPages: [
        GetPage(
          name: '/categories',
          page: () => const CategoryView(),
          binding: CategoryBinding(), // ربط الـ Binding مع الشاشة
        ),
      ],
    );
  }
}