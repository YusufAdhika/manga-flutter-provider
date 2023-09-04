import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/presentation/provider/manga_list_recommended_nofier.dart';

import '../../common/routes.dart';

class MangaRecommendedPage extends StatefulWidget {
  const MangaRecommendedPage({super.key});

  @override
  State<MangaRecommendedPage> createState() => _MangaRecommendedPageState();
}

class _MangaRecommendedPageState extends State<MangaRecommendedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MangaRecommendedNotifier>(context, listen: false)
          ..fetchListRecommended());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manga Suggest'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<MangaRecommendedNotifier>(builder: (context, data, child) {
              final state = data.recommendedState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final manga = data.listRecommended[index];
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: data.listRecommended.length,
                );
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}
