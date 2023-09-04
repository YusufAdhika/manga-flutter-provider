import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/presentation/notifier/manga_list_notifier.dart';
import 'package:read_manga/presentation/pages/manga_detail_page.dart';

import '../../common/routes.dart';

class MangaListPage extends StatefulWidget {
  const MangaListPage({super.key});

  @override
  State<MangaListPage> createState() => _MangaListPageState();
}

class _MangaListPageState extends State<MangaListPage> {
  final scrollController = ScrollController();
  var isLoading = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    Future.microtask(() =>
        Provider.of<MangaNotifier>(context, listen: false)..fetchListManga());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Manga'),
        actions: const [],
      ),
      body: Consumer<MangaNotifier>(builder: (context, data, child) {
        final state = data.listMangaState;
        if (state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.loaded) {
          return ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            padding: const EdgeInsets.only(
              top: 18,
              left: 18,
              right: 18,
            ),
            itemBuilder: (context, index) {
              final manga = data.listManga[index];
              if (index == data.listManga.length - 1 &&
                  data.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      detailMangaRoute,
                      arguments: manga.endpoint,
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: manga.thumb.toString(),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manga.title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kSubtitle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  manga.type.toString(),
                                  maxLines: 1,
                                  style: kBodyText,
                                ),
                                Text(
                                  manga.uploadOn.toString(),
                                  maxLines: 1,
                                  style: kBodyText,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: data.listManga.length,
          );
        } else {
          return const Text('Failed');
        }
      }),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Future.microtask(() =>
          Provider.of<MangaNotifier>(context, listen: false)..fetchNextManga());
    }
  }
}
