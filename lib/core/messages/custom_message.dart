/// This class is used as a help to show all translated messages in the app.
///
/// His implementations are `SuccessMessage` and `Failure`
abstract class CustomMessage {
  const CustomMessage();

  @override
  String toString() {
    return "CustomMessage{}";
  }
}
