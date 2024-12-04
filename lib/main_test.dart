import 'package:flutter/material.dart';

class MainTestPage extends StatefulWidget {
  const MainTestPage({super.key});

  @override
  State<MainTestPage> createState() => _MainTestPageState();
}

class _MainTestPageState extends State<MainTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: ListView.builder(
      //   padding: EdgeInsets.zero,
      //   itemBuilder: (context, index) {
      //     if (index == 0) {
      //       return Text('this is start ${index}');
      //     }
      //     if (index <= _testItems.length) {
      //       return Text(_testItems[index - 1]);
      //     }

      //     return null;
      //   },
      // ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                print('printed');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Initial item',
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              addAutomaticKeepAlives: true,
              semanticIndexOffset: 30,
              (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  // dense: true,
                  // enabled: false,
                  // horizontalTitleGap: 20,
                  onTap: () {
                    print('printed ${index}');
                  },
                  title: Text('Item $index item item item item item item item item item item item item item'),
                );
              },
              // Optional: childCount if you know the total
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  final _testItems = List.generate(100, (i) => 'Item ${i}');
}
