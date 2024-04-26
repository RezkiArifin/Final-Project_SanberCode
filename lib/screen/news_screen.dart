import 'package:final_project/controller/news_controller.dart';
import 'package:final_project/screen/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "BreakingNEWS",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xff42C6C5)),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        shadowColor: Colors.grey[200],
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xff42C6C5),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    var item = controller.articles[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          item.publishedAt,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                        leading: Image.network(item.image),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailScreen(article: item),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
