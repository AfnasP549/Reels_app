import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:reels_app/features/data/datasources/api_service.dart';
import 'package:reels_app/features/data/repositories/reels_repository_impl.dart';
import 'package:reels_app/features/repositories/reels_repository.dart';
import 'package:reels_app/features/domain/usecase/fetch_reels.dart';
import 'package:reels_app/features/presentation/bloc/reels_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies()async{
  //! HTTP Client
  getIt.registerLazySingleton(()=>http.Client());

  //! Data Sources
  getIt.registerLazySingleton<ApiService>(()=> RemoteDataSourceImpl(client: getIt()));

  //!Repositories
  getIt.registerLazySingleton<ReelsRepository>(()=> ReelsRepositoryImpl(apiService: getIt()));

  //!usecase
  getIt.registerLazySingleton(()=> FetchReels(getIt()));

  //!bloc
  getIt.registerFactory(()=> ReelsBloc(fetchReels: getIt()));
  
}