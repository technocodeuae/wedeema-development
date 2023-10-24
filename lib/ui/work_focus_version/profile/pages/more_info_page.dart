import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/app.dart';

import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../widget/items_ads_more_widget.dart';
import '../widget/items_user_more_widget.dart';

class MoreInfoPage extends StatefulWidget {
  static const routeName = '/MoreInfoPage';

   MoreInfoPage({Key? key,}) : super(key: key);
  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  final profileBloc = DIManager.findDep<ProfileCubit>();

  @override
  void initState() {
    profileBloc.getMoreInfoProfile();
  }
  bool isPressure = true;
  @override
  Widget build(BuildContext context) {
    Color primaryColor = AppColorsController().textPrimaryColor;
    Color blackColor = AppColorsController().black;

    return BlocConsumer<ProfileCubit, ProfileState>(

        bloc: profileBloc,
        listener: (_, state) {},
        builder: (context, state) {
          final getMoreInfoProfileState = state.getMoreInfoProfileState;

          if (getMoreInfoProfileState is BaseFailState) {
            return Column(
              children: [

                VerticalPadding(3.0),
                GeneralErrorWidget(
                  error: getMoreInfoProfileState.error,
                  callback: getMoreInfoProfileState.callback,
                ),
              ],
            );
          }

          if (getMoreInfoProfileState is GetMoreInfoProfileSuccessState) {

            final data = (state.getMoreInfoProfileState
                    as GetMoreInfoProfileSuccessState)
                .profile;
            return Column(
              children: [
                Row(

                  children: [
                    InkWell(
                      onTap: (){
                     setState(() {
                      isPressure =true;
                     });
                     print(isPressure);
                      },
                      child: Column(
                        children: [
                          Text(
                            translate("your_posts"),
                            style: AppStyle.lightSubtitle.copyWith(
                                color:  isPressure?primaryColor:Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            color:  isPressure?primaryColor:Colors.grey,
                            height: isPressure?1.5:1,
                          ),


                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        setState(() {
                        isPressure =false;
                        });
                        print(data.blocked_users);
                        print( data.favorite_ads);
                      },
                        child: Column(
                          children: [
                            Text(
                              translate("blocked_users") ,
                              style: AppStyle.lightSubtitle.copyWith(
                                  color: isPressure?blackColor:primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(width: MediaQuery.of(context).size.width/2,
                              color:  isPressure?Colors.grey:primaryColor,
                              height: !isPressure?1.5:1,
                            ),
                          ],
                        ),
                      ),


                  ],
                ),
                isPressure?Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 18.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ItemsAdsMoreWidget(
                        items: data.pending_ads,
                        title: translate("pending_posts"),
                      ),
                      ItemsAdsMoreWidget(
                        items: data.active_ads,
                        title: translate("active_posts"),
                      ),
                      ItemsAdsMoreWidget(
                        items: data.favorite_ads,
                        title: translate("favorites"),
                      ),


                    ],
                  ),
                ): Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 18.sp),
                  child: ItemsUserMoreWidget(
                    items: data.blocked_users,
                    title: translate("blocked_users"),
                  ),
                ),
                SizedBox(
                  height: 35.sp,
                ),
              ],
            );
          }
          return Container();
        });
  }
}

buildTabBar(){
  return Container(
    height: 400.sp,
    child: DefaultTabController( length: 2,

      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,shadowColor: Colors.white,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Calls",
              ),

            ],
          ),
        ),
        body: TabBarView(children: [
          Text('data 1'),
          Text('data 2'),

        ]),
      ),
    ),
  );
}

defaultBuildTabBar(context){
 Color primaryColor = AppColorsController().textPrimaryColor;
 Color blackColor = AppColorsController().black;
 bool isPressure = true;
  return Row(

    children: [
      InkWell(
        onTap: (){
          isPressure=!isPressure;
        },
        child: Column(
          children: [
            Text(
              translate("your_posts"),
              style: AppStyle.lightSubtitle.copyWith(
                  color:  isPressure?primaryColor:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
           Container(
             width: MediaQuery.of(context).size.width/2,
             color:  isPressure?primaryColor:Colors.black,
             height: 1,
           ),
          ],
        ),
      ),

      InkWell(
        onTap: (){
          isPressure=!isPressure;
        },
        child: Column(
          children: [
            Text(
              translate("blocked_users") ,
              style: AppStyle.lightSubtitle.copyWith(
                  color: !isPressure?primaryColor:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(width: MediaQuery.of(context).size.width/2,
              color:  !isPressure?primaryColor:Colors.black,
              height: 1,),
          ],
        ),
      ),

    ],
  );
}


buildModel(data){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          translate("your_posts") + ":",
          style: AppStyle.lightSubtitle.copyWith(
              color: AppColorsController().black,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 18.sp,
        ),
        ItemsAdsMoreWidget(
          items: data.pending_ads,
          title: translate("pending_posts") + ":",
        ),
        ItemsAdsMoreWidget(
          items: data.active_ads,
          title: translate("active_posts") + ":",
        ),
        ItemsAdsMoreWidget(
          items: data.favorite_ads,
          title: translate("favorites") + ":",
        ),
        SizedBox(
          height: 40.sp,
        ),
        Text(
          translate("your_activities") + ":",
          style: AppStyle.lightSubtitle.copyWith(
            color: AppColorsController().black,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 18.sp,
        ),
        // ItemsUserMoreWidget(
        //   items: data!.user_followers,
        //   title: translate("followers") + ":",
        // ),
        // ItemsUserMoreWidget(
        //   items: data.user_followings,
        //   title: translate("following") + ":",
        // ),
        // SizedBox(
        //   height: 40.sp,
        // ),
        Text(
          translate("setting_and_privacy") + ":",
          style: AppStyle.lightSubtitle.copyWith(
            color: AppColorsController().black,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 18.sp,
        ),
        ItemsUserMoreWidget(
          items: data.blocked_users,
          title: translate("blocked_users") + ":",
        ),
        SizedBox(
          height: 40.sp,
        ),
      ],
    ),
  );
}