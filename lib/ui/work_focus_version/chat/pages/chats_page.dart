import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/chat/chat_bloc.dart';
import '../../../../blocs/chat/states/chat_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../args/argument_message.dart';
import '../widget/main_page_chats.dart';
import 'chat_messages_page.dart';

class ChatsPage extends StatefulWidget {
  static const routeName = '/ChatPage';

  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final chatBloc = DIManager.findDep<ChatCubit>();

  List<MessagesEntity> data = [];

  bool isLoading = false;
  bool _isLoading = false;

  @override
  void initState() {
    chatBloc.getAllChats();
    isLoading = true;
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().card.withOpacity(0.8),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: LoadingColumnOverlay(
              isLoading: _isLoading,
              child: BackLongPress(

                child: Container(
                  child: Column(
                    children: [
                      AppBarWidget(
                        name: translate("chat"),
                        child: Container(
                          width: 26.sp,
                          height: 18.sp,
                        ),
                      ),
                      BlocConsumer<ChatCubit, ChatState>(
                          bloc: chatBloc,
                          listener: (_, state) {
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          builder: (context, state) {
                            final getAllChatState = state.getAllChatsState;

                            if (getAllChatState is BaseFailState) {
                              return Column(
                                children: [
                                  VerticalPadding(3.0),
                                  GeneralErrorWidget(
                                    error: getAllChatState.error,
                                    callback: getAllChatState.callback,
                                  ),
                                ],
                              );
                            }
                            if (isLoading == true && getAllChatState is GetAllChatsSuccessState) {
                              data =
                                  (state.getAllChatsState as GetAllChatsSuccessState)
                                      .massages;
                              return _buildBody();
                            }
                            return _buildBody();
                          })
                    ],
                  ),
                ),
              ),

            ),
          ),
          bottomNavigationBarWidget(indexPage: 1),
        ],
      ),
      // bottomSheet: bottomNavigationBarWidget(),
    );
  }

  _buildBody() {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: false,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print(data[index].ad_id);
                print(data[index].user_id_2);
                if(DIManager.findDep<SharedPrefs>().getUserID() == data[index].user_id_1.toString()){
                  print('000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
                }  else{
                  print('111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
                }
                DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
                    arguments: ArgumentMessage(
                        user_id_2: data[index].user_id_2,
                        ad_id: data[index].ad_id,));
              },
              child: MainPageChat(
                data: data[index],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.sp,
            );
          },
          itemCount: data.length),
    );
  }
}
