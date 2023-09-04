import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_manga/common/constants.dart';
import 'package:read_manga/common/utils.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/presentation/notifier/manga_detail_notifier.dart';
import 'package:read_manga/presentation/notifier/manga_list_notifier.dart';
import 'package:read_manga/presentation/notifier/manga_list_recommended_nofier.dart';
import 'package:read_manga/presentation/notifier/read_manga_notifier.dart';
import 'package:read_manga/presentation/pages/home_page.dart';
import 'package:read_manga/presentation/pages/list_read_manga_pager.dart';
import 'package:read_manga/presentation/pages/manga_detail_page.dart';
import 'package:read_manga/presentation/pages/manga_list_page.dart';
import 'package:read_manga/injection.dart' as di;
import 'package:read_manga/presentation/pages/manga_recommended_page.dart';
import 'package:read_manga/presentation/pages/read_manga_page.dart';

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
            case MangaListPage.route:
              return MaterialPageRoute(
                builder: (_) => const MangaListPage(),
              );
            case MangaRecommendedPage.route:
              return MaterialPageRoute(
                builder: (_) => const MangaRecommendedPage(),
              );
            case ListReadMangaPage.route:
              final manga = settings.arguments as MangaDetail;
              return MaterialPageRoute(
                builder: (_) => ListReadMangaPage(
                  manga: manga,
                ),
              );
            case MangaDetailPage.route:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => MangaDetailPage(id: id),
                settings: settings,
              );
            case ReadMangaPage.route:
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
