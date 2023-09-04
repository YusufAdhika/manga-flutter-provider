import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/presentation/notifier/manga_detail_notifier.dart';
import 'package:read_manga/presentation/pages/list_read_manga_pager.dart';
import 'package:read_manga/presentation/pages/read_manga_page.dart';

class MangaDetailPage extends StatefulWidget {
  static const route = '/detail';

  final String id;
  const MangaDetailPage({super.key, required this.id});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MangaDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MangaDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.mangaDetailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.mangaDetailState == RequestState.loaded) {
            final mangaDetail = provider.listManga;
            return SafeArea(
              child: DetailContent(mangaDetail),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MangaDetail manga;

  const DetailContent(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Center(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[600],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(manga.thumb),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  manga.title,
                  style: kHeading6,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "•  ${manga.type}  •  ${manga.status}",
                  style: kBodyText,
                ),
                Text(
                  "•  Author by ${manga.author}",
                  style: kBodyText,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "Genres",
                  style: kHeading6,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  children: List.generate(
                    manga.genreList.length,
                    (index) {
                      var data = manga.genreList[index];
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 4),
                              child: Text(
                                data.genreName,
                                style: kBodyText,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "Synopsis",
                  style: kHeading6,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  manga.synopsis,
                  style: kBodyText,
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List Chapter",
                      style: kHeading6,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ListReadMangaPage.route,
                          arguments: manga,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('See More'),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = manga.chapter[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(12)),
                          child: Ink(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ReadMangaPage.route,
                                  arguments: data.chapterEndpoint,
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(data.chapterTitle),
                              ),
                            ),
                          )),
                    );
                  },
                  itemCount: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
