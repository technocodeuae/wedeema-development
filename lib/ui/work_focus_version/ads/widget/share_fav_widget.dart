import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../general/icons/share_icon.dart';
import 'favourites_button_widget.dart';
class ShareFavWidget extends StatelessWidget {
  final int? ad_id;
  final int? is_favorite;
  final int? index;
  const ShareFavWidget({Key? key,this.index,this.is_favorite,this.ad_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FavouritesButtonWidget(isFromPageFavourite: false,
          // onChanged: widget.onChanged,
          adsId: ad_id,
          isFavourite: is_favorite == 0 ? false:true,
          index: index,

        ),
        SizedBox(
          height: 4.sp,
        ),
        ShareIcon(
          height: 21.sp,
          width: 21.sp,
        )
      ],
    );
  }
}
