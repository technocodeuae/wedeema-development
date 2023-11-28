import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wadeema/ui/work_focus_version/community/post_details.dart';

import '../../../blocs/application/application_bloc.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_consts.dart';
import '../../../core/constants/app_font.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/constants/dimens.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/utils/file_manager.dart';
import '../../../core/utils/localization/app_localizations.dart';
import '../general/app_bar/app_bar.dart';
import '../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../general/icons/send_message.dart';
import 'dart:io';
import 'package:wadeema/ui/work_focus_version/ads/pages/add_main_details_page.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage();

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // جعل الـ TextField يركز تلقائيًا عند تحميل الصفحة
    _focusNode.requestFocus();
  }
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorsController().white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.appBarBackgroundImage),
                fit: BoxFit.fill),
          ),
        ),
        // centerTitle: true,
        elevation: 0,
        title: Text(translate('community'),style: TextStyle(color: AppColorsController().black)),
        leading: Container(),

      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: SingleChildScrollView(
                  child:  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   AppAssets.profile,
                          //   height: 60.sp,
                          //   // width: 50.sp,
                          //   fit: BoxFit.cover,
                          // ),

                          Container(
                            // height: 48.sp,
                            width: 343.sp,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColorsController().buttonRedColor, width: 0.2.sp),
                              color: AppColorsController().card,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.sp),
                              ),
                            ),
                            // color: Colors.grey.withOpacity(0.2),
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: 10.sp, vertical: 12.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Padding(padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),

                               child:  Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Image.asset(
                                     AppAssets.profile,
                                     height: 25.sp,
                                     // width: 50.sp,
                                     fit: BoxFit.cover,
                                   ),
                                   Row(
                                     children: [
                                       _addImage(),
                                       SizedBox(
                                         width: 8.sp,
                                       ),
                                       Container
                                         (
                                         width: 25.sp,
                                         height: 25.sp,
                                         child: InkWell(
                                             onTap: () {

                                             },
                                             child: Transform.rotate(
                                               angle: 90 * 3.141592653589793 / 90,
                                               // تحويل الزاوية من درجة إلى راديان
                                               child: Container(
                                                 width: 25.sp,
                                                 height: 25.sp,
                                                 child: SendMessageIcon(
                                                     width: 29.sp,
                                                     height: 25.sp,
                                                     color: AppColorsController()
                                                         .iconColor),
                                               ), // استبدل بمسار صورتك
                                             )),
                                       ),

                                       SizedBox(
                                         width: 8.sp,
                                       ),

                                     ],
                                   ),
                                 ],
                               ),
                               ),
                                TextFormField(
                                  controller: controller,
                                  focusNode: _focusNode,
                                  textDirection: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR? TextDirection.rtl:TextDirection.ltr,
                                  maxLines: null,
                                  maxLength: 600,
                                  cursorColor: AppColorsController().scaffoldBGColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: translate('enter_your_post'),
                                    // filled: true,
                                    hintStyle:TextStyle(fontSize: 12.sp,),
                                    // fillColor:AppColorsController().containerPrimaryColor,// لون الخلفية
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                    //   ),
                                    //   // borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل
                                    // ),
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل عند التركيز
                                    // ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 20), // زيادة التباعد الرأسي لزيادة ارتفاع الحقل
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // aboutMeValue = value;
                                    });
                                  },
                                )
                              ],
                            )


                                /*
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image.asset(
                                //   AppAssets.profile,
                                //   height: 25.sp,
                                //   // width: 50.sp,
                                //   fit: BoxFit.cover,
                                // ),
                                Expanded(child: TextFormField(
                                  controller: controller,
                                  focusNode: _focusNode,
                                  textDirection: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR? TextDirection.rtl:TextDirection.ltr,
                                  maxLines: null,
                                  maxLength: 600,
                                  cursorColor: AppColorsController().scaffoldBGColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: translate('enter_your_post'),
                                    // filled: true,
                                    hintStyle:TextStyle(fontSize: 12.sp,),
                                    // fillColor:AppColorsController().containerPrimaryColor,// لون الخلفية
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                    //   ),
                                    //   // borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل
                                    // ),
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     width: 0.1,color: AppColorsController().borderColor,// عرض البوردر
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(Dimens.containerBorderRadius), // تعديل شكل الحقل عند التركيز
                                    // ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 20), // زيادة التباعد الرأسي لزيادة ارتفاع الحقل
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // aboutMeValue = value;
                                    });
                                  },
                                )),
                                // _addImage(),
                                // SizedBox(
                                //   width: 8.sp,
                                // ),
                                // Container
                                //   (
                                //   width: 25.sp,
                                //   height: 25.sp,
                                //   child: InkWell(
                                //       onTap: () {
                                //
                                //       },
                                //       child: Transform.rotate(
                                //         angle: 90 * 3.141592653589793 / 90,
                                //         // تحويل الزاوية من درجة إلى راديان
                                //         child: Container(
                                //           width: 25.sp,
                                //           height: 25.sp,
                                //           child: SendMessageIcon(
                                //               width: 29.sp,
                                //               height: 25.sp,
                                //               color: AppColorsController()
                                //                   .iconColor),
                                //         ), // استبدل بمسار صورتك
                                //       )),
                                // ),
                                //
                                // SizedBox(
                                //   width: 8.sp,
                                // ),
                                /*
                                 Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      loadImages();
                                    },
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColorsController().red,
                                      size: 24.sp,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      loadFiles();
                                    },
                                    child: Icon(
                                      Icons.attach_file_sharp,
                                      color: AppColorsController().red,
                                      size: 24.sp,
                                    ),
                                  ),

                                  Container(
                                    width: 200.sp,
                                    child: TextField(

                                      controller: controller,
                                      style: AppStyle.tinySmallTitleStyle.copyWith(
                                        color: AppColorsController().naveTextColor,
                                      ),
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: translate("enter_your_message"),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.sp, horizontal: 16.sp)),
                                      onChanged: (value) {
                                        value = value.toString();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                               */
                              ],
                            ),

                            */
                          ),
                        ],
                      ),
                      images.length > 0 ? _imagesWidget() : Container(),


                      Container(
                        height: 600.sp,
                        child:   ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context,index){

                              return Container(
                                // height: 48.sp,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController().buttonRedColor, width: 0.2.sp),
                                  color: AppColorsController().card,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.sp),
                                  ),
                                ),
                                // color: Colors.grey.withOpacity(0.2),
                                margin: EdgeInsets.symmetric(
                                    vertical: 12.sp),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.profile,
                                          height: 60.sp,
                                          // width: 50.sp,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("سعيد محمد شاكر",
                                              style: AppStyle.namePostTitleStyle,),
                                            // SizedBox(
                                            //   height: 5.sp,
                                            // ),s
                                            Text("٣ ساعات ",
                                              style: AppStyle.tabBarUnselectedLabelStyle,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("منطقة درعا هي منطقة جميلة تحتوي على الكثير من المناظر الخلابة والتي تمتاز بالتربة الحمراء الصالحة للزراعة",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11.sp
                                            ),),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 65.sp,
                                              ),
                                              Container(
                                                  width: 214.sp,
                                                  height: 214.sp,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      "assets/images/trace.svg",
                                                      width: 20.sp,
                                                      height: 214.sp, fit: BoxFit.scaleDown,
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 270.sp,
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppAssets.likeIcon,
                                                      height: 30.sp,
                                                      // width: 50.sp,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 12.sp,
                                                    ),
                                                    Text('١٥٠ أعجبني',style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black
                                                    )),
                                                  ],
                                                ),
                                                Row(

                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context){return PostDetailsPage();}));
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppAssets.chatIcons,
                                                        height: 30.sp,
                                                        // width: 50.sp,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12.sp,
                                                    ),
                                                    Text('٣٢ تعليق',style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                )

            ),
            bottomNavigationBarWidget(indexPage: 5),
          ],
        ),
      ),
      // bottomSheet: bottomNavigationBarWidget(),
    );
  }

  Widget _addImage() {
    return GestureDetector(
      onTap: () {
        _showChoiceDialog(context);
      },
      child: Icon(
        Icons.camera_alt_outlined,
        color: AppColorsController().red,
      ),
    );
  }

  Widget _imagesWidget() {
    File file = images[0];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.sp,

      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.file(
                      file,
                      width: MediaQuery.of(context).size.width,
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
                  images.removeAt(0);
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
      )
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
    if (images.length >= 1) {
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
    if (images.length >= 1) {
      return;
    }

    for (XFile element in result) {
      images.add(await FileManager.compressFile(File(element.path)));
    }
    setState(() {});
  }

}
