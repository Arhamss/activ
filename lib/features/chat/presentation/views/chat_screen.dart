import 'package:activ/constants/asset_paths.dart';
import 'package:activ/core/models/chats/chat_model.dart';
import 'package:activ/features/chat/presentation/widgets/chat_tile.dart';
import 'package:activ/utils/widgets/core_widgets/app_bar.dart';
import 'package:activ/utils/widgets/core_widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:activ/constants/app_colors.dart';
import 'package:activ/constants/app_text_style.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: activAppBar(
        title: 'Chat',
        context: context,
        backgroundColor: AppColors.primaryColor,
        actionWidget: ActivIconButton(
          backgroundColor: Colors.transparent,
          icon: SvgPicture.asset(
            AssetPaths.notificationIcon,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                ChatTile(
                  chat: ChatModel(
                    id: 'game-683f6319efedb5ee31de55e6',
                    name: 'Basketball with A C on Wednesday',
                    gameId: '683f6319efedb5ee31de55e6',
                    gameAddress:
                        '555 California St, Financial District, San Francisco',
                    gameSport: 'Basketball',
                    gameDatetime: DateTime.parse('2025-06-11T04:01:00.000Z'),
                    memberCount: 1,
                    unreadCount: 4,
                  ),
                  onTap: () {},
                  lastMessage: 'Hello, how are you?',
                ),
                ChatTile(
                  chat: ChatModel(
                    id: 'game-683f6319efedb5ee31de55e6',
                    name: 'Volleyball with A C on Wednesday',
                    gameId: '683f6319efedb5ee31de55e6',
                    gameAddress:
                        '555 California St, Financial District, San Francisco',
                    gameSport: 'Basketball',
                    gameDatetime: DateTime.parse('2025-06-11T04:01:00.000Z'),
                    memberCount: 1,
                    unreadCount: 0,
                  ),
                  onTap: () {},
                  lastMessage: 'On?',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
