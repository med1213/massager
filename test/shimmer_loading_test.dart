import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clone_messagers/widgets/shimmer_loading.dart';

void main() {
  group('Shimmer Loading Tests', () {
    testWidgets('ShimmerLoading shows child when not loading', (
      WidgetTester tester,
    ) async {
      const testChild = Text('Test Content');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(isLoading: false, child: testChild),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('ShimmerLoading shows shimmer effect when loading', (
      WidgetTester tester,
    ) async {
      const testChild = Text('Test Content');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ShimmerLoading(isLoading: true, child: testChild),
          ),
        ),
      );

      // The child should still be there but with shimmer effect
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('ShimmerBox renders with correct dimensions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ShimmerBox(width: 100, height: 50)),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxWidth, 100);
      expect(container.constraints?.maxHeight, 50);
    });

    testWidgets('ShimmerLine renders with correct width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShimmerLine(width: 150))),
      );

      expect(find.byType(ShimmerBox), findsOneWidget);
    });

    testWidgets('ShimmerCircle renders as circular', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ShimmerCircle(size: 60))),
      );

      final shimmerBox = tester.widget<ShimmerBox>(find.byType(ShimmerBox));
      expect(shimmerBox.width, 60);
      expect(shimmerBox.height, 60);
      expect(shimmerBox.borderRadius, BorderRadius.circular(30));
    });
  });
}
