import 'package:flutter/material.dart';
import 'components/story_slider.dart';
import 'components/post_card.dart';

class DashboardInstagram extends StatelessWidget {
  const DashboardInstagram({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Posts section
          Expanded(
            child: ListView.builder(
              itemCount: 11 + 1,
              itemBuilder: (context, index) {
                // If index is 0, return the StorySlider
                if (index == 0) {
                  return const StorySlider();
                }
                return PostCard(postIndex: index - 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
