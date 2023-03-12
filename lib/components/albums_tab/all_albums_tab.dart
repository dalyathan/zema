import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zema/constants.dart';
import 'package:zema/providers/albums.dart';
import '../common/album.dart';

class AllAlbumsTabBarView extends StatefulWidget {
  const AllAlbumsTabBarView({super.key, required this.size});
  final Size size;

  @override
  State<AllAlbumsTabBarView> createState() => _AllAlbumsTabBarViewState();
}

class _AllAlbumsTabBarViewState extends State<AllAlbumsTabBarView> {
  @override
  Widget build(BuildContext context) {
    var albumWidth = widget.size.width * 0.35;
    var albumHeight = widget.size.height * 0.2;
    return Consumer<AlbumsProvider>(
      builder: (_, data, __) => SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'All Albums',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                  height:
                      data.items.isNotEmpty ? widget.size.height * 0.835 : 0,
                  child: NotificationListener<ScrollNotification>(
                      child: GridView.builder(
                          itemCount:
                              data.items.length + (data.next != null ? 1 : 0),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                          ),
                          itemBuilder: (BuildContext ctx, index) {
                            // print('index $index');
                            if (index < data.items.length - 1) {
                              final current = data.items[index];
                              return Album(
                                size: Size(albumWidth, albumWidth),
                                mainText: current.albumName,
                                supportingText: current.albumDescription,
                                imageUrl: current.albumCoverImage,
                              );
                            } else {
                              if (data.next != null &&
                                  data.items.isEmpty &&
                                  !data.isLoading) {
                                data.getNextItems();
                              }
                              return null;
                            }
                          }),
                      onNotification: (ScrollNotification scrollInfo) {
                        if ((scrollInfo.metrics.pixels >
                                scrollInfo.metrics.maxScrollExtent * 0.8) &&
                            !data.isLoading) {
                          data.getNextItems();
                        }
                        return true;
                      })),
              data.next != null
                  ? Center(
                      child: SizedBox(
                          width: widget.size.height * 0.05,
                          height: widget.size.height * 0.05,
                          child: const CircularProgressIndicator(
                            color: pinkLike,
                          )),
                    )
                  : const SizedBox()
            ]),
      ),
    );
  }
}
