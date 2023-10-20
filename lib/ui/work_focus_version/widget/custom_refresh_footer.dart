import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class CustomRefreshFooter extends StatelessWidget {
  const CustomRefreshFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context,LoadStatus? mode){
        Widget body ;
        if(mode==LoadStatus.idle){
          body =  Text(translate("pullToLoad"));
        }
        else if(mode==LoadStatus.loading){
          body =  CupertinoActivityIndicator();
        }
        else if(mode == LoadStatus.failed){
          body = Text(translate("pullFailedRetry"));
        }
        else if(mode == LoadStatus.canLoading){
          body = Text(translate("releaseToLoad"));
        }
        else{
          body =  Text(translate("noMoreData"));
        }
        return Container(
          height: 55.0,
          child: Center(child:body),
        );
      },
    );
  }
}
