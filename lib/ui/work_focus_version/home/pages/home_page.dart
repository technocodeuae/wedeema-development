import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wadeema/core/constants/app_assets.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';

import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../blocs/setting/settings_bloc.dart';
import '../../../../blocs/setting/states/settings_state.dart';
import '../../../../blocs/sponsors/sponsors_bloc.dart';
import '../../../../blocs/sponsors/states/sponsors_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../../../map/map_screen.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../profile/pages/client_account_page.dart';
import '../arg/items_args.dart';
import '../widget/build_items_widget.dart';
import '../widget/build_looking_widget.dart';
import '../widget/looking_widget_shimmer.dart';
import '../widget/search_app_bar.dart';
import 'items_details_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = new TextEditingController();

  @override
  bool get wantKeepAlive => true;

  List<String> imgList = [
    AppAssets.pencilIcon,
    AppAssets.accountIcons,
    AppAssets.addIcons
  ];
  final bottomSheetKey = PageStorageKey('bottomSheet');

  final sponsorBloc = DIManager.findDep<SponsorsCubit>();
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  final settingsBloc = DIManager.findDep<SettingsCubit>();

  bool isLoadingSponsor = true;
  bool isLoadingCategories = true;

  List<String> dataShimmer = ["1","2","3"];
  List<CategoriesEntity> categories = [];

  @override
  void initState() {
    initUniLinks();
    isLoadingCategories = true;
    isLoadingSponsor = true;
    _getData();
  }

  Future<void> _getData() async {
    categoriesBloc.getMainCategories();
    await sponsorBloc.getSponsors();
  }

  void processIncomingLink(String url) {
    // Process the incoming URL
    print('Incoming URL: $url');
    settingsBloc.getShareLink(url);
  }

  void initUniLinks() async {
    // Check if the app was launched from a deep link
    try {
      // Listen for incoming links
      final initialLink = await getInitialLink();

      // processIncomingLink(initialLink ?? "");

      getUriLinksStream().listen((Uri? uri) {
        if (uri?.path != "https://wadeema.syria5.com/api/mobile/")
          processIncomingLink(uri.toString());
        // handleDeepLink(uri!.path);
      });
    } on PlatformException {
      // Handle exception if unable to retrieve initial link
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // call super

    return Scaffold(
      backgroundColor: AppColorsController().whiteBackground,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: BlocListener<SettingsCubit, SettingsState>(
              bloc: settingsBloc,
              listener: (context, state) {
                final settingsState = state.getShareLinkState;
                if (settingsState is BaseFailState) {}

                if (settingsState is GetShareLinkStateSuccessState) {
                  final data =
                      (state.getShareLinkState as GetShareLinkStateSuccessState)
                          .shareLink;
                  if (data.user != null) {
                    DIManager.findNavigator().pushNamed(ClientAccountPage.routeName,
                        arguments: data.user?.id!);
                  } else {
                    DIManager.findNavigator().pushNamed(ItemsDetailsPage.routeName,
                        arguments: ItemsArgs(
                          id: data!.ad?.ad_id,categoryId: data!.ad?.category_id??0
                        ));
                  }
                }
              },
              child: Stack(
                children: [
                  Container(
                    child: SearchAppBarWidget(
                      controller: searchController,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 105.sp),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: RefreshIndicator(
                           color: AppColorsController().buttonRedColor,
                            backgroundColor: AppColorsController().defaultPrimaryColor,
                            onRefresh: () => Future(()  {
                              return Future.delayed(Duration(seconds: 1))..then((value) {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

                              });
                                 // return  _getData();

                            }),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  BlocConsumer<SponsorsCubit, SponsorsState>(
                                    bloc: sponsorBloc,
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      final sponsorsState = state.getSponsorsState;

                                      if (sponsorsState is BaseFailState) {
                                        return Column(
                                          children: [
                                            VerticalPadding(3.sp),
                                            GeneralErrorWidget(
                                              error: sponsorsState.error,
                                              callback: sponsorsState.callback,
                                            ),
                                          ],
                                        );
                                      }

                                      if (sponsorsState is SponsorsSuccessState) {
                                        final data = (state.getSponsorsState
                                                    as SponsorsSuccessState)
                                                .sponsor ??
                                            [];
                                        isLoadingSponsor = false;
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 136.sp,
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              viewportFraction: 0.6,
                                              // Display three items at a time
                                              aspectRatio: 3,
                                              enlargeCenterPage: true,
                                            ),
                                            items: data
                                                .map((item) => Container(
                                                      width: 274.sp,
                                                      height: 136.sp,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(15.sp)),
                                                        child: Container(
                                                          color: AppColorsController()
                                                              .scaffoldBGColor,
                                                          child: Image.network(
                                                            AppConsts.IMAGE_URL +
                                                                item.image.toString(),
                                                            fit: BoxFit.fill,
                                                            width: 274.sp,
                                                            height: 136.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        );
                                      }
                                      return isLoadingSponsor == true?Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 136.sp,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            viewportFraction: 0.6,
                                            // Display three items at a time
                                            aspectRatio: 3,
                                            enlargeCenterPage: true,
                                          ),

                                          items: dataShimmer
                                              .map((item) => Container(
                                            width: 274.sp,
                                            height: 136.sp,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.sp)),
                                              child: Container(
                                                color: AppColorsController()
                                                    .scaffoldBGColor,
                                                child: Shimmer.fromColors(
                                                  baseColor: Color(0x99FED0D3),
                                                  highlightColor: Color(0x99DE0F17),
                                                  child: Container(
                                                    width: 90.sp,
                                                    height: 90.sp,
                                                    color: Colors.amberAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                        ),
                                      ):Container();
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        BlocConsumer<CategoriesCubit, CategoriesState>(
                                          bloc: categoriesBloc,
                                          listener: (context, state) {},
                                          builder: (context, state) {
                                            final categoriesState =
                                                state.getMainCategoriesState;
                                            if (categoriesState is BaseFailState) {
                                              return Column(
                                                children: [

                                                  VerticalPadding(3.sp),
                                                  // SizedBox(height: MediaQuery.of(context).size.height/6,),
                                                  GeneralErrorWidget(
                                                    error: categoriesState.error,
                                                    callback: categoriesState.callback,
                                                  ),
                                                ],
                                              );
                                            }

                                            if (isLoadingCategories == true &&
                                                categoriesState
                                                    is GetMainCategoriesSuccessState) {
                                               categories = (state.getMainCategoriesState
                                                      as GetMainCategoriesSuccessState)
                                                  .categories;
                                              isLoadingCategories = false;
                                              return Column(
                                                children: [
                                                  BuildLookingWidget(
                                                    name: translate(
                                                        "are_you_looking_for"),
                                                    lookingList: categories
                                                  ),
                                                  SizedBox(height: 4.sp),
                                                ],
                                              );
                                            }
                                            return (isLoadingCategories == true)
                                                ? LookingWidgetShimmer(
                                             name: translate(
                                                  "are_you_looking_for"),
                                            )
                                                : Column(
                                              children: [
                                                BuildLookingWidget(
                                                  name: translate(
                                                      "are_you_looking_for"),
                                                  lookingList: categories,
                                                ),
                                                SizedBox(height: 4.sp),
                                              ],
                                            );
                                          },
                                        ),
                                        Column(
                                          children: [
                                            BuildItemsWidget(
                                              name: translate("recent_uploaded_items"),
                                              type: 0,
                                            ),
                                            BuildItemsWidget(
                                              name: translate("most_rate_items"),
                                              type: 1,
                                            ),
                                            BuildItemsWidget(
                                              name: translate("popular_items"),
                                              type: 2,
                                            ),
                                            BuildItemsWidget(
                                              name: translate("job_ads"),
                                              type: 3,
                                              category_id: AppConsts.jobCategoryId,
                                            ),
                                            SizedBox(
                                              height: Platform.isIOS?  15.h:35.h,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBarWidget(
            key: bottomSheetKey,
            indexPage: 0,
          )
        ],
      ),
      // bottomNavigationBar: bottomNavigationBarWidget(
      //   key: bottomSheetKey,
      // ),
    );
  }
}
