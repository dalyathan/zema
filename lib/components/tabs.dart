import 'package:flutter/material.dart';
import 'package:zema/components/albums_tab/all_albums_tab.dart';
import 'package:zema/components/explore_tab/explore_tab.dart';
import 'package:zema/components/favourites_tab/favourites_tab.dart';
import 'package:zema/constants.dart';

class MainTab extends StatelessWidget {
  const MainTab({super.key, required this.containerSize});
  final Size containerSize;

  @override
  Widget build(BuildContext context) {
    var height = containerSize.height * 0.03;
    var width = containerSize.width * 0.0725;
    var horizontalPadding = containerSize.width * 0.05;
    var verticalPadding = containerSize.height * 0.01;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(230, 219, 221, 1),
        appBar: AppBar(
          toolbarHeight: height,
          backgroundColor: pinkLike,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height),
            child: TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.5, horizontal: width),
              indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(height * 0.5),
                      right: Radius.circular(height * 0.5))),
              tabs: [
                Tab(
                  text: 'Explore',
                  height: height - 2.0,
                ),
                Tab(
                  text: 'Albums',
                  height: height - 2.0,
                ),
                Tab(
                  text: 'Favorites',
                  height: height - 2.0,
                ),
              ],
            ),
          ),
          // title: const Text('Tabs Demo'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: TabBarView(
            children: [
              ExploreTabBarView(
                  size:
                      Size(containerSize.width, containerSize.height - height)),
              AllAlbumsTabBarView(
                size: Size(containerSize.width, containerSize.height - height),
              ),
              FavouritesTabBarView(
                  size:
                      Size(containerSize.width, containerSize.height - height)),
            ],
          ),
        ),
      ),
    );
  }
}
