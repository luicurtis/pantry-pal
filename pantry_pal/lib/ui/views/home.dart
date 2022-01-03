import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/views/addItem.dart';
import 'package:pantry_pal/ui/views/search.dart';
import 'package:pantry_pal/ui/views/userProfile.dart';
import 'package:pantry_pal/ui/widgets/fetchingInventoryAnimation.dart';
import 'package:pantry_pal/ui/widgets/slidableTile.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _semicircleController = ScrollController();
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Inventory'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            alignment: Alignment.center,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfile(),
                ),
              );
              // print("signout pressed");
              // authProvider.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(context));
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: itemProvider.fetchItemAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              items = snapshot.data!.docs
                  .map((doc) => Item.fromMap(doc.data() as Map, doc.id))
                  .toList();
              items.sort((a, b) =>
                  a.name.toLowerCase().compareTo(b.name.toLowerCase()));

              if (items.length > 0) {
                return DraggableScrollbar.semicircle(
                  controller: _semicircleController,
                  labelTextBuilder: (offset) {
                    final int currentIdx = _semicircleController.hasClients
                        ? (_semicircleController.offset /
                                (_semicircleController
                                        .position.maxScrollExtent -
                                    kFloatingActionButtonMargin +
                                    48) *
                                items.length)
                            .floor()
                        : 0;

                    return Text(
                      "${items[currentIdx].name[0].toUpperCase()}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.black),
                    );
                  },
                  labelConstraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                  child: ListView.separated(
                    controller: _semicircleController,
                    padding: const EdgeInsets.only(
                        bottom: kFloatingActionButtonMargin + 48),
                    itemCount: items.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, i) {
                      return slidableTile(context, items[i]);
                    },
                  ),
                );
              }
              return Center(child: const Text('Add Items!'));
            } else {
              return fetchingInventoryAnimation();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddItem()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
