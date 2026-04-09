import 'package:flutter/material.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

class AiNutritionChatScreen extends StatefulWidget {
  final bool autoStartChat;

  const AiNutritionChatScreen({
    super.key,
    this.autoStartChat = false,
  });

  @override
  State<AiNutritionChatScreen> createState() => _AiNutritionChatScreenState();
}

class _AiNutritionChatScreenState extends State<AiNutritionChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();

    _messages.add({
      'isAi': true,
      'text':
      "Hello! I'm your AI Coach. How I can help you today?",
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'isAi': false,
        'text': text,
      });
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Widget _aiAvatar(ThemeData theme, Size size) {
    return ClipOval(
      child: Image.asset(
        'assets/images/profile1.png',
        width: size.width * 0.1,
        height: size.width * 0.1,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size.width * 0.1,
          height: size.width * 0.1,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.smart_toy_rounded,
            size: size.width * 0.085,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _previewBubble({
    required ThemeData theme,
    required Size size,
    required bool isAi,
    required String text,
  }) {
    return Row(
      mainAxisAlignment:
      isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isAi) ...[
          _aiAvatar(theme, size),
          SizedBox(width: size.width * 0.025),
        ],
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: isAi
                  ? theme.colorScheme.surfaceContainerHighest
                  : theme.colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isAi ? 4 : 16),
                bottomRight: Radius.circular(isAi ? 16 : 4),
              ),
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: "poppin",
                color: theme.colorScheme.onSurface,
                height: 1.45,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatMessages(ThemeData theme, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.01,
      ),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: _messages.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(height: size.height * 0.013),
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _previewBubble(
            theme: theme,
            size: size,
            isAi: message['isAi'],
            text: message['text'],
          );
        },
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme, Size size) {
    return Container(
      padding: EdgeInsets.only(
        top: size.height * 0.015,
        bottom: size.height * 0.04,
        right: size.height * 0.02,
        left: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff3A8DD9).withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Color(0xFF2196F3),
            size: size.width * 0.07,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Container(
              height: size.height * 0.055,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: "poppin",
                        color: theme.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: "poppin",
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.42),
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.attach_file_rounded,
                    color:Color(0xFF2196F3),
                    size: size.width * 0.055,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          GestureDetector(
            onTap: _sendMessage,
            child: Icon(
              Icons.send_rounded,
              color: const Color(0xFF2196F3),
              size: size.width * 0.07,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: () => Navigator.pop(context)),
                  Text(
                    'AI Coach',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * 0.15,
                    height: size.height * 0.07,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: size.width * 0.15,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.restaurant,
                        color: theme.colorScheme.primary,
                        size: size.width * 0.07,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: size.height * 0.02),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.01),
                    _buildChatMessages(theme, size),
                  ],
                ),
              ),
            ),
            _buildInputBar(theme, size),
          ],
        ),
      ),
    );
  }
}