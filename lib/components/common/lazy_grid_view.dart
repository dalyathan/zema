import 'package:flutter/material.dart';
import 'package:zema/providers/super.dart';

import '../../constants.dart';

class LazyLoadingVerticalListView extends StatelessWidget {
  const LazyLoadingVerticalListView(
      {super.key,
      required this.data,
      required this.size,
      required this.content,
      required this.header});
  final SuperProvider data;
  final Size size;
  final Iterable<Widget> content;
  final String header;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
                height: data.items.isNotEmpty ? size.height * 0.835 : 0,
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
                            return content.elementAt(index);
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
                        width: size.height * 0.05,
                        height: size.height * 0.05,
                        child: const CircularProgressIndicator(
                          color: pinkLike,
                        )),
                  )
                : const SizedBox()
          ]),
    );
  }
}
