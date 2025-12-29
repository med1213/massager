# Design Document: Messenger UI Clone

## Overview

This design outlines a Flutter application that replicates Facebook Messenger's core user interface and functionality. The app will feature a conversation list, individual chat screens, message composition, and authentic Messenger-style visual design. The architecture emphasizes clean separation of concerns, reactive state management, and smooth user experience.

## Architecture

### High-Level Architecture

The application follows a layered architecture pattern:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  (Screens, Widgets, State Notifiers)│
├─────────────────────────────────────┤
│           Business Logic Layer      │
│     (Services, Use Cases)           │
├─────────────────────────────────────┤
│             Data Layer              │
│    (Models, Repositories)           │
└─────────────────────────────────────┘
```

### State Management

The application uses **Riverpod** for state management, providing:

- Reactive state updates across the app
- Dependency injection for services and repositories
- Compile-time safety and better testing support
- Automatic disposal of resources

### Navigation

Flutter's built-in navigation system with named routes:

- `/` - Conversation List (Home)
- `/chat/:conversationId` - Individual Chat Screen

## Components and Interfaces

### Core Models

#### Message Model

```dart
class Message {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type; // text, image, etc.
}
```

#### Conversation Model

```dart
class Conversation {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final List<String> participantIds;
  final String? avatarUrl;
}
```

#### Contact Model

```dart
class Contact {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;
}
```

### Key Components

#### ConversationListScreen

- Displays all conversations in a scrollable list
- Shows conversation previews with last message and timestamp
- Handles navigation to individual chats
- Displays unread message indicators

#### ChatScreen

- Shows message history in chronological order
- Handles message input and sending
- Implements proper message bubble styling
- Auto-scrolls to latest messages

#### MessageBubble Widget

- Reusable component for displaying individual messages
- Adapts styling based on sender (sent vs received)
- Includes timestamp and read status indicators
- Supports different message types

#### MessageComposer Widget

- Text input field with send button
- Handles message composition and submission
- Provides visual feedback for user interactions
- Manages keyboard interactions

### State Providers

#### ConversationProvider

```dart
final conversationProvider = StateNotifierProvider<ConversationNotifier, List<Conversation>>(
  (ref) => ConversationNotifier(),
);
```

#### MessagesProvider

```dart
final messagesProvider = StateNotifierProvider.family<MessagesNotifier, List<Message>, String>(
  (ref, conversationId) => MessagesNotifier(conversationId),
);
```

#### ContactsProvider

```dart
final contactsProvider = StateNotifierProvider<ContactsNotifier, List<Contact>>(
  (ref) => ContactsNotifier(),
);
```

## Data Models

### Message Data Structure

- **ID**: Unique identifier for each message
- **Content**: Text content of the message
- **Sender ID**: Reference to the message sender
- **Timestamp**: When the message was sent
- **Read Status**: Whether the message has been read
- **Type**: Message type (text, image, etc.)

### Conversation Data Structure

- **ID**: Unique conversation identifier
- **Title**: Display name for the conversation
- **Participants**: List of user IDs in the conversation
- **Last Message**: Preview text of the most recent message
- **Last Message Time**: Timestamp of the most recent message
- **Unread Count**: Number of unread messages
- **Avatar**: Profile picture or group icon

### Sample Data Structure

The app will initialize with sample conversations and messages to demonstrate functionality:

```dart
final sampleConversations = [
  Conversation(
    id: '1',
    title: 'John Doe',
    lastMessage: 'Hey, how are you doing?',
    lastMessageTime: DateTime.now().subtract(Duration(minutes: 5)),
    unreadCount: 2,
    participantIds: ['user1', 'john'],
  ),
  // Additional sample conversations...
];
```

## Visual Design Specifications

### Color Palette

Based on Facebook Messenger's current design system:

- **Primary Blue**: `#00C6FF` (message bubbles, send button)
- **Light Blue**: `#E3F2FD` (received message bubbles)
- **Background**: `#FFFFFF` (main background)
- **Secondary Background**: `#F5F5F5` (conversation list background)
- **Text Primary**: `#1C1E21` (main text)
- **Text Secondary**: `#65676B` (timestamps, secondary text)
- **Border**: `#E4E6EA` (dividers, input borders)

### Typography

- **Primary Font**: System default (San Francisco on iOS, Roboto on Android)
- **Message Text**: 16sp, regular weight
- **Conversation Title**: 16sp, medium weight
- **Timestamp**: 12sp, regular weight
- **Last Message Preview**: 14sp, regular weight

### Spacing and Layout

- **Screen Padding**: 16px horizontal
- **List Item Padding**: 16px vertical, 16px horizontal
- **Message Bubble Padding**: 12px vertical, 16px horizontal
- **Message Spacing**: 8px between consecutive messages
- **Border Radius**: 18px for message bubbles, 8px for input fields

### Message Bubble Styling

- **Sent Messages**:
  - Background: Primary Blue (`#00C6FF`)
  - Text: White
  - Alignment: Right
  - Max width: 80% of screen width
- **Received Messages**:
  - Background: Light Gray (`#F0F0F0`)
  - Text: Primary Text (`#1C1E21`)
  - Alignment: Left
  - Max width: 80% of screen width

## Error Handling

### Network Error Handling

- Display user-friendly error messages for connectivity issues
- Implement retry mechanisms for failed message sends
- Show offline indicators when appropriate

### Input Validation

- Prevent sending empty messages
- Handle special characters and emojis properly
- Validate message length limits

### State Error Handling

- Graceful degradation when data loading fails
- Error boundaries to prevent app crashes
- Fallback UI states for missing data

## Testing Strategy

The testing approach combines unit tests for business logic and property-based tests for universal correctness properties.

### Unit Testing

- Test individual widgets in isolation
- Verify state management logic
- Test data model serialization/deserialization
- Mock external dependencies for consistent testing

### Property-Based Testing

Property-based tests will use the `test` package with custom generators to verify universal properties across many inputs. Each test will run a minimum of 100 iterations to ensure comprehensive coverage.

**Testing Framework**: Flutter's built-in `test` package with custom property-based testing utilities.

**Test Configuration**: Each property test will be tagged with the format:
`Feature: messenger-ui-clone, Property {number}: {property_text}`

## Correctness Properties

_A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees._

### Property 1: Conversation List Rendering Completeness

_For any_ conversation in the conversation list, the rendered UI should contain the contact name, last message preview, timestamp, and avatar element, with unread conversations displaying a visual indicator.
**Validates: Requirements 1.2, 1.3, 4.4**

### Property 2: Conversation Sorting Consistency

_For any_ set of conversations with different timestamps, the conversation list should display them ordered by most recent activity first.
**Validates: Requirements 1.4**

### Property 3: Message Display Consistency

_For any_ message in a chat, the message bubble should include timestamp information, with sent messages aligned right with blue styling and received messages aligned left with gray styling.
**Validates: Requirements 2.2, 2.3, 2.4**

### Property 4: Message Chronological Ordering

_For any_ chat with multiple messages, all messages should be displayed in chronological order from oldest to newest.
**Validates: Requirements 2.1**

### Property 5: Navigation Functionality

_For any_ conversation in the list, tapping it should navigate to the corresponding chat screen, and the chat screen should provide a back button to return to the conversation list.
**Validates: Requirements 1.5, 5.1**

### Property 6: Message Composition Workflow

_For any_ valid message content, the composition workflow should allow typing in the composer, activate the send button, add the message to the conversation when sent, clear the input field, and maintain focus.
**Validates: Requirements 3.2, 3.3, 3.4**

### Property 7: Auto-scroll Behavior

_For any_ chat screen, loading the chat should auto-scroll to the most recent message, and sending a new message should auto-scroll to show the newly sent message.
**Validates: Requirements 2.5, 3.5**

### Property 8: Data Model Structure Validation

_For any_ message or conversation object, it should contain all required fields: messages must have sender, content, timestamp, and read status; conversations must have participant information and metadata.
**Validates: Requirements 6.2, 6.3**

### Property 9: UI State Persistence

_For any_ navigation sequence, returning to the conversation list should preserve the previous state and scroll position, and reopening the app should remember the last viewed screen.
**Validates: Requirements 5.2, 5.3**

### Property 10: Layout Adaptation

_For any_ screen size or content length variation, the app should adapt layouts appropriately, with message bubbles wrapping long text and the conversation list handling varying content lengths gracefully.
**Validates: Requirements 7.1, 7.4, 7.5**

### Property 11: Keyboard Layout Adjustment

_For any_ chat screen, when the keyboard appears, the layout should adjust to keep the message composer visible and accessible.
**Validates: Requirements 7.2**

### Property 12: Color Scheme Consistency

_For any_ UI element in the app, it should use colors from the specified Messenger color palette (primary blue #00C6FF, light blue #E3F2FD, etc.).
**Validates: Requirements 4.1**

### Property 13: Message Bubble Styling

_For any_ message bubble, it should have rounded corners and consistent visual styling according to the design specifications.
**Validates: Requirements 4.3**

### Property 14: Conversation Updates

_For any_ new message added to a conversation, the conversation's timestamp and unread count should be updated accordingly.
**Validates: Requirements 6.5**

### Property 15: Composer UI Consistency

_For any_ chat screen, the message composer should be displayed at the bottom of the screen and remain accessible.
**Validates: Requirements 3.1**

### Integration Testing

- Test complete user workflows (viewing conversations, sending messages)
- Verify navigation flows between screens
- Test state management across screen transitions
- Validate data persistence and restoration

### Widget Testing

- Test individual UI components in isolation
- Verify widget rendering with different data inputs
- Test user interaction handling (taps, text input)
- Validate responsive layout behavior

**Property-Based Test Configuration:**

- Each property test runs minimum 100 iterations
- Tests use custom generators for realistic data
- Each test is tagged with: `Feature: messenger-ui-clone, Property {number}: {property_text}`
- Property tests focus on universal behaviors across all valid inputs
- Unit tests complement property tests by covering specific examples and edge cases
