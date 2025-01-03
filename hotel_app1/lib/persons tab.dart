import 'package:flutter/material.dart';

class RoomSelectionPage extends StatefulWidget {
  @override
  _RoomSelectionPageState createState() => _RoomSelectionPageState();
}

class _RoomSelectionPageState extends State<RoomSelectionPage> {
  int rooms = 1;
  int adults = 2;
  int children = 0;

  void _showRoomSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select rooms and guests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildCounterRow(
                    title: 'Rooms',
                    value: rooms,
                    onAdd: () => setModalState(() => rooms++),
                    onRemove: () => setModalState(() {
                      if (rooms > 1) rooms--;
                    }),
                  ),
                  _buildCounterRow(
                    title: 'Adults',
                    value: adults,
                    onAdd: () => setModalState(() => adults++),
                    onRemove: () => setModalState(() {
                      if (adults > 1) adults--;
                    }),
                  ),
                  _buildCounterRow(
                    title: 'Children',
                    value: children,
                    onAdd: () => setModalState(() => children++),
                    onRemove: () => setModalState(() {
                      if (children > 0) children--;
                    }),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Traveling with pets?', style: TextStyle(fontSize: 16)),
                      Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Apply'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCounterRow({
    required String title,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: onRemove,
              ),
              Text(value.toString(), style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Selection Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showRoomSelectionSheet,
          child: Text('Select Guests'),
        ),
      ),
    );
  }
}
