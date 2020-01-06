import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../image-picker/photo_preview.dart';
import '../../utils/rect.dart';

class PhotoLibrary extends StatefulWidget {
  _PhotoLibraryState createState() => _PhotoLibraryState();
}

class _PhotoLibraryState extends State<PhotoLibrary> {
  List<AssetEntity> list;
  List<GlobalKey> _keys;
  Future _thumbList;
  bool showPreview = false;
  int index = 0;

  initState() {
    super.initState();
    init();
  }

  void init() async {
    var paths = await PhotoManager.getAssetPathList();
    list = await paths.elementAt(0)?.assetList;
    _keys = list.map((_) => GlobalKey()).toList();
    _thumbList = Future.wait(list.map((v) => v.thumbData));
    setState(() {});
  }

  /// 打开预览
  void enterPreview(i) {
    index = i;
    setState(() {
      showPreview = true;
    });
  }

  /// 退出预览
  void exitPreview() {
    setState(() {
      showPreview = false;
    });
  }

  Rect getCellRect(int index) {
    assert(index >=0 && index <= list.length - 1);
    var renderObject = _keys[index].currentContext.findRenderObject();
    return getRect(renderObject);
  }

  Widget build(BuildContext context) {
    if ((list?.length ?? 0) == 0) {
      return Container();
    }
    return FutureBuilder(
        future: _thumbList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: GridView.count(
                        crossAxisCount: 4,
                        children: List.from(snapshot.data.map((_) => Container(
                            padding: EdgeInsets.all(1),
                            child: GestureDetector(
                                onTap: () {
                                  var index = snapshot.data.indexOf(_);
                                  enterPreview(index);
                                },
                                child: Image.memory(_,
                                    key: _keys[snapshot.data.indexOf(_)],
                                    fit: BoxFit.cover))))))),
                Visibility(
                    visible: showPreview,
                    child: PhotoPreview(
                      list: list,
                      initialPage: index,
                      exitPreview: exitPreview,
                      getRect: getCellRect,
                    ))
              ],
            );
          }
          return Container();
        });
  }
}
