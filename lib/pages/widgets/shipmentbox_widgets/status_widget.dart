import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  final List<String> statusOptions;
  final String? currentStatus;

  StatusWidget({required this.statusOptions, this.currentStatus});

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.statusOptions.length,
      itemBuilder: (context, index) {
        final status = widget.statusOptions[index];
        final isSelected = status == widget.currentStatus;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
