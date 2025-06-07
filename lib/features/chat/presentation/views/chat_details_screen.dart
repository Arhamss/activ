import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/exports.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({required this.chatModel, super.key});

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(
        title: Text(chatModel.name),
        subtitle: Text('${chatModel.gameSport} at ${chatModel.gameAddress}'),
      ),
      body: StreamChannel(
        channel: StreamChannel.of(context).channel,
        child: const Column(
          children: [
            Expanded(child: StreamMessageListView()),
            StreamMessageInput(),
          ],
        ),
      ),
    );
  }
}
