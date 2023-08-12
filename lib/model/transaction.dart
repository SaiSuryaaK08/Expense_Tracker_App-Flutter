import 'package:flutter/material.dart';

class Transaction{
  final String Id;
  final String title;
  final DateTime date;
  final double amount;



  Transaction({
    required this.Id,
    required this.title,
    required this.date,
    required this.amount}
      );//Named argument other way is called positional argument

}