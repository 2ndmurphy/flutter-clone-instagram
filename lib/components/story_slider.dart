import 'package:flutter/material.dart';

class StorySlider extends StatelessWidget {
  const StorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildStoryItem(index);
        },
      ),
    );
  }

  Widget _buildStoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: ClipOval(
              child: Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'IMG',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (index == 0)
            const Text(
              'Your Story',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
            )
          else
            Text('User ${index + 1}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
