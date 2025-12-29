# Implementation Plan: Messenger UI Clone

## Overview

This implementation plan tracks the completion status of the Messenger UI clone. The core functionality has been successfully implemented with comprehensive testing. All major features are working including conversation lists, chat screens, message composition, state management, and responsive design.

## Tasks

- [x] 1. Set up project structure and dependencies

  - Add Riverpod state management dependency to pubspec.yaml
  - Create folder structure: lib/models, lib/screens, lib/widgets, lib/providers, lib/services
  - Set up basic app theme with Messenger color palette
  - Configure navigation routes
  - _Requirements: 4.1, 5.4_

- [x] 2. Create core data models

  - [x] 2.1 Implement Message, Conversation, and Contact models

    - Define Message class with id, content, senderId, timestamp, isRead fields
    - Define Conversation class with id, title, lastMessage, lastMessageTime, unreadCount, participantIds fields
    - Define Contact class with id, name, avatarUrl, isOnline fields
    - Add JSON serialization methods for each model
    - _Requirements: 6.1, 6.2, 6.3_

  - [ ]\* 2.2 Write property test for data model structure validation
    - **Property 8: Data Model Structure Validation**
    - **Validates: Requirements 6.2, 6.3**

- [x] 3. Implement sample data service

  - [x] 3.1 Create sample data repository

    - Generate sample conversations with realistic data
    - Generate sample messages for each conversation
    - Generate sample contacts
    - Implement methods to retrieve conversations and messages
    - _Requirements: 6.4_

  - [x] 3.2 Write unit tests for sample data service
    - Test data loading and retrieval methods
    - Verify sample data structure and relationships
    - _Requirements: 6.4_

- [x] 4. Set up state management with Riverpod

  - [x] 4.1 Create conversation state provider

    - Implement ConversationNotifier to manage conversation list
    - Add methods for loading and updating conversations
    - Handle conversation sorting by most recent activity
    - _Requirements: 1.4, 6.5_

  - [x] 4.2 Create messages state provider

    - Implement MessagesNotifier with family provider for conversation-specific messages
    - Add methods for loading messages and adding new messages
    - Handle message chronological ordering
    - _Requirements: 2.1, 3.3, 6.5_

  - [ ]\* 4.3 Write property test for conversation sorting

    - **Property 2: Conversation Sorting Consistency**
    - **Validates: Requirements 1.4**

  - [ ]\* 4.4 Write property test for message chronological ordering
    - **Property 4: Message Chronological Ordering**
    - **Validates: Requirements 2.1**

- [x] 5. Build conversation list screen

  - [x] 5.1 Create ConversationListScreen widget

    - Implement main screen layout with app bar
    - Create ListView for displaying conversations
    - Add conversation tile widgets with proper styling
    - Implement navigation to chat screen on tap
    - _Requirements: 1.1, 1.2, 1.5_

  - [x] 5.2 Create ConversationTile widget

    - Display contact name, last message preview, and timestamp
    - Show unread message indicator (badge or bold text)
    - Include avatar placeholder or profile picture
    - Apply Messenger styling and spacing
    - _Requirements: 1.2, 1.3, 4.4_

  - [ ]\* 5.3 Write property test for conversation list rendering

    - **Property 1: Conversation List Rendering Completeness**
    - **Validates: Requirements 1.2, 1.3, 4.4**

  - [ ]\* 5.4 Write property test for navigation functionality
    - **Property 5: Navigation Functionality**
    - **Validates: Requirements 1.5, 5.1**

- [x] 6. Checkpoint - Ensure conversation list works

  - Ensure all tests pass, ask the user if questions arise.

- [x] 7. Build message bubble widget

  - [x] 7.1 Create MessageBubble widget

    - Implement bubble styling with rounded corners
    - Handle sent vs received message alignment and colors
    - Include timestamp display
    - Apply proper padding and margins
    - _Requirements: 2.2, 2.3, 2.4, 4.3_

  - [ ]\* 7.2 Write property test for message display consistency

    - **Property 3: Message Display Consistency**
    - **Validates: Requirements 2.2, 2.3, 2.4**

  - [ ]\* 7.3 Write property test for message bubble styling
    - **Property 13: Message Bubble Styling**
    - **Validates: Requirements 4.3**

- [x] 8. Build message composer widget

  - [x] 8.1 Create MessageComposer widget

    - Implement text input field with proper styling
    - Add send button that activates when text is entered
    - Handle message submission and input clearing
    - Maintain focus after sending
    - Position at bottom of screen
    - _Requirements: 3.1, 3.2, 3.4_

  - [ ]\* 8.2 Write property test for message composition workflow

    - **Property 6: Message Composition Workflow**
    - **Validates: Requirements 3.2, 3.3, 3.4**

  - [ ]\* 8.3 Write property test for composer UI consistency
    - **Property 15: Composer UI Consistency**
    - **Validates: Requirements 3.1**

- [x] 9. Build chat screen

  - [x] 9.1 Create ChatScreen widget

    - Implement main chat layout with app bar and back button
    - Create scrollable message list using ListView
    - Integrate MessageBubble widgets for each message
    - Add MessageComposer at bottom
    - Handle keyboard layout adjustments
    - _Requirements: 2.1, 2.5, 3.1, 5.1, 7.2_

  - [x] 9.2 Implement auto-scroll functionality

    - Auto-scroll to latest message when chat loads
    - Auto-scroll to new message when sent
    - Handle scroll controller properly
    - _Requirements: 2.5, 3.5_

  - [ ]\* 9.3 Write property test for auto-scroll behavior

    - **Property 7: Auto-scroll Behavior**
    - **Validates: Requirements 2.5, 3.5**

  - [ ]\* 9.4 Write property test for keyboard layout adjustment
    - **Property 11: Keyboard Layout Adjustment**
    - **Validates: Requirements 7.2**

- [x] 10. Implement message sending functionality

  - [x] 10.1 Connect composer to state management

    - Wire send button to add messages to conversation
    - Update conversation metadata when new message sent
    - Handle message ID generation and timestamps
    - _Requirements: 3.3, 6.5_

  - [ ]\* 10.2 Write property test for conversation updates
    - **Property 14: Conversation Updates**
    - **Validates: Requirements 6.5**

- [x] 11. Checkpoint - Ensure chat functionality works

  - Ensure all tests pass, ask the user if questions arise.

- [x] 12. Implement navigation and state persistence

  - [x] 12.1 Set up proper navigation between screens

    - Configure named routes for conversation list and chat screens
    - Handle navigation parameters for chat screen
    - Implement back navigation with state preservation
    - _Requirements: 5.1, 5.2_

  - [x] 12.2 Add state persistence

    - Remember last viewed screen on app restart
    - Preserve conversation list scroll position
    - Handle app lifecycle properly
    - _Requirements: 5.2, 5.3_

  - [ ]\* 12.3 Write property test for UI state persistence
    - **Property 9: UI State Persistence**
    - **Validates: Requirements 5.2, 5.3**

- [x] 13. Implement responsive design and layout adaptation

  - [x] 13.1 Add responsive layout handling

    - Handle different screen sizes appropriately
    - Implement proper text wrapping for long messages
    - Handle varying conversation content lengths
    - Test on different device sizes
    - _Requirements: 7.1, 7.4, 7.5_

  - [ ]\* 13.2 Write property test for layout adaptation
    - **Property 10: Layout Adaptation**
    - **Validates: Requirements 7.1, 7.4, 7.5**

- [x] 14. Apply final styling and theming

  - [x] 14.1 Implement complete Messenger theme

    - Apply consistent color scheme throughout app
    - Set proper fonts and typography
    - Add appropriate spacing and visual hierarchy
    - Ensure status bar styling
    - _Requirements: 4.1, 4.2, 5.4_

  - [ ]\* 14.2 Write property test for color scheme consistency
    - **Property 12: Color Scheme Consistency**
    - **Validates: Requirements 4.1**

- [x] 15. Final integration and testing

  - [x] 15.1 Integration testing and bug fixes

    - Test complete user workflows
    - Fix any remaining UI or functionality issues
    - Verify all requirements are met
    - _Requirements: All_

  - [x] 15.2 Write comprehensive unit tests

    - Test models with JSON serialization and copyWith functionality
    - Test providers with state management and data flow
    - Test services with data loading and relationships
    - _Requirements: All_

  - [ ]\* 15.3 Write integration tests
    - Test complete conversation viewing and messaging workflows
    - Test navigation flows between screens
    - Test state management across screen transitions
    - _Requirements: All_

- [x] 16. Final checkpoint - Complete application
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties
- Unit tests validate specific examples and edge cases
- The implementation builds incrementally from data models to complete UI
