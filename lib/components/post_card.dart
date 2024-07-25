import 'package:flutter/material.dart';
import 'package:get_local/layouts/home/detailed_post_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatefulWidget {
  final String id;
  final String companyId;
  final String title;
  final String company;
  final String content;
  const PostCard(
      {super.key,
      required this.id,
      required this.companyId,
      required this.title,
      required this.company,
      required this.content});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String? id;
  String? companyId;
  String? companyProfilePic;
  String? companyProfilePicUrl;
  String? postTitlePic;
  String? postTitlePicUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    companyId = widget.companyId;
    companyProfilePic = "company_$companyId\_profile_pic";
    postTitlePic = "company_$companyId\_post_$id";
    companyProfilePicUrl =
        "http://139.144.77.133/getLocalDemo/documents/$companyProfilePic\.jpg";
    postTitlePicUrl =
        "http://139.144.77.133/getLocalDemo/documents/$postTitlePic\.jpg";
    print(companyProfilePic);
    print(postTitlePic);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("card tapped");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedPostScreen(
                      company: widget.company,
                      title: widget.title,
                      content: widget.content,
                    )));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                      companyProfilePicUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Icon(Icons.person_2_outlined);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.company,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            height: screenSize.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 243, 252),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      spreadRadius: 1),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(children: [
                    Container(
                      height: screenSize.height * 0.21,
                      width: double.infinity,
                      child: Image.network(
                        postTitlePicUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.person_2_outlined);
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          height: screenSize.height * 0.1,
                          width: screenSize.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                softWrap: true,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ))
                  ]),
                ),
                const SizedBox(height: 8),
                Expanded(
                    child: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 16),
                  child: Text(
                    widget.content,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
