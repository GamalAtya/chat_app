import 'package:chat_app/core/extensions/context.dart';
import 'package:chat_app/core/strings/app_strings.dart';
import 'package:chat_app/core/widgets/loading_widget.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/home/domain/entities/chat.dart';
import 'package:chat_app/features/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/contants/consts.dart';
import '../widgets/chat_list_tile_widget.dart';
import '../widgets/home_screen_app_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeScreenAppBar(title: AppStrings.contacts,),
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Container(
                width: context.screenWidth * 0.872,
                height: context.screenHeight * 0.05,
                decoration: BoxDecoration(
                    color: AppColors.highlightColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: TextFormField(
                  onChanged: (email) =>
                      context.read<HomeScreenBloc>().add(
                          SearchUserByEmailEvent(email)),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: AppStrings.regularFontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0.0, 0),
                        child: Icon(
                          Icons.search, size: 25, color: AppColors.grey,),
                      ),
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(
                          3, 0, AppConstants.outerPadding, 10),
                      enabledBorder: InputBorder.none,
                      hintText: "Search Users by Email",
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                      )
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                if(state is HomeScreenLoading)
                  {
                    return SizedBox(
                      height: context.screenHeight * 0.59,
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                if(state is SearchUserByEmailState){
                  final user = state.user ;
                return SizedBox(
                    height: context.screenHeight * 0.59,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ChatPage(receiver: state.user , chatId: null,)));
                      },
                      child: ChatListTile(
                        userName: user.displayName ?? "",
                        date: "",
                        lastMessage: "",
                        seen: false,
                        hideSeen: true,
                      ),
                    )
                );}
                else{
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
