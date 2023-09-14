import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/controllers/main_page_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    final provider = Provider.of<MainPageProvider>(context, listen: false);
    provider.getMainPageData();
    super.initState();
  }

  int _selectedIndex = 0;
  List<String> listTags = [
    "All",
    "Union Public Service Commission",
    "Mixes",
    "Music",
    "5G"
  ];
  String timeAgo(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '${difference.inDays} day ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 7) {
      return '${difference.inDays} week ago';
    } else {
      return '${difference.inDays ~/ 7} weeks ago';
    }
  }

  String viewConverter(String views) {
    int viewCount = int.tryParse(
            views.replaceAll(',', '').replaceAll(' views', '').trim()) ??
        0;

    if (viewCount == 0) {
      return "0 views";
    }

    String formattedViews = viewCount.toString();

    if (viewCount >= 1000000) {
      double millions = viewCount / 1000000.0;
      if (millions == millions.truncateToDouble()) {
        formattedViews = "${millions.truncate()}M views";
      } else {
        formattedViews = "${millions.toStringAsFixed(1)}M views";
      }
    } else if (viewCount >= 1000) {
      double thousands = viewCount / 1000.0;
      if (thousands == thousands.truncateToDouble()) {
        formattedViews = "${thousands.truncate()}K views";
      } else {
        formattedViews = "${thousands.toStringAsFixed(1)}K views";
      }
    } else {
      formattedViews = "$viewCount views";
    }

    return formattedViews;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainPageProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/youtube.png',
                    scale: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "YouTube",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Image.asset(
                    "assets/cast.png",
                    color: Colors.white,
                    scale: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/bell.png",
                    color: Colors.white,
                    scale: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/search.png",
                    scale: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 14,
                    child: Image.asset(
                      "assets/profile.png",
                      scale: 15,
                    ),
                  )
                ],
              ),
              provider.isLoading == true
                  ? SizedBox()
                  : SizedBox(
                      height: 25,
                      child: ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: listTags.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff5a5a5a)),
                            child: Text(
                              listTags[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              provider.isLoading == true
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 250.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Consumer<MainPageProvider>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.youTubeModel.items!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  // Image.asset("assets/thumbnail.jpg"),
                                  Image.network(
                                    value.youTubeModel.items![index].snippet!
                                        .thumbnails!.maxres!.url!,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value.youTubeModel.items![index]
                                                .snippet!.title!,
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                            softWrap: true,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${value.youTubeModel.items![index].snippet!.channelTitle!} ${viewConverter(value.youTubeModel.items![index].statistics!.viewCount!)} ${timeAgo(value.youTubeModel.items![index].snippet!.publishedAt!)}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                          softWrap: true,
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          // child:
                        );
                      },
                      // child:
                    )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    _selectedIndex == 0
                        ? 'assets/home_selected.png'
                        : 'assets/home.png',
                    scale: 20,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    _selectedIndex == 1
                        ? 'assets/shorts_selected.png'
                        : 'assets/shorts.png',
                    scale: 45,
                    color: Colors.white,
                  ),
                  label: "Shorts"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/add.png',
                    scale: 15,
                    color: Colors.white,
                    fit: BoxFit.fill,
                  ),
                  label: '-'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    _selectedIndex == 3
                        ? 'assets/subscriptions_selected.png'
                        : 'assets/subscriptions.png',
                    scale: 25,
                    color: Colors.white,
                  ),
                  label: "Subscriptions"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    _selectedIndex == 4
                        ? 'assets/library_selected.png'
                        : 'assets/library.png',
                    scale: 25,
                    color: Colors.white,
                  ),
                  label: "Library"),
            ]),
      ),
    );
  }
}
