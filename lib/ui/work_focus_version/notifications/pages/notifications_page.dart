import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_font.dart';
import '../../../../blocs/notifications/notifications_bloc.dart';
import '../../../../blocs/notifications/states/notifications_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/notifications/entity/notifications_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/list_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/arg/items_args.dart';
import '../../home/pages/items_details_page.dart';
import '../../profile/pages/client_account_page.dart';

class NotificationsPage extends StatefulWidget {
  static const routeName = '/NotificationsPage';

  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notificationsBloc = DIManager.findDep<NotificationsCubit>();

  List<ItemsNotificationsEntity> data = [];

  bool _isLoading = false;
  bool _isLoadingLodar = false;
  bool _isLoadingRead = false;
  bool _isLoadingDelete = false;

  @override
  void initState() {
    super.initState();
    notificationsBloc.getAllNotifications();
    _isLoading = true;
    _isLoadingLodar = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: LoadingColumnOverlay(
      isLoading: _isLoadingLodar,
      child: BackLongPress(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(
              name: translate("notifications"),
              child: InkWell(
                onTap: () {
                  DIManager.findNavigator().pop();
                },
                child: BackIcon(
                  width: 26.sp,
                  height: 18.sp,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    BlocConsumer<NotificationsCubit, NotificationsState>(
                        bloc: notificationsBloc,
                        listener: (_, state) {
                          setState(() {
                            _isLoadingLodar = false;
                          });
                        },
                        builder: (context, state) {
                          final getNotificationsState = _isLoadingRead == true
                              ? state.readNotificationState
                              : _isLoadingDelete == true? state.removeNotificationState:state.getAllNotificationsState;

                          if (getNotificationsState is BaseFailState) {
                            return Column(
                              children: [
                                VerticalPadding(3.0),
                                GeneralErrorWidget(
                                  error: getNotificationsState.error,
                                  callback: getNotificationsState.callback,
                                ),
                              ],
                            );
                          }

                          if (_isLoading &&
                              (getNotificationsState
                                  is GetAllNotificationsSuccessState)) {
                            data = (state.getAllNotificationsState
                                    as GetAllNotificationsSuccessState)
                                .notifications;
                            _isLoading = false;
                            return _buildBody();
                          }

                          if (_isLoadingRead &&
                              (getNotificationsState
                                  is ReadNotificationSuccessState)) {
                            _isLoadingRead = false;
                            return _buildBody();
                          }

                          if (_isLoadingDelete &&
                              (getNotificationsState
                              is RemoveNotificationSuccessState)) {
                            _isLoadingDelete = false;
                            return _buildBody();
                          }

                          return Container(
                            child: _buildBody(),
                          );
                        }),
                    SizedBox(
                      height: 30.sp,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),),),
      bottomSheet: bottomNavigationBarWidget(),
    );
  }

  _buildBody() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16.sp),
            margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            decoration: BoxDecoration(
              color: data[index].read == 0
                  ? AppColorsController().greyBackground
                  : AppColorsController().containerPrimaryColor,
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.dialogBorderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    notificationsBloc.readNotifications(data[index].id!);
                    _isLoadingRead = true;
                    _isLoadingLodar = true;
                    setState(() {
                      data[index].read = 1;
                    });
                    if (data[index].type == "Evaluation User" ||
                        data[index].type == "Follow") {
                      DIManager.findNavigator()
                          .pushNamed(ClientAccountPage.routeName,
                          arguments: data[index]?.user_id!);
                    }
                    else{
                      DIManager.findNavigator().pushNamed(
                        ItemsDetailsPage.routeName,
                        arguments: ItemsArgs(
                          id: data![index].ad_id,
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].title.toString(),
                        style: AppStyle.lightSubtitle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // SizedBox(
                      //   height: 8.sp,
                      // ),
                      // Text(
                      //   data[index].message.toString(),
                      //   style: AppStyle.lightSubtitle.copyWith(
                      //     color: AppColorsController().black,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      data[index].body!.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 8.sp,
                                ),
                                Container(
                                  width: 250.sp,
                                  child: Text(
                                    data[index].body.toString(),
                                    style: AppStyle.lightSubtitle.copyWith(
                                      color: AppColorsController().black,
                                      fontWeight: FontWeight.w400,fontSize: AppFontSize.fontSize_11,

                                    ),
                                    overflow: TextOverflow.ellipsis,maxLines: 4,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: PopupMenuButton(
                    color: AppColorsController().white,
                    child: ListIcon(), // Use a specific widget
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(

                        child: Text(
                          translate("delete"),
                          style: AppStyle.lightSubtitle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        value: 'delete',
                      ),
                    ],
                    onSelected: (value) {
                      if (value == "delete") {
                        notificationsBloc.removeNotifications(data[index].id!);
                        _isLoadingDelete = true;
                        setState(() {
                          _isLoadingLodar = true;
                        });
                        data.removeAt(index);
                      }
                      // Handle menu item selection here
                    },
                  ),
                ),

              ],
            ),
          );
        },
        itemCount: data.length);
  }
}
