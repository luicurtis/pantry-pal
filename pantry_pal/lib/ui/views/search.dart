import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/widgets/itemTile.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  String selectedResult;
  BuildContext context;

  Search(this.context);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        child: Center(
      child: Text(selectedResult),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Item> suggestionList = [];
    // FIXME: Find a way to avoid using this dank method
    // using "updated" bool to prevent updaing the suggestion list since query.isNotEmpty
    // cannot be updated immediately after typing (there's delay)
    bool updated = false; 
    final itemProvider = Provider.of<Inventory>(context);

    return StreamBuilder(
      stream: itemProvider.fetchItemAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && query.isNotEmpty) {
          List<Item> allItems = snapshot.data.docs
              .map((doc) => Item.fromMap(doc.data(), doc.id))
              .toList();

          if (!updated){
            updated = true; // FIXME: Find a way to avoid using this dank method
            suggestionList.addAll(allItems
              .where((element) => element.name.toLowerCase().contains(query)));
          }

          if (suggestionList.length > 0) {
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, i) {
                return ItemTile(
                  itemDetails: suggestionList[i],
                );
              },
            );
          }
          return Center(child: Text('No Items named: $query'));
        }
        return Center(child: Text('Search for Items!'));
      },
    );
  }
}
