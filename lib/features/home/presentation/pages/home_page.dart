import 'package:chat_app/core/colors/colors.dart';
import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chat_app/features/home/presentation/bloc/conversations_bloc/conversations_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../notifications.dart';
import '../bloc/home_screen_bloc/home_screen_bloc.dart';
import 'contacts_screen.dart';
import 'conversation_screen.dart';
import 'menu_screen.dart';
import '../../../../injection_container.dart' as di;

const List<Widget> screens = [
  ContactsScreen(),
  ConversationScreen(),
  MenuScreen()
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                di.sl<HomeScreenBloc>()..add(const GetUserDataEvent())),
        BlocProvider<ConversationsBloc>(
            create: (context) =>
                di.sl<ConversationsBloc>()..add(GetUserChatsEvent())),
      ],
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: screens.elementAt(state.tabIndex),
            bottomNavigationBar: Container(
              color: AppColors.white,
              height: context.screenHeight * 0.1,
              child: BottomNavigationBar(
                currentIndex: state.tabIndex,
                backgroundColor: AppColors.white,
                elevation: 24.0,
                onTap: (i) =>
                    context.read<HomeScreenBloc>().add(ChangeHomeTabEvent(i)),
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppStrings.usersIcon),
                      activeIcon: Column(
                        children: [
                          SvgPicture.asset(AppStrings.usersIcon),
                          activeBottomDot()
                        ],
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: conversationsBottomWidget(),
                      activeIcon: Column(
                        children: [
                          conversationsBottomWidget(),
                          activeBottomDot()
                        ],
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppStrings.menuIcon),
                      activeIcon: Column(
                        children: [
                          SvgPicture.asset(AppStrings.menuIcon),
                          activeBottomDot()
                        ],
                      ),
                      label: ""),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LogOutState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const SignInPage()));
          }
        },
      ),
    );
  }

  Widget conversationsBottomWidget() => Text(AppStrings.conversations,
      style: TextStyle(
          fontSize: 18,
          color: AppColors.black,
          fontFamily: AppStrings.boldFontFamily,
          fontWeight: FontWeight.w600));

  Widget activeBottomDot() => Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
        child: Container(
          width: 4,
          height: 4,
          decoration:
              BoxDecoration(color: AppColors.black, shape: BoxShape.circle),
        ),
      );
}
