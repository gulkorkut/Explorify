import 'dart:convert';

import 'package:explorify/classes/playlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:explorify/pages/detail_page.dart';
import 'package:explorify/widgets/discover_card.dart';
import 'package:explorify/widgets/discover_small_card.dart';
import 'package:explorify/services/spotify_API/spotify_api.dart';

import 'package:explorify/classes/album.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override

  State<DiscoverPage> createState() => _DiscoverPageState();
}


class _DiscoverPageState extends State<DiscoverPage> {
  late Future<Album> futureAlbum1;
  late Future<Album> futureAlbum2;
  late Future<Album> futureAlbum3;
  late Future<Album> futureAlbum4;
  late Future<Album> futureAlbum5;
  late Future<Album> futureAlbum6;

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);
    SpotifyApi api_handler = SpotifyApi();
    futureAlbum1 = api_handler.getAlbum('4cO51KBYsdsbmSZleoNEGH');
    futureAlbum2 = api_handler.getAlbum('3MdiH74FL8mhlbnR6DcqJd');
    futureAlbum3 = api_handler.getAlbum('0vzKMInu4PzU2Qyi6NgmRK');
    futureAlbum4 = api_handler.getAlbum('6Pck74JfHDGsFPCgfxoRJE');
    futureAlbum5 = api_handler.getAlbum('5PCB1oWRMzO4lqaSlEMYS0');
    futureAlbum6 = api_handler.getAlbum('4hCuee6XJrhXfeedeoEv7r');
    setState(() => isLoading = false);
  }
  

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 36.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discover",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    onTap: onSearchIconTapped,
                    child: Container(
                      height: 35.w,
                      width: 35.w,
                      child: const Center(
                        child: Icon(Icons.search, color: Colors.white,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended",
                    style: TextStyle(
                        color: const Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ),
                  GestureDetector(
                      onTap: onSeeAllTapped,
                      child: Text("See All",
                          style: TextStyle(
                              color: const Color(0xff4A80F0),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w)))
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 176.w,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 28.w),
                  FutureBuilder<Album>(
                    future: futureAlbum1,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DiscoverCard(
                          tag: snapshot.data!.name,
                          onTap: onSleepMeditationTapped,
                          title: snapshot.data!.name,
                          subtitle: "Track count: "+snapshot.data!.total_tracks.toString(),
                          imageUrl: snapshot.data!.images[0]['url'],
                        );
                      }
                      else if (snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }
                  ),
                  SizedBox(width: 20.w),
                  FutureBuilder<Album>(
                      future: futureAlbum2,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DiscoverCard(
                            tag: snapshot.data!.name,
                            onTap: onSleepMeditationTapped,
                            title: snapshot.data!.name,
                            subtitle: "Track count: "+snapshot.data!.total_tracks.toString(),
                            imageUrl: snapshot.data!.images[0]['url'],
                          );
                        }
                        else if (snapshot.hasError){
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: Text(
                "Check these out!",
                style: TextStyle(
                    color: const Color(0xff515979),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.w),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 28.w),
              child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder<Album>(
                    future: futureAlbum3,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DiscoverSmallCard(
                          onTap: (){},
                          title: snapshot.data!.name,
                          gradientStartColor: const Color(0xff13DEA0),
                          gradientEndColor: const Color(0xff06B782),
                        );
                      }
                      else if (snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }

                  ),
                  FutureBuilder<Album>(
                      future: futureAlbum4,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DiscoverSmallCard(
                            onTap: (){},
                            title: snapshot.data!.name,
                            gradientStartColor: const Color(0xffFC67A7),
                            gradientEndColor: const Color(0xffF6815B),
                          );
                        }
                        else if (snapshot.hasError){
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }

                  ),
                  FutureBuilder<Album>(
                      future: futureAlbum5,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DiscoverSmallCard(
                            onTap: (){},
                            title: snapshot.data!.name,
                            gradientStartColor: const Color(0xffFFD541),
                            gradientEndColor: const Color(0xffF0B31A),
                          );
                        }
                        else if (snapshot.hasError){
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }

                  ),
                  FutureBuilder<Album>(
                      future: futureAlbum6,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DiscoverSmallCard(
                            onTap: (){},
                            title: snapshot.data!.name,
                            gradientStartColor: const Color(0xffFFD541),
                            gradientEndColor: const Color(0xffF0B31A),
                          );
                        }
                        else if (snapshot.hasError){
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      }

                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }


  void onSeeAllTapped() {
  }

  void onSleepMeditationTapped() {
    Get.to(()=> const DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {
  }

  void onSearchIconTapped() {
  }
}
