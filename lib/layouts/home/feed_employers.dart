import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/post_card.dart';
import 'package:get_local/models/post.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:load_switch/load_switch.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Timer? timer;
  List<Post> posts = [];

  int _tabTextIconIndexSelected = 0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      getPosts();
      setState(() {});
    });
    super.initState();
  }

  Future<List<Post>> getPosts() async {
    print("getting posts");
    try {
      const jsonEndpoint = "http://139.144.77.133/getLocalDemo/get_posts.php";

      final response = await post(
        Uri.parse(jsonEndpoint),
        body: "",
      );
      switch (response.statusCode) {
        case 200:
          List posts = json.decode(response.body);
          //print(posts);

          var formatted = posts.map((post) => Post.fromJson(post)).toList();
          //print(formatted);

          //print(formatted);

          return formatted;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception {
      print("Caught an exception: ");
      //return Future.error(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: FutureBuilder<List<Post>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (posts.isNotEmpty) {
                return Container(
                  color: Colors.blue,
                );
              }
            } else if (snapshot.hasData && snapshot.hasError == false) {
              print("snapshot data :");
              print(snapshot.data);
              posts = snapshot.data!;
              print("Snapshot contains data");

              if (posts.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Stack(children: [
                    Column(
                      children: [
                        FlutterToggleTab(
                          selectedBackgroundColors: [Colors.white],
                          unSelectedBackgroundColors: [
                            Color.fromARGB(255, 241, 243, 252)
                          ],
                          height: 40,
                          width: 92,
                          borderRadius: 15,
                          marginSelected: EdgeInsets.all(4),
                          selectedTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          unSelectedTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          labels: ["All", "Mining", "Construction"],
                          selectedIndex: _tabTextIconIndexSelected,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIconIndexSelected = index;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return PostCard(
                                company: posts[index].company,
                                title: posts[index].title!,
                                content: posts[index].content!,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ]),
                );
              }
            }
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
