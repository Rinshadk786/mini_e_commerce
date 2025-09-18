import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  final List<Map<String, dynamic>> reports = [
    {"title": "Polling Report", "icon": Icons.bar_chart},
    {"title": "Voting Page", "icon": Icons.how_to_vote},
    {"title": "Entry Report", "icon": Icons.insert_chart_outlined},
    {"title": "Pending Voters", "icon": Icons.access_time},
    {"title": "Voted Voters", "icon": Icons.how_to_reg},
    {"title": "AI Report", "icon": Icons.auto_awesome},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("All Reports"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: reports.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 cards per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final report = reports[index];
            return ClipPath(
              clipper: FolderClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      report["icon"],
                      color: Colors.deepOrange,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      report["title"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom folder shape with a small tab on top-left
class FolderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double tabWidth = size.width * 0.25;
    double tabHeight = size.height * 0.15;
    double radius = 30;

    Path path = Path();
    path.moveTo(0, tabHeight);
    path.lineTo(tabWidth, tabHeight);
    path.lineTo(tabWidth + 10, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, tabHeight);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
