import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../general/icons/share_icon.dart';
import '../../ads/widget/favourites_button_widget.dart';


class ImageSliderShowWidget extends StatefulWidget {
  final int? ad_id;
  final int? is_favorite;
  final int? index;
  final List<ImageAdsDetailsEntity>? images;
  final List<AdImagesEntity>? imagesList;
  final Function(bool,int)? onChanged;
  final Function(bool)? onChangedLoader;
  final bool? isAllDetails;
  final String? adsUrlShare;

  const ImageSliderShowWidget(
      {Key? key,this.onChangedLoader,this.adsUrlShare ,this.is_favorite, this.onChanged,this.ad_id,this.isAllDetails = false ,this.images,this.index, this.imagesList})
      : super(key: key);

  @override
  State<ImageSliderShowWidget> createState() => _ImageSliderShowWidgetState();
}

class _ImageSliderShowWidgetState extends State<ImageSliderShowWidget> {
  // Initializing a Controller fore PageView
  final PageController _pageViewController =
      PageController(initialPage: 0); // set the initial page you want to show
  int _activePage = 0;




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 214.sp,
              width: width,
              child: PageView.builder(
                  controller: _pageViewController,

                  onPageChanged: (int index) {
                    setState(() {
                      _activePage = index;
                    });
                  },
                  itemCount: widget.isAllDetails == false ? widget.images!.length:widget.imagesList?.length??0,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          height: 214.sp,
                          width: width,
                          child: Image.network(
                            AppConsts.IMAGE_URL + (widget.isAllDetails == false ?widget.images![index].name!:widget.imagesList![index].name??''),
                            fit: BoxFit.fill,
                            height: 214.sp,
                            width: width,
                          ).blurred(colorOpacity: 0.4,),
                        ),
                        Container(
                          height: 214.sp,
                          width: width,
                          child: Image.network(
                            AppConsts.IMAGE_URL + (widget.isAllDetails == false ?widget.images![index].name!:widget.imagesList![index].name??''),
                            fit: BoxFit.scaleDown,
                            height: 214.sp,
                            width: width,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(height: 4.sp,),
            //creating dots at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    widget.isAllDetails == false ? (widget.images?.length ?? 0) : widget.imagesList?.length ?? 0,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: InkWell(
                            onTap: () {
                              _pageViewController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 3.2,
                              // check if a dot is connected to the current page
                              // if true, give it a different color
                              backgroundColor: _activePage == index
                                  ? AppColorsController().buttonRedColor
                                  : AppColorsController().black.withOpacity(0.45),
                            ),
                          ),
                        )),
              ),
            ),
            SizedBox(height: 8.sp,),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FavouritesButtonWidget(
                  onChanged: widget.onChanged,
                  onChangedLoader: widget.onChangedLoader,
                  adsId: widget.ad_id,
                  isFavourite: widget.is_favorite == 0 ? false:true,
                  index: widget.index,
                ),
                SizedBox(
                  height: 4.sp,
                ),
                InkWell(
                  onTap: (){
                    Share.share(widget.adsUrlShare!);
                  },
                  child: ShareIcon(
                    height: 21.sp,
                    width: 21.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
