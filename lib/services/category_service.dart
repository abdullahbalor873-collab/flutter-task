import '../models/category_model.dart';

class CategoryService {
  static Future<List<Category>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 4)); 
    return [
      Category(id: 1, name: 'Electronics'),
      Category(id: 2, name: 'Home'),
      Category(id: 3, name: 'Clothing'),
      Category(id: 4, name: 'Books'),
    ];
  }
}