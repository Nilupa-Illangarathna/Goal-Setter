import 'package:flutter/material.dart';

import '../../data_classes/sub classes/quote_class.dart';

class QuoteWidget extends StatelessWidget {
  final Quote quote;

  const QuoteWidget({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0, // Remove the elevation
      child: ListTile(
        // title: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 4.0),
        //   child: Text(
        //     'Quote:',
        //     style: TextStyle(
        //       fontSize: 24.0,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.indigo,
        //     ), // Use the specified headerTextStyle directly
        //   ),
        // ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${quote.text}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,color: Colors.green.withOpacity(0.8)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Author: ${quote.author}',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey, // Change to the specified buttonTextStyle color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}