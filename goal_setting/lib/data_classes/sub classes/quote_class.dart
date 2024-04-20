import 'package:flutter/material.dart';

// Quote Class
class Quote {
  String id; // Unique identifier for each quote
  String text;
  String author;

  // Constructor
  Quote({
    required this.id,
    required this.text,
    required this.author
  });

  // Getter and Setter for ID
  String get quoteId => id;
  set quoteId(String value) => id = value;

  // Getter and Setter for Text
  String get quoteText => text;
  set quoteText(String value) => text = value;

  // Getter and Setter for Author
  String get quoteAuthor => author;
  set quoteAuthor(String value) => author = value;

  // Convert Quote object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'author': author
    };
  }

  // Create Quote object from JSON
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      text: json['text'],
      author: json['author']
    );
  }

  // Print Method
  void printData() {
    print('Quote Data:');
    print('ID: $id');
    print('Text: $text');
    print('Author: $author');
  }
}