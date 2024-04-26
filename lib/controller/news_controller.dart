import 'package:final_project/model/news_model.dart';
import 'package:final_project/services/news_service.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    try {
      isLoading(true);
      var fetchedArticles = await NewsService().getArticles();
      articles.assignAll(fetchedArticles);
    } finally {
      isLoading(false);
    }
  }
}
