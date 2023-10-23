import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/blocs/categories/states/categories_state.dart';
import 'package:wadeema/blocs/upload_ads/states/upload_ads_state.dart';
import 'package:wadeema/blocs/upload_ads/upload_ads_bloc.dart';
import 'package:wadeema/core/bloc/states/base_fail_state.dart';
import 'package:wadeema/core/bloc/states/base_wait_state.dart';
import 'package:wadeema/core/enums/property_type_enum.dart';
import 'package:wadeema/core/utils/file_manager.dart';
import 'package:wadeema/core/utils/string_utils/string_utils.dart';
import 'package:wadeema/core/utils/ui/loader/app_loader_widget.dart';
import 'package:wadeema/core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import 'package:wadeema/core/utils/ui/widgets/general_error_widget.dart';
import 'package:wadeema/core/utils/ui/widgets/utils/vertical_padding.dart';
import 'package:wadeema/data/models/categories/entity/categories_entity.dart';
import 'package:wadeema/data/models/properties/entity/properties_entity.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/divider_item.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/drop_down_widget.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/option_item.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/privacy_widget.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/sub_categories_drop_down.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/type_item_widget.dart';
import 'package:wadeema/ui/work_focus_version/home/arg/view_all_args.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/home_page.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/view_all_page.dart';

import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/app_general_utils.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../map/map_screen.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/text_fields/text_field_widget.dart';
import '../args/argument_category.dart';
import '../args/argument_policy.dart';
import '../widget/cities_drop_down.dart';
import '../widget/post_ad_button.dart';
import 'choose_listing_page.dart';

class AddMainDetailsPage extends StatefulWidget {
  static const routeName = '/AddMainDetailsPage';
  final ArgumentCategory? argumentCategory;

  const AddMainDetailsPage({Key? key, this.argumentCategory}) : super(key: key);

  @override
  State<AddMainDetailsPage> createState() => _AddMainDetailsPageState();
}

class _AddMainDetailsPageState extends State<AddMainDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  List<File> images = [];
  dynamic selectedLocation;

  List<PropertiesEntity> data = [];

  Map<String, FocusNode> focusNodes = {};

  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  final ads = DIManager.findDep<UploadAdsCubit>();

  int fieldIndex = 0;
  double paddingBottom = 0;

  bool _isFilter() => widget.argumentCategory?.dataMap?["filter"] == true;

  late StreamSubscription<bool> keyboardSubscription;
  var keyboardVisibilityController = KeyboardVisibilityController();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      paddingBottom = visible ? MediaQuery.of(context).viewInsets.bottom : 0;
      setState(() {});
      // Future.delayed(Duration(seconds: 1)).then((value) {
      if (visible) {
        _scrollController.animateTo(
            _scrollController.offset + paddingBottom - 100,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
      // });
    });

    _initData();
  }

  void _initData() {
    categoriesBloc.clear();
    widget.argumentCategory?.dataMap?['subcategory_names'] = null;
    widget.argumentCategory?.dataMap?['sub_category_ids'] = null;
    categoriesBloc.getPropertiesCategories(widget.argumentCategory?.id ?? 0);
    if (widget.argumentCategory?.list?.isEmpty ?? true) {
      categoriesBloc.getMainCategories(
          withEmit: false,
          onDone: () {
            setState(() {});
          });

    }
    _controller.addListener(_updateCharCount);
  }
  void _updateCharCount() {
    setState(() {
      charCount = _controller.text.length; // عد الأحرف في النص
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoriesBloc.clear();
    _controller.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int maxWordCount = 5; // تحديد الحد الأقصى لعدد الكلمات
  int charCount = 0; // متغير لتخزين عدد الأحرف

  int wordCount = 0;
////
  void _updateWordCount() {
    final words = _controller.text.split(' ');
    wordCount = words.length;
  }

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().whiteBackground,
      body: BackLongPress(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10.sp,
              ),
              AppBarWidget(
                flip: true,
                name: translate(_isFilter() ? 'filter' : "place_ads"),
                child: InkWell(
                  onTap: () {
                    if (_isFilter()) {
                      DIManager.findNavigator().pop();
                    } else {
                      if (!AppUtils.checkIfGuest(context)) {
                        DIManager.findNavigator().pushReplacementNamed(
                            SelectListingPage.routeName,
                            arguments: {'city_id': -1});
                      }
                    }
                  },
                  child: BackIcon(
                    width: 26.sp,
                    height: 18.sp,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  bloc: categoriesBloc,
                  builder: (context, state) {
                    final getCategoriesState = state.getPropertiesCategories;

                    if (getCategoriesState is BaseFailState) {
                      return Column(
                        children: [
                          VerticalPadding(3.0),
                          GeneralErrorWidget(
                            error: getCategoriesState.error,
                            callback: getCategoriesState.callback,
                          ),
                        ],
                      );
                    } else if (getCategoriesState
                        is GetPropertiesCategoriesSuccessState) {
                      data = (state.getPropertiesCategories
                              as GetPropertiesCategoriesSuccessState)
                          .propertiesCategories;

                      return SingleChildScrollView(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 700.sp,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                controller: _scrollController,
                                child: Column(
                                  children: [
                                    CitiesDropdownWidget(
                                      child: OptionItem(
                                          title: translate('emirate'),
                                          subtitle: widget.argumentCategory
                                                  ?.dataMap?['city_name'] ??
                                              '',
                                          onClick: () {}),
                                      selectedCity: widget.argumentCategory
                                              ?.dataMap?['city_id'] ??
                                          -1,
                                      // selectedProperties: ,
                                      onSelected: (value) {
                                        widget.argumentCategory
                                            ?.dataMap?['city_id'] = value?.id;
                                        widget.argumentCategory
                                                ?.dataMap?['city_name'] =
                                            value?.title;
                                        categoriesBloc.refresh();
                                      },
                                    ),

                                    SubCategoriesDropdownWidget(
                                      child: OptionItem(
                                          title: translate('category'),
                                          subtitle:
                                              widget.argumentCategory?.name ?? '',
                                          onClick: () {}),
                                      categoryId: widget.argumentCategory
                                              ?.dataMap?['category_id'] ??
                                          -1,
                                      selectedSubCategory: widget.argumentCategory
                                          ?.dataMap?['category_id'],
                                      list: widget.argumentCategory?.list ??
                                          categoriesBloc.categories,
                                      onSelected: (value) {
                                        widget.argumentCategory?.name =
                                            value?.title;
                                        widget.argumentCategory?.id =
                                            value?.category_id;
                                        _initData();
                                        widget.argumentCategory
                                                ?.dataMap?['category_id'] =
                                            value?.category_id;
                                        categoriesBloc.refresh();
                                      },
                                    ),

                                    Column(
                                      children: List.generate(
                                          1 + subcategoriesLength(), (index) {
                                        return SubCategoriesDropdownWidget(
                                          child: OptionItem(
                                              title:
                                                  '${translate('subcategory')} ${index + 1}',
                                              subtitle: checkSubcategoriesList(
                                                      index)
                                                  ? (widget.argumentCategory
                                                                  ?.dataMap?[
                                                              'subcategory_names']
                                                          [index] ??
                                                      '')
                                                  : '',
                                              onClick: () {}),
                                          categoryId: index == 0
                                              ? (widget.argumentCategory
                                                      ?.dataMap?['category_id'] ??
                                                  -1)
                                              : (checkSubcategoriesList(index - 1)
                                                  ? (widget.argumentCategory
                                                                  ?.dataMap?[
                                                              'sub_category_ids']
                                                          [index - 1] ??
                                                      -1)
                                                  : -1),
                                          selectedSubCategory:
                                              checkSubcategoriesList(index)
                                                  ? widget.argumentCategory
                                                          ?.dataMap?[
                                                      'sub_category_ids']?[index]
                                                  : null,
                                          onSelected: (value) {

                                            _selectSubcategory(
                                                value: value, index: index);
                                          },
                                        );
                                      }),
                                    ),
                        isLoading ? LinearProgressIndicator(color: AppColorsController().buttonRedColor,backgroundColor: AppColorsController().colorBarRed,):Container(),
                                    ListView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        itemCount: data.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        itemBuilder: (context, index) {
                                          if (categoriesBloc.isPriceRange(
                                                  data[index].property?.title ??
                                                      '') &&
                                              !_isFilter()) {
                                            return SizedBox.shrink();
                                          }

                                          if (data[index].property?.type ==
                                              PropertyTypes.listDropdown.value) {
                                            return DropdownWidget(
                                              child: OptionItem(
                                                  title: data[index]
                                                          .property
                                                          ?.title ??
                                                      '',
                                                  subtitle: categoriesBloc
                                                              .selectedSubprop[
                                                          data[index]
                                                              .property
                                                              ?.propertyId] ??
                                                      '',
                                                  onClick: () {}),
                                              subProperties:
                                                  data[index].sub_properties ??
                                                      [],
                                              selectedProperties:
                                                  categoriesBloc.selectedSubprop[
                                                      data[index]
                                                          .property
                                                          ?.propertyId],
                                              onSelected: (value) {
                                                categoriesBloc.selectedSubprop[
                                                    data[index]
                                                            .property
                                                            ?.propertyId ??
                                                        0] = value?.title;
                                                categoriesBloc.refresh();
                                              },
                                            );
                                          } else if (data[index].property?.type ==
                                              PropertyTypes.list.value) {
                                            return TypeItemWidget(
                                              title:
                                                  data[index].property?.title ??
                                                      '',
                                              subProperties:
                                                  data[index].sub_properties ??
                                                      [],
                                              selectedProperties:
                                                  categoriesBloc.selectedSubprop[
                                                      data[index]
                                                          .property
                                                          ?.propertyId],
                                              onSelected: (value) {
                                                categoriesBloc.selectedSubprop[
                                                    data[index]
                                                            .property
                                                            ?.propertyId ??
                                                        0] = value?.title;
                                                categoriesBloc.refresh();
                                              },
                                            );
                                          } else if (data[index]
                                                  .sub_properties
                                                  ?.isNotEmpty ??
                                              false) {
                                            return DropdownWidget(
                                              child: OptionItem(
                                                  title: data[index]
                                                          .property
                                                          ?.title ??
                                                      '',
                                                  subtitle: categoriesBloc
                                                              .selectedSubprop[
                                                          data[index]
                                                              .property
                                                              ?.propertyId] ??
                                                      '',
                                                  onClick: () {}),
                                              subProperties:
                                                  data[index].sub_properties ??
                                                      [],
                                              selectedProperties:
                                                  categoriesBloc.selectedSubprop[
                                                      data[index]
                                                          .property
                                                          ?.propertyId],
                                              onSelected: (value) {
                                                categoriesBloc.selectedSubprop[
                                                    data[index]
                                                            .property
                                                            ?.propertyId ??
                                                        0] = value?.title;
                                                categoriesBloc.refresh();
                                              },
                                            );
                                          } else {
                                            bool isNumber =
                                                data[index].property?.type ==
                                                    PropertyTypes.integer.value;
                                            // bool singleLine = data[index].property?.type == PropertyTypes.stringSingle.value;
                                            bool multiLines = data[index]
                                                    .property
                                                    ?.type ==
                                                PropertyTypes.StringMulti.value;

                                            TextInputType textInputType = isNumber
                                                ? TextInputType.number
                                                : ((multiLines)
                                                    ? TextInputType.text
                                                    : TextInputType.name);

                                            return buildTextField(
                                                propertyId: data[index]
                                                        .property
                                                        ?.propertyId
                                                        ?.toString() ??
                                                    '',
                                                title: data[index]
                                                    .property
                                                    ?.title
                                                    ?.toCapitalized(),
                                                keyboardType: textInputType,
                                                isRequired: data[index]
                                                        .property
                                                        ?.essential ==
                                                    '1',
                                                height: multiLines ? 80.sp : null,
                                                index: index);
                                          }
                                        }),
                                    if (!_isFilter()) ...[
                                      // Text('عدد الأحرف: $charCount'),
                                      buildTextField(
//                                           onChangeText: (value){
// print(charCount);
//                                            setState(() {
//                                              _updateWordCount();
//                                              if (wordCount > maxWordCount) {
//                                                _controller.text = _controller.text.substring(0, _controller.text.length - 1);
//                                                _updateWordCount();
//                                              }
//                                            });
//                                           },
                                          controller: _controller,

                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                maxWordCount * 6),
                                            // الضرب في 10 لمعالجة عدد الأحرف بدلاً من الكلمات
                                          ],
                                          hintText: "عنوان قصير لإعلانك",
                                          propertyId: "title",
                                          title: translate("address_ads")
                                              .toCapitalized(),
                                          keyboardType: TextInputType.text),
                                      // SizedBox(height: 20),
                                      // Text('عدد الكلمات المسموح به: $maxWordCount'),

                                      buildTextField(
                                          controller: _controller2,

                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                maxWordCount * 100),
                                            // الضرب في 10 لمعالجة عدد الأحرف بدلاً من الكلمات
                                          ],
                                          hintText: "أكتب وصف قصير للإعلان",
                                          propertyId: "short_description",
                                          title: translate(
                                            "short_description",
                                          ).toCapitalized(),
                                          height: 80.sp),
                                      if (!categoriesBloc.isJobs(
                                          widget.argumentCategory?.name ??
                                              '')) ...[
                                        _addImage(),
                                      ],
                                      images.length > 0
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 8.sp,
                                                ),
                                                _imagesWidget(),
                                              ],
                                            )
                                          : Container(),
                                      if (!categoriesBloc.isCommunity(
                                          widget.argumentCategory?.name ??
                                              '')) ...[
                                        _buildAddress(),
                                      ],
                                      SizedBox(
                                        height: 16.sp,
                                      ),
                                      PrivacyWidget(),
                                    ],

                                    SizedBox(
                                      height: 60.sp,
                                    ),
                                    // _oldWidget()
                                  ],
                                ),
                              ),
                            ),
                            _postAdButton(),
                          ],
                        ),
                      );
                    }
                    return Center(child: AppLoaderWidget());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addImage() {
    return GestureDetector(
      onTap: () {
        _showChoiceDialog(context);
      },
      child: buildTextField(
          propertyId: 'add_image',
          title: translate("add_your_images"),
          isRequired: false,
          isProperty: false,
          readOnly: true,
          suffix: Icon(
            Icons.camera_alt_outlined,
            color: AppColorsController().red,
          )),
    );
  }

  Widget _imagesWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.sp,
      margin: EdgeInsets.symmetric(horizontal: 32.sp),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          File file = images[index];
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        child: Image.file(
                          file,
                          width: 80.sp,
                          height: 100.sp,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorsController().white.withOpacity(0.7),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _postAdButton() {
    return BlocConsumer<UploadAdsCubit, UploadAdsState>(
        bloc: ads,
        listener: (context, state) {
          if (state.storeAdsState is StoreAdsSuccessState) {
            var snackBar = SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_box,
                    color: Colors.green,
                  ),
                  Text(translate('add_advertisement_success')),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            DIManager.findNavigator().pushNamedAndRemoveUntil(
              HomePage.routeName,
            );
          }

          if (state.storeAdsState is BaseFailState) {
            CustomSnackbar.showErrorSnackbar(
              (state.storeAdsState as BaseFailState).error!,
            );
          }
        },
        builder: (context, state) {
          if (state.storeAdsState is BaseLoadingState) {
            return AppLoaderWidget(
              loaderSize: LoaderSize.Small,
            );
          }
          return NewButton(
            text: _isFilter() ? translate('view_results') : translate('post'),
            onPressed: () {
              if (_isFilter()) {
                DIManager.findNavigator().pushNamed(
                  ViewAllPage.routeName,
                  arguments: ViewAllArgs(
                    type: 4,
                    formData: categoriesBloc.getPropertyData(),
                    category_id: widget.argumentCategory?.id,
                  ),
                );
                return;
              }

              _formKey.currentState!.save();

              bool checkAddress = categoriesBloc
                      .isCommunity(widget.argumentCategory?.name ?? '')
                  ? true
                  : selectedLocation != null;

              if ((_formKey.currentState?.validate() ?? false) &&
                  checkAddress) {
                if (!categoriesBloc.isAcceptPrivacy) {
                  var snackBar = SnackBar(
                    content: Text(translate('please_agree_with_terms')),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                if (!categoriesBloc
                    .isCommunity(widget.argumentCategory?.name ?? '')) {
                  widget.argumentCategory?.dataMap?["google_long"] =
                      selectedLocation?.longitude ?? '';
                  widget.argumentCategory?.dataMap?["google_lat"] =
                      selectedLocation?.latitude ?? '';
                }

                widget.argumentCategory?.dataMap?["is_accept_terms"] = 1;

                // widget.argumentCategory?.dataMap?["properties"] = [];
                widget.argumentCategory?.dataMap?["sub_category_ids"] ??= [];
                widget.argumentCategory?.dataMap?["full_description"] ??=
                    widget.argumentCategory?.dataMap?["short_description"];

                widget.argumentCategory?.dataMap?["subcategory_names"] ??= [];
                widget.argumentCategory?.dataMap?.remove('subcategory_names');

                List<Map<String, dynamic>> propList =
                    categoriesBloc.getPropertyData();
                List subCatList =
                    (widget.argumentCategory?.dataMap?["sub_category_ids"]) ??
                        [];

                for (int i = 0; i < propList.length; i++) {
                  widget.argumentCategory?.dataMap?['properties[$i]'] =
                      json.encode(propList[i]);
                }

                for (int i = 0; i < subCatList.length; i++) {
                  widget.argumentCategory?.dataMap?['sub_category_ids[$i]'] =
                      subCatList[i];
                }

                widget.argumentCategory?.dataMap?.remove('sub_category_ids');

                ads.storeAds(ArgumentPolicy(
                    dataMap: widget.argumentCategory?.dataMap, images: images));

                // DIManager.findNavigator().pushNamed(SafetyPage.routeName,
                //     arguments:
                //     ArgumentPolicy(dataMap: widget.argumentCategory?.dataMap, images: images));
              } else {
                var snackBar = SnackBar(
                  content: Text(translate('please_fill_all_requirement_data')),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          );
        });
  }

  Widget _oldWidget() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        SizedBox(
          height: 12.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translate("you_are_almost_there"),
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.midLight,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text(
                translate("include_much_details"),
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.midLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.sp,
        ),
        buildTextField(
            propertyId: "title", title: translate("title").toCapitalized()),
        SizedBox(
          height: 8.sp,
        ),
        buildTextField(
            propertyId: "short_description",
            title: translate(
              "short_description",
            ).toCapitalized(),
            height: 80.sp),
        SizedBox(
          height: 8.sp,
        ),
        buildTextField(
            propertyId: "price",
            title: translate("price"),
            keyboardType: TextInputType.number),
        SizedBox(
          height: 8.sp,
        ),
        if (!categoriesBloc.isJobs(widget.argumentCategory?.name ?? '') &&
            !categoriesBloc
                .isCommunity(widget.argumentCategory?.name ?? '')) ...[
          _addImage(),
        ],
        SizedBox(
          height: 8.sp,
        ),
        images.length > 0 ? _imagesWidget() : Container(),
        SizedBox(
          height: 8.sp,
        ),
        _buildAddress(),
        SizedBox(
          height: 16.sp,
        ),
        _postAdButton(),
        SizedBox(
          height: 30.sp,
        ),
      ],
    );
  }

  _buildAddress() {
    return GestureDetector(
      onTap: () async {
        // void _selectLocation() async {
        selectedLocation = await Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => MapScreen()));
        if (selectedLocation != null) {
          setState(() {});
          // Do something with the selected location
        }
      },
      child: buildTextField(
          propertyId: 'locate_your_advertisement',
          title: translate("locate_your_advertisement"),
          isProperty: false,
          height: selectedLocation != null ? 84.sp : null,
          isRequired: false,
          readOnly: true,
          suffix: selectedLocation != null
              ? Container(
                  height: 84.sp,
                  width: 166.sp,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(selectedLocation.latitude,
                          selectedLocation.longitude),
                    ),
                    markers: Set<Marker>.of([
                      Marker(
                        markerId: MarkerId(translate('selected_location')),
                        position: LatLng(selectedLocation.latitude,
                            selectedLocation.longitude),
                        infoWindow: InfoWindow(
                            title:
                                translate('selected_location').toCapitalized()),
                      ),
                    ]),
                  ),
                )
              : Icon(
                  Icons.location_pin,
                  color: AppColorsController().red,
                ),
          onTap: () async {
            // void _selectLocation() async {
            selectedLocation = await Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => MapScreen()));
            if (selectedLocation != null) {
              setState(() {});
              // Do something with the selected location
            }
          }),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      loadImages();
                    },
                    title: Text(translate("gallery")),
                    leading: Icon(
                      Icons.image_sharp,
                      color: AppColorsController().primaryColor,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: AppColorsController().primaryColor,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _openCamera(context);
                    },
                    title: Text(translate("camera")),
                    leading: Icon(
                      Icons.camera,
                      color: AppColorsController().primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    XFile? result = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (images.length >= 6) {
      return;
    }

    images.add(await FileManager.compressFile(File(result?.path ?? '')));

    setState(() {});
  }

  Future<void> loadImages() async {
    final picker = ImagePicker();
    List<XFile>? result = await picker.pickMultiImage(
      imageQuality: 50,
    );
    if (images.length >= 6) {
      return;
    }

    for (XFile element in result) {
      images.add(await FileManager.compressFile(File(element.path)));
    }
    setState(() {});
  }

  Widget buildTextField(
      {required String propertyId,
      bool isProperty = true,
      String? title,
      String? hintText,
      KeyB,
      TextInputType? keyboardType,
      TextEditingController? controller,
      double? height,
      List<TextInputFormatter>? inputFormatters,
      bool isRequired = true,
      int? index,
      Widget? suffix,
        void Function(String)? onChangeText,
      bool readOnly = false,
      GestureTapCallback? onTap}) {
    String key = propertyId + ',$index';
    focusNodes[key] ??= FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isProperty) ...[
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Text((title ?? '') + '${(isRequired) ? ' * ' : ''}' + ": ",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColorsController().black,fontSize: AppFontSize.fontSize_13,
                    fontWeight: FontWeight.bold)),
          ),
        ],
        Padding(
          padding: EdgeInsets.only(top: isProperty ? 2 : 4),
          child: Container(
            height: height ?? 40.sp,
            margin: EdgeInsets.symmetric(
                horizontal: isProperty ? 12.sp : 24.sp, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.containerBorderRadius),
              ),
              color: AppColorsController().containerPrimaryColor,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                ),
                child: TextFieldWidget(
                  inputFormatters: inputFormatters,
                  controller: controller,
                  onChangeText: onChangeText,
                  icon: isProperty
                      ? SizedBox.shrink()
                      : Text(
                          (title ?? '') +
                              '${(isRequired) ? ' (*) ' : ''}' +
                              ": ",
                          style: AppStyle.smallTitleTextStyle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_13),
                        ),
                  hint: isProperty ? hintText : '',
                  onTap: onTap,
                  textDirection: TextDirection.rtl,
                  suffix: suffix,
                  readOnly: readOnly,
                  focusNode: focusNodes[key],
                  onFieldSubmitted: (s) {
                    FocusScope.of(context).unfocus();

                    String nextKey = '';
                    for (int i = 0; i < focusNodes.keys.toList().length; i++) {
                      if (focusNodes.keys.toList()[i] == key) {
                        if (i + 1 < focusNodes.keys.length)
                          nextKey = focusNodes.keys.toList()[i + 1];
                      }
                    }

                    if (focusNodes[nextKey] != null)
                      FocusScope.of(context).requestFocus(focusNodes[nextKey]);
                  },
                  isRequired: isRequired,
                  keyboardType: keyboardType,
                  onTextChanged: (value) {
                    if (int.tryParse(propertyId) != null) {
                      categoriesBloc
                              .selectedSubprop[int.tryParse(propertyId) ?? 0] =
                          value;
                    } else {
                      widget.argumentCategory?.dataMap?[propertyId] =
                          value.toString();
                    }
                  },
                )),
          ),
        ),
        if (isProperty) ...[
          SizedBox(
            height: 2,
          ),
          DividerItem(),
        ],
      ],
    );
  }

  bool checkSubcategoriesList(int index) {
    try {
      return ((widget.argumentCategory?.dataMap?['sub_category_ids'] as List?)
                      ?.length ??
                  0) >
              index &&
          ((widget.argumentCategory?.dataMap?['subcategory_names'] as List?)
                      ?.length ??
                  0) >
              index;
    } catch (e) {
      return false;
    }
  }

  int subcategoriesLength() {
    try {
      return (checkSubcategoriesList(0)
          ? (widget.argumentCategory?.dataMap?['sub_category_ids'].length)
          : 0);
    } catch (e) {
      return 0;
    }
  }

  void _selectSubcategory(
      {required CategoriesEntity? value, required int index}) {
    isLoading = true;
    Future.delayed(Duration(milliseconds: 5)).then((value) {
      isLoading = false;
    });
    widget.argumentCategory?.dataMap?['sub_category_ids'] ??= [];
    widget.argumentCategory?.dataMap?['subcategory_names'] ??= [];

    if (checkSubcategoriesList(index)) {
      widget.argumentCategory?.dataMap?['sub_category_ids'][index] =
          value?.category_id;
      widget.argumentCategory?.dataMap?['subcategory_names'][index] =
          value?.title;

      ///Remove next subcategories
      int length =
          (widget.argumentCategory?.dataMap?['subcategory_names'] as List)
              .length;
      (widget.argumentCategory?.dataMap?['subcategory_names'] as List)
          .removeRange(index + 1, length);

      (widget.argumentCategory?.dataMap?['sub_category_ids'] as List)
          .removeRange(index + 1, length);
    } else {
      widget.argumentCategory?.dataMap?['sub_category_ids']
          .add(value?.category_id);
      widget.argumentCategory?.dataMap?['subcategory_names'].add(value?.title);
    }

    categoriesBloc.selectedSubprop = {};
    categoriesBloc.getPropertiesCategories(value?.category_id ?? -1);

    categoriesBloc.refresh();
  }
}
