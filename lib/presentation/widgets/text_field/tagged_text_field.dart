import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Tagged TextField Example')),
        body: TaggingWidget(),
      ),
    );
  }
}

class TaggingWidget extends StatefulWidget {
  @override
  _TaggingWidgetState createState() => _TaggingWidgetState();
}

class _TaggingWidgetState extends State<TaggingWidget> {
  final TextEditingController _controller = TextEditingController();
  List<String> _tags = [];

  void _handleSubmitted(String value) {
    setState(() {
      _tags.add(value);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter tags',
            ),
            onSubmitted: _handleSubmitted,
            onChanged: (value) {
              if (value.endsWith(',')) {
                String tag = value.substring(0, value.length - 1).trim();
                if (tag.isNotEmpty) {
                  _handleSubmitted(tag);
                }
              }
            },
          ),
          Wrap(
            children: _tags.map((tag) => Chip(
              label: Text(tag),
              onDeleted: () {
                setState(() {
                  _tags.remove(tag);
                });
              },
            )).toList(),
          ),
        ],
      ),
    );
  }
}
