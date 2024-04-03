// ignore_for_file: non_constant_identifier_names
import 'package:aarogyam/patient/data/models/blog_model.dart';
import 'package:aarogyam/patient/data/services/database_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class HealthBlog extends StatefulWidget {
  const HealthBlog({super.key});

  @override
  State<HealthBlog> createState() => _HealthBlogState();
}

class _HealthBlogState extends State<HealthBlog> {
  late final Stream<List<BlogModel>> dataStream;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    dataStream = db.getBlogsStream();
  }

  int currentIndex = 0;
  final db = DatabaseService();
  final MyItems = [
    Image.asset('assets/icons/healthblog/Heart.png'),
    Image.asset('assets/icons/healthblog/Kidneys.png'),
    Image.asset('assets/icons/healthblog/Liver.png'),
    Image.asset('assets/icons/healthblog/Thyroid.png'),
    Image.asset('assets/icons/healthblog/Lung.png'),
    Image.asset('assets/icons/healthblog/Bones.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Health BLOG",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal),
                  color: Colors.white,
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchText = '';
                          });
                        },
                        icon: const Icon(Icons.send, color: Colors.orangeAccent),
                      ),
                      hintText: 'Search Articles',
                      hintStyle: const TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'Healthy Organs',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.teal, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 70,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollPhysics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: MyItems.map((item) => item).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'Latest Articles',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal.shade700),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<BlogModel>>(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final filteredBlogs = snapshot.data
                      ?.where((blog) =>
                  blog.categoryName?.toLowerCase().contains(searchText.toLowerCase()) ?? false)
                      .toList();
                  if (filteredBlogs == null || filteredBlogs.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredBlogs.length,
                    itemBuilder: (context, index) {
                      final blog = filteredBlogs[index];
                      return _BlogArticle(
                        blogImage: blog.blogImage ?? '',
                        topicName: blog.topicName ?? '',
                        categoryName: blog.categoryName ?? '',
                        description: blog.description ?? '',
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BlogArticle extends StatelessWidget {
  final String blogImage;
  final String topicName;
  final String categoryName;
  final String description;

  const _BlogArticle({
    required this.blogImage,
    required this.topicName,
    required this.categoryName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          child: Column(
            children: [
              SizedBox(
                child: Image.network(
                  blogImage,
                  fit: BoxFit.cover,
                  height: 140,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      topicName,
                      maxLines: 3,
                      style:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
