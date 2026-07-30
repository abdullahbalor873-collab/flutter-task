import 'package:get/get.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var data = await CategoryService.fetchCategories();
      categories.assignAll(data);
    } finally {
      isLoading(false);
    }
  }
  void addCategory(String name){
    int id = categories.isEmpty? 1:categories.last.id +1;
    categories.add(Category(id: id, name: name));
  }
}