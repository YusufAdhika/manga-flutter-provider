import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/routes.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/presentation/provider/bookmark_manga_notifier.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BookmarkMangaNotifier>(context, listen: false)
            .fetchBookmarkManga());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manga Bookmark")),
      body: Consumer<BookmarkMangaNotifier>(
        builder: (context, data, child) {
          if (data.bookmarkState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.bookmarkState == RequestState.loaded) {
            return CustomScrollView(
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final manga = data.bookmarkManga[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            detailMangaRoute,
                            arguments: manga.endpoint,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: CachedNetworkImage(
                                height: 200,
                                imageUrl: manga.thumb.toString(),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                manga.title,
                                style: kSubtitle,
                                textAlign:
                                    TextAlign.center, // Center-align the text
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    childCount: data.bookmarkManga.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.7,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
