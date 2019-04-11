import 'package:flutter/material.dart';

abstract class BaseListPageState<M, T extends StatefulWidget>
    extends State<T> {

  List data = null;
  int pageNo = 1;
  int pageSize = 10;
  bool hasHeader = false;
  bool isLoadingMore = false;
  bool isNoMoreDate = false;
  bool isError = false;
  bool nodatoShowHeader = true;

  String title = "";
  ScrollController scrollController = ScrollController();

  void init();

  Future<List<M>> requestData(int pageNo, int pageSize);

  Widget getItemWidget(BuildContext context, M model);

  @override
  void initState() {
    super.initState();
    init();
    doRequestData(context, pageNo, pageSize);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("滑动到了最底部");
        if (!isNoMoreDate) requestMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Future doRequestData(BuildContext context, int pageNo, int pageSize) async {
    if (pageNo == 1) isNoMoreDate = false;
    try{
      await requestData(pageNo, pageSize).then((newData) {
        setState(() {
          isError = false;
          if (pageNo == 1) {
            if (newData != null) {
              data = new List();
              data.addAll(newData);
            }
          } else {
            if (newData != null) {
              data.addAll(newData);
            }
          }
          if (newData.length < pageSize) isNoMoreDate = true;
        });
      });
    }catch(e){
      setState(() {
        isError = true;
      });
    }finally{
      isLoadingMore = false;
    }
  }

  PreferredSizeWidget getAppBar() {
    return new AppBar(
      title: new Text(title),
    );
  }

  Widget getBody() {
    if (isError) return getErrorWidget();
    if (data == null) return getLoadingWidget();
    if (data.length == 0){
      if(hasHeader && nodatoShowHeader) return getHeaderWidget();
      else return getNoDataWidget();
    }
    return new RefreshIndicator(
        child: getListWidget(),
        onRefresh: onRefresh);
  }

  ///获取列表Widget
  Widget getListWidget(){
    return ListView.builder(
      itemBuilder: getListItemWidget,
      itemCount: getItemCount(),
      controller: scrollController,
      physics: AlwaysScrollableScrollPhysics(),
    );
  }

  int getItemCount(){
    return data.length + (hasHeader ? 2:1);
  }

  Widget getListItemWidget(BuildContext context, int index) {
    if(index == 0 && hasHeader) return getHeaderWidget();
    if(hasHeader) index --;
    if (index < data.length) return getItemWidget(context, data[index]);
    return getMoreWidget();
  }

  ///获取Header，需要请重写，并修改hasHeader为true
  Widget getHeaderWidget(){}

  Widget getLoadingWidget() {
    return new Center(child: new CircularProgressIndicator());
  }

  Widget getNoDataWidget() {
    return new Center(
      child: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox.fromSize(
                  size: new Size(200, 200),
                  child: new Image.asset("images/no_data.png")),
              new Padding(
                  padding: EdgeInsetsDirectional.only(top: 30, bottom: 100),
                  child: new Text(
                    "这里什么也没有哦~",
                    style: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ))
            ],
          )),
    );
  }

  Widget getErrorWidget() {
    return new Center(
      child: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox.fromSize(
                  size: new Size(200, 200),
                  child: new Image.asset("images/net_error.png")),
              new Padding(
                  padding: EdgeInsetsDirectional.only(top: 30, bottom: 100),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        "出错啦~",
                        style: new TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      new Padding(
                        padding: EdgeInsetsDirectional.only(top: 5),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new GestureDetector(
                              child: new Text(
                                " 点击这里 ",
                                style: new TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              onTap: onRefresh,
                            ),
                            new Text("重新加载",
                                style: new TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  ///获取底部Widget
  Widget getMoreWidget() {
    if (isNoMoreDate)
      return new Container(
        padding: new EdgeInsets.all(10),
        child: new Text(
          "没有更多数据了",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中 ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            new SizedBox.fromSize(
                size: new Size(20, 20),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ))
          ],
        ),
      ),
    );
  }

  Future onRefresh() {
    pageNo = 1;
    return doRequestData(context, pageNo, pageSize);
  }

  void requestMore() async {
    if (isLoadingMore) return;
    setState(() {
      isLoadingMore = true;
    });
    pageNo++;
    doRequestData(context, pageNo, pageSize);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
