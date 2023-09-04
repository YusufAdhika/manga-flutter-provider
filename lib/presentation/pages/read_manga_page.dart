import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/presentation/notifier/read_manga_notifier.dart';

class ReadMangaPage extends StatefulWidget {
  static const route = 'chapter';
  const ReadMangaPage({super.key, required this.id});

  final String id;

  @override
  State<ReadMangaPage> createState() => _ReadMangaPageState();
}

class _ReadMangaPageState extends State<ReadMangaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ReadMangaNotifier>(context, listen: false)
          ..fetchListReadManga(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Consumer<ReadMangaNotifier>(builder: (context, data, child) {
                    final state = data.readMangaState;
                    if (state == RequestState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state == RequestState.loaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var manga = data.readListManga[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: manga.chapterImageLink,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                        itemCount: data.readListManga.length,
                      );
                    } else {
                      return const Text('Failed');
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: kRichBlack,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
