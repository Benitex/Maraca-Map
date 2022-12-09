import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';

class AddListDialog extends ConsumerWidget {
  AddListDialog({super.key});

  final listNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsController = ref.read(pointOfInterestListProvider.notifier);

    return AlertDialog(
      content: TextFormField(
        controller: listNameController,
        decoration: const InputDecoration(
          hintText: "Nome da lista",
          border: OutlineInputBorder(),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        TextButton(
          onPressed: () {
            if (listNameController.text != "") {
              listsController.addList(listName: listNameController.text);
              // TODO salvar no dispositivo
              Navigator.pop(context);
            }
          },
          child: Text("Salvar", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }
}
