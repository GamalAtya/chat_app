import 'package:chat_app/features/auth/data/datasources/local_data_source.dart';
import 'package:chat_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chat_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/domain/usecases/signUp_user_usecase.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/home/data/data_sources/remote_data_source.dart';
import 'package:chat_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/network/network_info.dart';
import 'features/auth/domain/usecases/isLoggedIn_user_usecase.dart';
import 'features/auth/domain/usecases/signIn_user_usecase.dart';
import 'features/chat/domain/use_cases/get_chat_msg_use_case.dart';
import 'features/chat/domain/use_cases/send_msg_use_case.dart';
import 'features/chat/domain/use_cases/send_photo_msg_use_case.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/use_cases/LogOut_user_useCase.dart';
import 'features/home/domain/use_cases/get_user_chats_useCase.dart';
import 'features/home/domain/use_cases/get_users_data_use_case.dart';
import 'features/home/domain/use_cases/seach_users_by_email_use_case.dart';
import 'features/home/presentation/bloc/conversations_bloc/conversations_bloc.dart';
import 'features/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';

final sl = GetIt.instance;


Future<void> init() async {
  // feature - auth

  //bloc

  sl.registerFactory(() => AuthBloc(signUpUserUseCase: sl() , signInUserUseCase: sl(), isLoggedInUserUseCase: sl()));


  //useCases

  sl.registerLazySingleton(() => SignUpUserUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignInUserUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => IsLoggedInUserUseCase(authRepository: sl()));



  //repository
  
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl() , authRemoteDataSource: sl() , authLocalDataSource: sl()));

  //data source

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(auth: sl() , fireStore: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));

  // feature - home screen

  // bloc

  sl.registerFactory(() => HomeScreenBloc(searchUsersByEmailUseCase: sl() , getUserDataUseCase: sl() , logOutUserUseCase: sl()));
  sl.registerFactory(() => ConversationsBloc(getUserChatUseCase: sl() , getUserDataUseCase: sl()));

  // use case

  sl.registerLazySingleton(() => SearchUsersByEmailUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => GetUserDataUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => GetUserChatUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUserUseCase(sl()));

  //repos

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeRemoteDataSource: sl(), networkInfo: sl() , authLocalDataSource: sl()));


  // data sources

  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(fireStore: sl()));


  // chat
  // bloc

  sl.registerFactory(() => ChatBloc(sendMsgUseCase: sl() , getChatMsgUseCase: sl() , getUserDataUseCase: sl() , photoMsgUseCase: sl()));


  //use case

  sl.registerLazySingleton(() => SendMsgUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => GetChatMsgUseCase(chatRepository: sl()));
  sl.registerLazySingleton(() => SendPhotoMsgUseCase(chatRepository: sl()));

  // repo

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(chatRemoteDataSource: sl(), networkInfo: sl()));

  //data source

  sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(fireStore: sl()));


  //core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()) );


  //external

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final FirebaseAuth auth = FirebaseAuth.instance ;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance ;
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


}