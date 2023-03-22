import 'package:flutter/material.dart';
import 'package:zema/constants.dart';
import 'package:zema/providers/super.dart';

class LazilyLoadingListView extends StatelessWidget {
  const LazilyLoadingListView(
      {super.key,
      required this.size,
      required this.content,
      required this.header,
      required this.provider,
      required this.scrollDirection});
  final Size size;
  final Iterable<Widget> content;
  final String header;
  final Axis scrollDirection;
  final SuperProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          // const Spacer(),
          SizedBox(
            height: size.height * 0.8,
            width: size.width,
            child: ListView.separated(
                scrollDirection: scrollDirection,
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount:
                    provider.items.length + (provider.next != null ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < provider.items.length - 1) {
                    return content.elementAt(index);
                  } else {
                    if (!provider.isLoading && provider.next != null) {
                      provider.getNextItems();
                      return provider.next != null
                          ? SizedBox(
                              width:
                                  provider.items.isNotEmpty ? 32 : size.width,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: pinkLike,
                                ),
                              ),
                            )
                          : null;
                    }
                    return null;
                  }
                } // ListView(children: [
                ),
          )
        ],
      ),
    );
  }
}
