import 'package:flutter/material.dart';

//import '../components/camera/Camera.dart';
import '../components/image-picker/ImagePicker.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> with SingleTickerProviderStateMixin {
  List<Tab> myTabs;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    myTabs = tabs();
    _controller.addListener(() {
      print(_controller.offset);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget baseView() {
    return Container(
      color: Color(0xFF151722),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: FlatButton(
                    color: Color(0xff3a3a43),
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      '编辑资料',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context) {
                            return MyHomePage();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                color: Color(0xff3a3a43),
                padding: EdgeInsets.all(1.5),
                child: IconButton(
                  icon: Icon(Icons.group_add),
                  color: Colors.white,
                  iconSize: 34,
                  onPressed: () {},
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        Divider.createBorderSide(context, color: Colors.grey))),
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '社会银儿',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  '抖音号：dowdiandnei',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '🌈认真的男人最帅',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                  padding: EdgeInsets.zero,
                  color: Color(0xff232530),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  label: Text(
                    '26岁',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  color: Color(0xff232530),
                  child: Text(
                    '北京·顺义',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  onPressed: () {},
                ),
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                color: Color(0xff232530),
                child: Text(
                  '哈尔滨商业大学',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '0',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  TextSpan(
                      text: '获赞',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                ])),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '31',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    TextSpan(
                        text: '关注',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
                  ])),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '0',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  TextSpan(
                      text: '粉丝',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                ]))
              ],
            ),
          ),
          FlatButton.icon(
              color: Color(0xff232530),
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              label: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '添加随拍',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  List<Tab> tabs() {
    return List.generate(3, (i) {
      return Tab(
        child: Text('$i'),
      );
    }).toList();
  }

  Widget tabBar() {
    return TabBar(
      tabs: myTabs,
      isScrollable: true,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
    );
  }

  Widget tabBarView() {
    return TabBarView(
      children: myTabs.map((index) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>('$index'),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverFixedExtentList(
                      itemExtent: 48.0,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                        childCount: 30,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverToBoxAdapter(
              child: baseView(),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                title: const Text('Books'),
                pinned: true,
                expandedHeight: 150.0,
                forceElevated: innerBoxIsScrolled,
                bottom: tabBar(),
              ),
            ),
          ];
        },
        body: tabBarView(),
      ),
    );
  }
}
