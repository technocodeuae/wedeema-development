import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/setting/states/settings_state.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/setting/settings_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/settings/entity/settings_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';

class FAQPage extends StatefulWidget {
  static const routeName = '/FAQPage';

  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final settingsBloc = DIManager.findDep<SettingsCubit>();

  List<ItemsFaqEntity> data = [];

  bool _isLoading = false;
  bool _isLoadingLoader = false;

  int page = 1;



  @override
  void initState() {
    super.initState();
    settingsBloc.getFAQ(page);
    _isLoading = true;
    _isLoadingLoader = true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: _isLoadingLoader,
          child: BackLongPress(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  name: translate("faq"),
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
                    child: Column(
                      children: [
                        BlocConsumer<SettingsCubit, SettingsState>(
                            bloc: settingsBloc,
                            listener: (_, state) {
                              setState(() {
                                _isLoadingLoader = false;
                              });
                            },
                            builder: (context, state) {
                              final getFAQState = state.getFAQState;

                              if (getFAQState is BaseFailState) {
                                return Column(
                                  children: [
                                    VerticalPadding(3.0),
                                    GeneralErrorWidget(
                                      error: getFAQState.error,
                                      callback: getFAQState.callback,
                                    ),
                                  ],
                                );
                              }

                              if (_isLoading &&
                                  (getFAQState is GetFAQStateSuccessState)) {
                                data.addAll(
                                    (state.getFAQState as GetFAQStateSuccessState)
                                        .faq
                                        .data!);
                                _isLoading = false;
                                return _buildBody();
                              }

                              return _buildBody();
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
          ),
        ),
      ),
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
              color: AppColorsController().containerPrimaryColor,
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.dialogBorderRadius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index].question.toString(),
                  style: AppStyle.lightSubtitle.copyWith(
                    color: AppColorsController().black,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: null,
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Text(
                  data[index].answer.toString(),
                  style: AppStyle.lightSubtitle.copyWith(
                    color: AppColorsController().black,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: null,
                ),
              ],
            ),
          );
        },
        itemCount: data.length);
  }
}
