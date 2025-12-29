# Shimmer Loading Effect

This document describes the shimmer loading effect implementation in the Messenger UI Clone application.

## Overview

The shimmer loading effect provides a smooth, animated placeholder while content is being loaded. This creates a better user experience by showing users that content is loading rather than displaying blank screens or simple loading spinners.

## Features

- **Smooth Animation**: Gradient animation that slides across placeholder content
- **Customizable**: Configurable colors, duration, and animation curves
- **Reusable Components**: Pre-built shimmer components for common UI elements
- **Performance Optimized**: Uses efficient shader-based animations

## Components

### Core Components

#### `ShimmerLoading`

The main shimmer wrapper widget that applies the shimmer effect to any child widget.

```dart
ShimmerLoading(
  isLoading: true,
  child: YourWidget(),
)
```

**Properties:**

- `isLoading`: Boolean to control when shimmer effect is active
- `child`: The widget to apply shimmer effect to
- `baseColor`: Base color of the shimmer (default: grey[300])
- `highlightColor`: Highlight color of the shimmer (default: grey[100])
- `duration`: Animation duration (default: 1500ms)

#### `ShimmerBox`

A rectangular placeholder with shimmer effect.

```dart
ShimmerBox(
  width: 100,
  height: 20,
  borderRadius: BorderRadius.circular(8),
)
```

#### `ShimmerLine`

A line-shaped placeholder, perfect for text placeholders.

```dart
ShimmerLine(
  width: 150,
  height: 16, // Optional, defaults to 16
)
```

#### `ShimmerCircle`

A circular placeholder, ideal for avatars.

```dart
ShimmerCircle(size: 40)
```

### Pre-built Shimmer Layouts

#### `ConversationTileShimmer`

Shimmer placeholder for conversation list items.

```dart
ConversationTileShimmer()
```

#### `ConversationListShimmer`

Complete shimmer layout for the conversation list screen.

```dart
ConversationListShimmer(itemCount: 8)
```

#### `MessageBubbleShimmer`

Shimmer placeholder for individual message bubbles.

```dart
MessageBubbleShimmer(
  isSentByCurrentUser: true,
  width: 200, // Optional
)
```

#### `ChatShimmer`

Complete shimmer layout for the chat screen.

```dart
ChatShimmer(messageCount: 6)
```

## Implementation

### Loading State Management

The app uses a dedicated `LoadingProvider` to manage loading states:

```dart
// Check if conversations are loading
final isLoading = ref.watch(isLoadingConversationsProvider);

// Check if messages are loading for a specific conversation
final isLoadingMessages = ref.watch(isLoadingMessagesProvider(conversationId));
```

### Usage in Screens

#### Conversation List Screen

```dart
body: isLoading
    ? const ConversationListShimmer()
    : ListView.builder(
        itemBuilder: (context, index) {
          return ConversationTile(conversation: conversations[index]);
        },
      ),
```

#### Chat Screen

```dart
body: isLoadingMessages
    ? const ChatShimmer()
    : ListView.builder(
        itemBuilder: (context, index) {
          return MessageBubble(message: messages[index]);
        },
      ),
```

## Customization

### Custom Shimmer Colors

```dart
ShimmerLoading(
  isLoading: true,
  baseColor: Colors.grey[400],
  highlightColor: Colors.white,
  child: YourWidget(),
)
```

### Custom Animation Duration

```dart
ShimmerLoading(
  isLoading: true,
  duration: Duration(milliseconds: 2000),
  child: YourWidget(),
)
```

### Custom Shimmer Layout

```dart
ShimmerLoading(
  isLoading: true,
  child: Column(
    children: [
      ShimmerBox(width: double.infinity, height: 20),
      SizedBox(height: 8),
      ShimmerLine(width: 200),
      SizedBox(height: 8),
      Row(
        children: [
          ShimmerCircle(size: 40),
          SizedBox(width: 12),
          Expanded(child: ShimmerLine(width: double.infinity)),
        ],
      ),
    ],
  ),
)
```

## Demo

The app includes a shimmer demo screen accessible via the animation icon in the conversation list app bar. This demo showcases:

- All shimmer components
- Interactive loading toggle
- Different shimmer layouts
- Custom shimmer examples

To access the demo:

1. Open the app
2. Tap the animation icon (🎬) in the top-right corner of the conversation list
3. Use the toggle button to start/stop the shimmer effect

## Technical Details

### Animation Implementation

The shimmer effect uses Flutter's `ShaderMask` with a `LinearGradient` that translates across the widget using a custom `GradientTransform`. This provides smooth, hardware-accelerated animations.

### Performance Considerations

- Uses `SingleTickerProviderStateMixin` for efficient animation controller management
- Automatically stops animations when `isLoading` is false
- Disposes animation controllers properly to prevent memory leaks

### Loading Simulation

For demonstration purposes, the providers include artificial delays:

- Conversations: 1.5 second delay
- Messages: 1 second delay

In a real application, these delays would be replaced with actual network requests.

## Testing

The shimmer components include comprehensive tests covering:

- Shimmer effect activation/deactivation
- Component rendering with correct dimensions
- Animation controller lifecycle
- Loading state management

Run tests with:

```bash
flutter test test/shimmer_loading_test.dart
```

## Best Practices

1. **Use appropriate shimmer shapes**: Match the shimmer placeholder to the actual content shape
2. **Consistent timing**: Use similar loading durations across the app
3. **Responsive design**: Ensure shimmer placeholders work on different screen sizes
4. **Accessibility**: Consider screen reader users when implementing loading states
5. **Performance**: Only animate when necessary, stop animations when not loading

## Future Enhancements

Potential improvements for the shimmer loading system:

- Skeleton loading with more detailed content structure
- Shimmer direction customization (vertical, diagonal)
- Pulse animation variant
- Integration with network state management
- Automatic shimmer generation based on widget structure
