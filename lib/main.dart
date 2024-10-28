import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IconDock(),
    );
  }
}

class IconDock extends StatefulWidget {
  const IconDock({super.key});

  @override
  State<IconDock> createState() => _IconDockState();
}

class _IconDockState extends State<IconDock> {
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.settings,
    Icons.notifications,
    Icons.person,
  ];

  int? draggingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draggable Icon Dock"),
      ),
      body: Center(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(icons.length, (index) {
              return buildDraggableIcon(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget buildDraggableIcon(int index) {
    return DragTarget<int>(
      onAccept: (draggedIndex) {
        setState(() {
          // Swap icons
          final temp = icons[draggedIndex];
          icons[draggedIndex] = icons[index];
          icons[index] = temp;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<int>(
          data: index,
          feedback: Opacity(
            opacity: 0.7,
            child: buildIcon(icons[index]),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: buildIcon(icons[index]),
          ),
          child: buildIcon(icons[index]),
        );
      },
    );
  }

  Widget buildIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(
        iconData,
        size: 50,
      ),
    );
  }
}
