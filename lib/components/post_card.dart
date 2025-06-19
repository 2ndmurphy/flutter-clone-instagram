import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int postIndex;
  const PostCard({super.key, required this.postIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(),
          _buildPostImage(),
          _buildPostActions(),
          _buildCaption(),
        ],
      ),
    );
  }

  Widget _buildPostHeader() {
    final imageUrl =
        'https://randomuser.me/api/portraits/men/${postIndex + 1}.jpg';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: ClipOval(
              child: Container(
                color: Colors.grey[300],
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'User ${postIndex + 1}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    final imageUrl = 'https://picsum.photos/seed/${postIndex + 10}/300/300';

    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.grey[200],
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image, color: Colors.black54),
              ),
        ),
      ),
    );
  }

  Widget _buildPostActions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(Icons.favorite_border, size: 24),
          SizedBox(width: 16),
          Icon(Icons.chat_bubble_outline, size: 24),
          SizedBox(width: 16),
          Icon(Icons.send_outlined, size: 24),
          Spacer(),
          Icon(Icons.bookmark_border, size: 24),
        ],
      ),
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'User ${postIndex + 1} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  'This is a simple caption for post ${postIndex + 1}. #simple #instagram #clone',
            ),
          ],
        ),
      ),
    );
  }
}
