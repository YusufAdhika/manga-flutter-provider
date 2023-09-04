import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:read_manga/data/repositories/manga_repository_impl.dart';
import 'package:read_manga/data/data_sources/manga_remote_data_source.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';
import 'package:read_manga/domain/usecases/get_manga.dart';
import 'package:read_manga/domain/usecases/get_manga_detail.dart';
import 'package:read_manga/domain/usecases/get_manga_recommended.dart';
import 'package:read_manga/domain/usecases/get_read_manga.dart';
import 'package:read_manga/domain/usecases/get_search.dart';
import 'package:read_manga/presentation/provider/manga_detail_notifier.dart';
import 'package:read_manga/presentation/provider/manga_list_notifier.dart';
import 'package:read_manga/presentation/provider/manga_list_recommended_nofier.dart';
import 'package:read_manga/presentation/provider/read_manga_notifier.dart';
import 'package:read_manga/presentation/provider/search_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MangaNotifier(getListManga: locator()),
  );
  locator.registerFactory(
    () => MangaDetailNotifier(getMangaDetail: locator()),
  );
  locator.registerFactory(
    () => MangaRecommendedNotifier(getMangaRecommend: locator()),
  );
  locator.registerFactory(
    () => ReadMangaNotifier(getReadManga: locator()),
  );
  locator.registerFactory(
    () => SearchNotifier(getSearch: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetListManga(locator()));
  locator.registerLazySingleton(() => GetMangaDetail(locator()));
  locator.registerLazySingleton(() => GetMangaRecommend(locator()));
  locator.registerLazySingleton(() => GetReadManga(locator()));
  locator.registerLazySingleton(() => GetSearch(locator()));

  // repository
  locator.registerLazySingleton<MangaRepository>(
    () => MangaRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MangaRemoteDataSource>(
      () => MangaRemoteDataSourceImpl(client: locator()));

  // helper
  // locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
