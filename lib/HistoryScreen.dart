import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/Widgets/MessagesWidgets/PreviousDayEmpty.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = List.generate(
    14,
    (index) => Tab(
        text:
            '${DateFormat.yMd().format(DateTime.now().subtract(Duration(days: index + 1)))}'),
  );

  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.index == 0) {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: 'Historial',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
              TextSpan(text: "\n"),
              TextSpan(
                  text: '${DateFormat.yMMMMEEEEd().format(DateFormat('M/D/yyyy').parse(this._tabs[this._currentIndex].text))}',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 16))
            ])),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs,
          onTap: (index) => setState(() {this._currentIndex = index;}),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs
            .asMap()
            .map((index, tab) {
              return MapEntry(index, LogList(index: index, tabText: tab.text));
            })
            .values
            .toList(),
      ),
    );
  }
}

class LogList extends StatelessWidget {
  final int index;
  final String tabText;

  LogList({@required this.index, @required this.tabText});

  @override
  Widget build(BuildContext context) {
    return Row(children: [Expanded(child: PreviousDayEmptyMessage())]);
  }
}
