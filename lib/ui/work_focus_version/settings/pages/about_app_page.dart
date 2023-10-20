import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/setting/settings_bloc.dart';
import '../../../../blocs/setting/states/settings_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';

class AboutAppPage extends StatefulWidget {
  static const routeName = '/AboutAppPage';

  const AboutAppPage({Key? key}) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  final settingsBloc = DIManager.findDep<SettingsCubit>();

  bool _isLoading = false;
  bool _isLoadingLoader = false;
  String data = "";

  @override
  void initState() {
    super.initState();
    settingsBloc.getAboutApp();
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
                name: translate("about_app"),
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
                            final settingsState = state.getAboutAppState;

                            if (settingsState is BaseFailState) {
                              return Column(
                                children: [
                                  VerticalPadding(3.0),
                                  GeneralErrorWidget(
                                    error: settingsState.error,
                                    callback: settingsState.callback,
                                  ),
                                ],
                              );
                            }

                            if (_isLoading == true&&(settingsState
                                is GetAboutAppStateSuccessState)) {
                              _isLoading = false;
                              data = settingsState.aboutApp.title!;
                              return _buildBody();
                            }
                            return data == "" ? Container() : _buildBody();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _buildBody() {
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
            data.toString(),
            style: AppStyle.verySmallTitleStyle.copyWith(
              color: AppColorsController().black,
              fontWeight: FontWeight.w400,
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
