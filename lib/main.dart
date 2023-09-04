import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/routes.dart';
import 'package:read_manga/common/utils.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/presentation/provider/manga_detail_notifier.dart';
import 'package:read_manga/presentation/provider/manga_list_notifier.dart';
import 'package:read_manga/presentation/provider/manga_list_recommended_nofier.dart';
import 'package:read_manga/presentation/provider/read_manga_notifier.dart';
import 'package:read_manga/presentation/pages/home_page.dart';
import 'package:read_manga/presentation/pages/read_list_manga_pager.dart';
import 'package:read_manga/presentation/pages/manga_detail_page.dart';
import 'package:read_manga/presentation/pages/manga_list_page.dart';
import 'package:read_manga/injection.dart' as di;
import 'package:read_manga/presentation/pages/manga_recommended_page.dart';
import 'package:read_manga/presentation/pages/read_manga_page.dart';
import 'package:read_manga/presentation/pages/search_page.dart';
import 'package:read_manga/presentation/provider/search_notifier.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MangaNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MangaRecommendedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MangaDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ReadMangaNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case listMangaRoute:
              return MaterialPageRoute(
                builder: (_) => const MangaListPage(),
              );
            case listMangaRecommendRoute:
              return MaterialPageRoute(
                builder: (_) => const MangaRecommendedPage(),
              );
            case searchManga:
              return MaterialPageRoute(
                builder: (_) => const SearchMangaPage(),
              );
            case detailMangaRoute:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => MangaDetailPage(id: id),
                settings: settings,
              );
            case readListMangaRoute:
              final manga = settings.arguments as MangaDetail;
              return MaterialPageRoute(
                builder: (_) => ReadListMangaPage(
                  manga: manga,
                ),
              );
            case readMangaRoute:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => ReadMangaPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
