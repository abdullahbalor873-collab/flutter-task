import 'package:bloc_task/views/category_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';



class CategoryView extends StatelessWidget {
  const CategoryView({super.key});
  Map<String, dynamic> _getCategoryStyle(String name) {
    String lowerName = name.toLowerCase();
    if (lowerName.contains('electronic') || lowerName.contains('إلكترون')) {
      return {'icon': Icons.devices_rounded, 'color': const Color(0xFF4F46E5), 'bg': const Color(0xFFEEF2FF)};
    } else if (lowerName.contains('home') || lowerName.contains('منزل')) {
      return {'icon': Icons.home_rounded, 'color': const Color(0xFF0EA5E9), 'bg': const Color(0xFFE0F2FE)};
    } else if (lowerName.contains('cloth') || lowerName.contains('ملابس')) {
      return {'icon': Icons.checkroom_rounded, 'color': const Color(0xFFEC4899), 'bg': const Color(0xFFFCE7F3)};
    } else if (lowerName.contains('book') || lowerName.contains('كتب')) {
      return {'icon': Icons.menu_book_rounded, 'color': const Color(0xFFF59E0B), 'bg': const Color(0xFFFEF3C7)};
    } else {
      return {'icon': Icons.category_rounded, 'color': const Color(0xFF10B981), 'bg': const Color(0xFFD1FAE5)};

    }
    
  }

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find<CategoryController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Store Categories ',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CupertinoActivityIndicator(radius: 18, color: Color(0xFF4F46E5)),
          );
        }

        if (controller.categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grid_view_rounded, size: 70, color: Colors.grey.shade400),
                const SizedBox(height: 12),
                Text('There are currently no sections   ', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
              ],
            ),
          );
        }

        
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 16, 
            mainAxisSpacing: 16, 
            childAspectRatio: 1.1, 
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final style = _getCategoryStyle(category.name);

            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              elevation: 2,
              shadowColor: Colors.black,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                 
                  Get.to(
                    () => const CategoryDetailView(),
                    arguments: category,
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: style['bg'],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              style['icon'],
                              color: style['color'],
                              size: 28,
                            ),
                          ),
                   
                        ],
                      ),
                      const Spacer(),
                  
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                     
                      Text(
                        'Show Seme Details',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int newId = controller.categories.isEmpty ? 1 : controller.categories.last.id + 1;
          controller.addCategory('New details$newId');
        },
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add New', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}