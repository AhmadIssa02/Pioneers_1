import 'package:flutter/material.dart';

class ServiceData {
  final String name;
  final IconData icon;

  ServiceData({required this.name, required this.icon});
}

List<ServiceData> servicesList = [
  ServiceData(name: 'Transfers', icon: Icons.compare_arrows),
  ServiceData(name: 'Cliq', icon: Icons.credit_card),
  ServiceData(name: 'Western Union', icon: Icons.local_shipping),
  ServiceData(name: 'Request Money', icon: Icons.account_balance_wallet),
  ServiceData(name: 'Pay Bills', icon: Icons.receipt_long),
  ServiceData(name: 'Withdraw Cardless', icon: Icons.phone_android),
  ServiceData(name: 'Request History', icon: Icons.history),
  ServiceData(name: 'QR Payments', icon: Icons.qr_code),
  ServiceData(name: 'Open Extra Account', icon: Icons.account_box),
  ServiceData(name: 'Manage Cheques', icon: Icons.article),
  ServiceData(name: 'Letter of Guarantee', icon: Icons.note_alt),
  ServiceData(name: 'ATMs/Branches', icon: Icons.location_city),
];
