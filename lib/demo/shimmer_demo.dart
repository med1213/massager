import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

/// Demo screen to showcase shimmer loading effects
class ShimmerDemo extends StatefulWidget {
  const ShimmerDemo({super.key});

  @override
  State<ShimmerDemo> createState() => _ShimmerDemoState();
}

class _ShimmerDemoState extends State<ShimmerDemo> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Loading Demo'),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shimmer Loading Effects',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Toggle button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = !_isLoading;
                });
              },
              child: Text(_isLoading ? 'Stop Loading' : 'Start Loading'),
            ),
            const SizedBox(height: 24),

            // Conversation List Shimmer
            Text(
              'Conversation List Shimmer',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isLoading
                  ? const ConversationListShimmer(itemCount: 4)
                  : ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text('Contact ${index + 1}'),
                          subtitle: Text(
                            'Last message from contact ${index + 1}',
                          ),
                          trailing: const Text('2:30 PM'),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),

            // Chat Messages Shimmer
            Text(
              'Chat Messages Shimmer',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isLoading
                  ? const ChatShimmer(messageCount: 5)
                  : ListView(
                      children: [
                        ListTile(
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'Hello there!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: const Text('Hi! How are you?'),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'I\'m doing great, thanks!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 24),

            // Individual Shimmer Components
            Text(
              'Individual Shimmer Components',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // Shimmer Box
            Row(
              children: [
                const Text('Shimmer Box: '),
                ShimmerLoading(
                  isLoading: _isLoading,
                  child: const ShimmerBox(width: 100, height: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Shimmer Line
            Row(
              children: [
                const Text('Shimmer Line: '),
                ShimmerLoading(
                  isLoading: _isLoading,
                  child: const ShimmerLine(width: 150),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Shimmer Circle
            Row(
              children: [
                const Text('Shimmer Circle: '),
                ShimmerLoading(
                  isLoading: _isLoading,
                  child: const ShimmerCircle(size: 40),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Custom Shimmer Example
            Text(
              'Custom Shimmer Example',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ShimmerLoading(
              isLoading: _isLoading,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 200,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
