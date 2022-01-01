import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/core/model/item.dart';
import 'package:pantry_pal/core/viewmodels/inventory.dart';
import 'package:pantry_pal/ui/widgets/slidableTile.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  BuildContext context;
  List<Item> suggestionList = [];

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
    return streamSuggestionList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return streamSuggestionList(context);
  }

  Widget streamSuggestionList(BuildContext context) {
    final itemProvider = Provider.of<Inventory>(context);
    return StreamBuilder(
      stream: itemProvider.fetchItemAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && query.isNotEmpty) {
          final allItems = snapshot.data!.docs
              .map((doc) => Item.fromMap(doc.data() as Map, doc.id))
              .toList();

          suggestionList.clear();
          suggestionList.addAll(allItems
              .where((element) => element.name.toLowerCase().contains(query)));

          if (suggestionList.length > 0) {
            suggestionList.sort((a, b) =>
                  a.name.toLowerCase().compareTo(b.name.toLowerCase()));
            return ListView.separated(
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              itemCount: suggestionList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (context, i) {
                return slidableTile(
                    context, suggestionList[i]);
              },
            );
          }
          return Center(child: Text('No Items with names similar to "$query"'));
        }
        return Center(child: Text('Search for Items!'));
      },
    );
  }
}
