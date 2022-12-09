import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maraca_map/providers/point_of_interest_lists_provider.dart';
import 'package:maraca_map/services/local_storage.dart';

class AddListDialog extends ConsumerWidget {
  AddListDialog({super.key});

  final formState = GlobalKey<FormState>();
  final listNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(pointOfInterestListProvider);
    final localStorage = ref.read(localStorageProvider);
    final listsController = ref.read(pointOfInterestListProvider.notifier);

    return AlertDialog(
      content: Form(
        key: formState,
        child: TextFormField(
          controller: listNameController,
          decoration: const InputDecoration(
            hintText: "Nome da lista",
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "O nome da lista não estar ser vazio";
            } else if (lists.containsKey(value)) {
              return "Já existe uma lista com esse nome";
            }
            return null;
          },
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        TextButton(
          onPressed: () async {
            if (formState.currentState!.validate()) {
              listsController.addList(listName: listNameController.text);
              await localStorage.saveListNames([...lists.keys, listNameController.text]);
              if (context.mounted) Navigator.pop(context);
            }
          },
          child: Text("Salvar", style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }
}
