import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:m_tuan_flutter/base/base_list_page_state.dart';
import 'package:m_tuan_flutter/conts/colors.dart';
import 'package:m_tuan_flutter/conts/load_more_status.dart';
import 'package:m_tuan_flutter/model/resp/discover_list_resp.dart';
import 'package:m_tuan_flutter/util/http.dart';
import 'package:m_tuan_flutter/widget/c_circle_avatar.dart';
import 'package:m_tuan_flutter/widget/c_container.dart';
import 'package:m_tuan_flutter/widget/c_image.dart';
import 'package:m_tuan_flutter/widget/c_text.dart';
import 'package:m_tuan_flutter/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DiscoverPageState();
  }

}

class DiscoverPageState extends State<DiscoverPage> with AutomaticKeepAliveClientMixin{

  /**缓存Key*/
  final key_resp_data = "key_discover_list_resp_data";

  DiscoverListResp discoverListResp;

  int pageNo = 1;
  int pageSize = 10;

  /**加载更多状态*/
  LoadMoreStatus loadMoreStatus = LoadMoreStatus.normal;

  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  /**请求数据*/
  Future requestData(BuildContext context,int pageNo,int pageSize) async {
    await Http.post(context, "discover/discoverList",
        FormData.from({
          "pageNo":pageNo,
          "pageSize":pageSize,
        }),
        onSuccess:(data) async {
          DiscoverListResp response = DiscoverListResp(data);
          if(pageNo == 1) await SharedPreferences.getInstance()..setString(key_resp_data, data); /*缓存数据*/
          setState(() {
          if(pageNo == 1){
            discoverListResp = response;
            loadMoreStatus = LoadMoreStatus.normal;
            return;
          }
          discoverListResp.discoverList.addAll(response.discoverList);
          loadMoreStatus = response.discoverList.length < pageSize ? LoadMoreStatus.noMoredata:LoadMoreStatus.normal;
          });
        },
        onError: (error) => setState(() => loadMoreStatus = LoadMoreStatus.loadError)
    );
  }

  @override
  void initState() {
    super.initState();
    /**读取缓存*/
    SharedPreferences.getInstance().then((prefs) => setState(()=> discoverListResp = DiscoverListResp(prefs.get(key_resp_data))));
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if(loadMoreStatus == LoadMoreStatus.loading || loadMoreStatus == LoadMoreStatus.noMoredata) return;
        setState(() => loadMoreStatus = LoadMoreStatus.loading);
        pageNo++;
        requestData(context, pageNo, pageSize);
      }
    });
    requestData(context,pageNo,pageSize);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CContainer(
        direction: Direction.column,
        color: CColors.bgDefault,
        children: <Widget>[
          CText("发现",textSize: 18,bold: true,padding: EdgeInsets.only(top: 12,bottom: 12),),
          discoverListResp == null || discoverListResp.discoverList == null ? LoadingWidget():
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15,right: 15,),
              child: RefreshIndicator(
                onRefresh: (){
                  pageNo = 1;
                  return requestData(context, pageNo, pageSize);
                },
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  controller: scrollController,
                  itemCount: discoverListResp.discoverList.length,
                  itemBuilder: (context,index) => ItemWidget(discoverListResp.discoverList[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

class ItemWidget extends StatelessWidget{

  Discover model;

  ItemWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return CContainer(
      color: Colors.white,
      direction: Direction.column,
      borderRadius: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CImage(url: model.imageUrl,leftTopRadius: 6,rightTopRadius: 6,),
        CText(model.title,textSize:15.0,textColor:CColors.textTitle,maxLines: 2,bold: true,padding: EdgeInsets.all(10),),
        CContainer(
          direction: Direction.row,
          padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
          children: <Widget>[
            CContainer(
              direction: Direction.row,
              expand: true,
              padding: EdgeInsets.only(right: 5),
              children: <Widget>[
                CCircleAvatar(model.createUser == null ? "":"${model.createUser.avatarUrl}",width: 20,height: 20,),
                Expanded(child: CText(model.createUser == null ? "":"${model.createUser.name}",padding: EdgeInsets.only(left: 5),textSize: 11.5,),),
              ],
            ),
            CText("${model.thumbsUpCount}",icon: Icons.thumb_up,iconSize:16,drawableDirection: DrawableDirection.left,drawablePadding: 5,textColor: Colors.grey[600],),
          ],
        )
      ],
    );
  }

}