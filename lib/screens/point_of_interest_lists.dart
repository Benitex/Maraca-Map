import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';
import 'package:maraca_map/screens/custom_point_of_interest_list.dart';
import 'package:maraca_map/widgets/point_of_interest_lists/add_list_dialog.dart';

class PointOfInterestLists extends ConsumerWidget {
  const PointOfInterestLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(pointOfInterestListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Listas de lugares"),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          for (String listName in lists.keys)
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CustomPointOfInterestList(
                  listName: listName,
                  idsList: lists[listName]!,
                )),
              ),
              child: Card(child: ListTile(title: Text(listName))),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar nova lista",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddListDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
