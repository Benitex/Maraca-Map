import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';

class AddPointOfInterestToListDialog extends ConsumerStatefulWidget {
  const AddPointOfInterestToListDialog({super.key, required this.pointOfInterestId});

  final String pointOfInterestId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddToListDialogState();
}

class _AddToListDialogState extends ConsumerState<AddPointOfInterestToListDialog> {
  String? listName;

  @override
  Widget build(BuildContext context) {
    final lists = ref.read(pointOfInterestListProvider);
    final listsController = ref.read(pointOfInterestListProvider.notifier);

    return AlertDialog(
      content: DropdownButton<String>(
        hint: const Text("Nome da lista"),
        value: listName,
        items: <DropdownMenuItem<String>> [
          for (String listName in lists.keys)
            DropdownMenuItem(
              value: listName,
              child: Text(listName),
            ),
        ],
        onChanged: (value) => setState(() {
          listName = value;
        }),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        TextButton(
          onPressed: () {
            if (listName != null && listName != '') {
              listsController.addPointOfInterestTo(
                listName: listName!,
                id: widget.pointOfInterestId,
              );
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
