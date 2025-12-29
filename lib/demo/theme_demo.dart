import 'package:flutter/material.dart';
import '../theme/messenger_theme.dart';
import '../widgets/message_bubble.dart';
import '../models/message.dart';

/// Demo screen to showcase the Messenger theme
class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final sampleMessage = Message(
      id: '1',
      content: 'This is a sample message to showcase the theme!',
      senderId: 'user1',
      timestamp: DateTime.now(),
      isRead: true,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color palette showcase
            Text('Color Palette', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ColorSwatch('Primary Blue', MessengerTheme.primaryBlue),
                _ColorSwatch('Light Blue', MessengerTheme.lightBlue),
                _ColorSwatch('Background', MessengerTheme.backgroundWhite),
                _ColorSwatch(
                  'Secondary BG',
                  MessengerTheme.secondaryBackground,
                ),
                _ColorSwatch('Text Primary', MessengerTheme.textPrimary),
                _ColorSwatch('Text Secondary', MessengerTheme.textSecondary),
                _ColorSwatch('Border', MessengerTheme.borderColor),
                _ColorSwatch(
                  'Message Bubble',
                  MessengerTheme.messageBubbleReceived,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Typography showcase
            Text('Typography', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('Title Large', style: theme.textTheme.titleLarge),
            Text('Title Medium', style: theme.textTheme.titleMedium),
            Text('Body Large', style: theme.textTheme.bodyLarge),
            Text('Body Medium', style: theme.textTheme.bodyMedium),
            Text('Body Small', style: theme.textTheme.bodySmall),
            Text('Label Large', style: theme.textTheme.labelLarge),
            Text('Label Medium', style: theme.textTheme.labelMedium),
            Text('Label Small', style: theme.textTheme.labelSmall),
            const SizedBox(height: 32),

            // Message bubbles showcase
            Text('Message Bubbles', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            MessageBubble(message: sampleMessage, isSentByCurrentUser: true),
            const SizedBox(height: 8),
            MessageBubble(
              message: sampleMessage.copyWith(
                content: 'This is a received message',
              ),
              isSentByCurrentUser: false,
            ),
            const SizedBox(height: 32),

            // Buttons showcase
            Text('Buttons', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                const SizedBox(width: 8),
                TextButton(onPressed: () {}, child: const Text('Text')),
                const SizedBox(width: 8),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              ],
            ),
            const SizedBox(height: 32),

            // Input field showcase
            Text('Input Fields', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(hintText: 'Type a message...'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorSwatch(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
