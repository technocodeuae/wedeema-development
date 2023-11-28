import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/application/application_bloc.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_consts.dart';
import '../../../core/constants/app_style.dart';
import '../../../core/di/di_manager.dart';
import '../../../core/utils/localization/app_localizations.dart';
import '../general/icons/send_message.dart';

class PostDetailsPage extends StatefulWidget {
  const PostDetailsPage();

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(
          Icons.arrow_back_outlined,color: Colors.black,
        ),),

      ),
      body:Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 8000.sp,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  children: [
                    Container(
                      // height: 48.sp,
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //       color: AppColorsController().buttonRedColor,
                      //       width: 0.2.sp),
                      //   color: AppColorsController().card,
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(16.sp),
                      //   ),
                      // ),
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
                    ),

                   Container(
                     height: 500.sp,
                     child: ListView.builder(
                         itemCount: 6,
                        // physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (context,index){

                       return  Padding(padding: EdgeInsets.symmetric(vertical: 5.sp),
                       child: Container(
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
                         padding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 3.sp),
                         // color: Colors.grey.withOpacity(0.2),
                         // margin: EdgeInsets.symmetric(
                         //     horizontal: 13.sp, vertical: 12.sp),
                         child:    Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Image.asset(
                               AppAssets.profile,
                               height: 40.sp,
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
                                 SizedBox(
                                   height: 10.sp,
                                 ),
                                 Container(
                                   width: 280.sp,
                                   child: Text("المنظر خلاب والحياة جميلة والشمس مشرقة والعصافير تغرد حتى بالليل ",
                                     style: TextStyle(
                                         color: Colors.black
                                     ),),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                       );



                     }),
                   )
                  ],
                ),
              ),
            ),
          ),
          Container(
            // height: 48.sp,
            width: 260.sp,
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
                horizontal: 10.sp, vertical: 12.sp),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller,
                  textDirection: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR? TextDirection.rtl:TextDirection.ltr,
                  maxLines: null,
                  // maxLength: 600,
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
          ),
        ],
      ),
    );
  }
}
