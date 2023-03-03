abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageSuccess extends ChatState{}
class SendMessageError extends ChatState{
  final String error;
  SendMessageError({required this.error});
}