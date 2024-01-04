import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/profile/entity/profile_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/arg/following_args.dart';
import '../../home/widget/app_bar_app.dart';
import '../../home/widget/build_circular_image_user.dart';
import 'client_account_page.dart';

class FollowFollowerBlockUser extends StatefulWidget {
  final FollowingArgs? followingArgs;
  static const routeName = '/FollowFollowerBlockUser';

  const FollowFollowerBlockUser({Key? key, this.followingArgs})
      : super(key: key);

  @override
  State<FollowFollowerBlockUser> createState() =>
      _FollowFollowerBlockUserState();
}

class _FollowFollowerBlockUserState extends State<FollowFollowerBlockUser> {
  final profileBloc = DIManager.findDep<ProfileCubit>();
  int page = 1;
  List<ItemsUserEntity> items = [];

  bool loading = false;
  bool loadingLoader = false;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    loadingLoader = false;
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loading = true;
    items = [];
    if (widget.followingArgs?.userId == -1) {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getALLFollowers(page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getALLFollowings(page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getALLBlockers(page);
        loading = true;
      }
    } else {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getOtherFollowers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getOtherFollowings(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getOtherBlockers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      }
    }


    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 30));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page++;


    if (widget.followingArgs?.userId == -1) {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getALLFollowers(page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getALLFollowings(page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getALLBlockers(page);
        loading = true;
      }
    } else {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getOtherFollowers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getOtherFollowings(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getOtherBlockers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      }
    }

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }


  @override
  void initState() {
    super.initState();
    loadingLoader = true;
    if (widget.followingArgs?.userId == -1) {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getALLFollowers(page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getALLFollowings(page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getALLBlockers(page);
        loading = true;
      }
    } else {
      if (widget.followingArgs?.action == 0) {
        profileBloc.getOtherFollowers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 1) {
        profileBloc.getOtherFollowings(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      } else if (widget.followingArgs?.action == 2) {
        profileBloc.getOtherBlockers(widget.followingArgs?.userId ?? 0, page);
        loading = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: appBarApp(context,
          text: widget.followingArgs?.action == 0
              ? translate("followers")
              : widget.followingArgs?.action == 1
              ? translate("following")
              : translate(
              "blocked_users"),
          isNeedBack: true
      ),
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: loadingLoader,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BackLongPress(

                child: Column(
                  children: [
                    // AppBarWidget(
                    //   name: widget.followingArgs?.action == 0 ? translate("followers") : widget
                    //       .action == 1 ? translate("following") : translate(
                    //       "blocked_users"),
                    //   child: InkWell(
                    //     onTap: (){
                    //       Navigator.of(context).pop();
                    //     },
                    //     child: BackIcon(
                    //       width: 26.sp,
                    //       height: 18.sp,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 16.sp,
                    // ),
                    Expanded(
                      child: Container(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          scrollDirection: Axis.vertical,
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          header: ClassicHeader(
                            refreshingIcon: Container(
                                width: 20.sp,
                                height: 20.sp,
                                child: CircularProgressIndicator(
                                  color: AppColorsController().buttonRedColor,
                                  strokeWidth: 1.5,)),
                            idleIcon: Center(child: Icon(Icons.arrow_downward,
                              color: AppColorsController().buttonRedColor,),),
                            completeIcon: Center(child: Icon(Icons.check,
                              color: AppColorsController().buttonRedColor,
                              size: 30.sp,),),
                            releaseIcon: Center(child: Icon(
                              Icons.change_circle_sharp,
                              color: AppColorsController().buttonRedColor,
                              size: 30.sp,),),
                            completeText: "",
                            refreshingText: "",
                            textStyle: TextStyle(
                                color: AppColorsController().white),
                          ),
                          footer: ClassicFooter(
                            height: 80,
                            noMoreIcon: Center(child: Icon(Icons.arrow_upward,
                              color: AppColorsController().buttonRedColor,),),
                            idleIcon: Center(child: Icon(Icons.arrow_upward,
                              color: AppColorsController().buttonRedColor,),),
                            loadingIcon: Container(
                                width: 20.sp,
                                height: 20.sp,
                                child: CircularProgressIndicator(
                                  color: AppColorsController().buttonRedColor,
                                  strokeWidth: 1.5,)),
                            canLoadingIcon: Center(child: Icon(
                              Icons.change_circle_sharp,
                              color: AppColorsController().buttonRedColor,
                              size: 30.sp,),),
                            canLoadingText: "",
                            loadingText: "",
                            textStyle: TextStyle(
                                color: AppColorsController().white),
                          ),
                          onLoading: _onLoading,
                          child: BlocConsumer<ProfileCubit, ProfileState>(
                            bloc: profileBloc,
                            listener: (context, state) {
                              setState(() {
                                loadingLoader = false;
                              });
                            },
                            builder: (context, state) {
                              print("Here" + state.toString());

                              final profileState = widget.followingArgs
                                  ?.action == 0 &&
                                  widget.followingArgs?.userId == -1
                                  ? state.getALLFollowersState
                                  : widget.followingArgs?.action == 1 &&
                                  widget.followingArgs?.userId == -1
                                  ? state.getALLFollowingsState : widget
                                  .followingArgs?.action == 0 &&
                                  widget.followingArgs?.userId != -1 ? state
                                  .getOthersFollowersState : widget
                                  .followingArgs?.action == 1 &&
                                  widget.followingArgs?.userId != -1 ? state.getOthersFollowingsState:
                              widget.followingArgs?.userId != -1? state.getOthersBlockersState:
                              state
                                  .getALLBlockersState;

                              print("Here" + profileState.toString());
                              if (profileState is BaseFailState) {
                                return Column(
                                  children: [
                                    VerticalPadding(3.0),
                                    GeneralErrorWidget(
                                      error: profileState.error,
                                      callback: profileState.callback,
                                    ),
                                  ],
                                );
                              }


                              if (widget.followingArgs?.userId == -1) {
                                if (loading == true &&
                                    widget.followingArgs?.action == 0 &&
                                    (profileState is GetALLFollowersSuccessState)) {
                                  final data = (state.getALLFollowersState
                                  as GetALLFollowersSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                } else if (loading &&
                                    widget.followingArgs?.action == 1 &&
                                    (profileState is GetALLFollowingsSuccessState)) {
                                  final data = (state.getALLFollowingsState
                                  as GetALLFollowingsSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                  return _buildBody();
                                }
                                else if (loading &&
                                    widget.followingArgs?.action == 2 &&
                                    profileState is GetALLBlockersSuccessState) {
                                  final data = (state.getALLBlockersState
                                  as GetALLBlockersSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                  return _buildBody();
                                }
                              } else {
                                if (loading == true &&
                                    widget.followingArgs?.action == 0 &&
                                    (profileState is GetOthersFollowersSuccessState)) {
                                  final data = (state.getOthersFollowersState
                                  as GetOthersFollowersSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                } else if (loading &&
                                    widget.followingArgs?.action == 1 &&
                                    (profileState is GetOthersFollowingsSuccessState)) {
                                  final data = (state.getOthersFollowingsState
                                  as GetOthersFollowingsSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                  return _buildBody();
                                }
                                else if (loading &&
                                    widget.followingArgs?.action == 2 &&
                                    profileState is GetOthersBlockersSuccessState) {
                                  final data = (state.getOthersBlockersState
                                  as GetOthersBlockersSuccessState)
                                      .users;
                                  items.addAll(data.data!);
                                  loading = false;
                                  return _buildBody();
                                }
                              }

                              return _buildBody();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.sp,),
                  ],
                ),
              ),
              loadingLoader ? Container() : bottomNavigationBarWidget(
                  indexPage: 4),
            ],
          ),
        ),),
      // bottomSheet: bottomNavigationBarWidget(),

    );
  }

  _buildBody() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            DIManager.findNavigator().pushNamed(
              ClientAccountPage.routeName,
              arguments: items![index].id,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColorsController().containerPrimaryColor,
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens.containerBorderRadius,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 18.sp),
            margin: EdgeInsets.symmetric(horizontal: 32.sp,),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildCircularImageUser(
                  url: items![index].profile_pic,
                  size: 38.sp,
                ),
                SizedBox(width: 8.sp,),
                Text(
                  items[index].user_name.toString(),
                  style: AppStyle.lightSubtitle.copyWith(
                    color: AppColorsController().black,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: items!.length!,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8.sp,
        );
      },
    );
  }
}
