import 'package:selfprivacy/logic/api_maps/generic_result.dart';

class CallbackDialogueBranching {
  CallbackDialogueBranching({
    required this.title,
    required this.description,
    required this.choices,
  });
  final String title;
  final String description;
  final List<CallbackDialogueChoice> choices;
}

class CallbackDialogueChoice {
  CallbackDialogueChoice({required this.title, required this.callback});
  final String title;
  final Future<GenericResult<CallbackDialogueBranching?>> Function()? callback;
}
