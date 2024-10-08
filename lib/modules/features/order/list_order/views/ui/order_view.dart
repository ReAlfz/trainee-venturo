import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/order_top_bar.dart';
import 'history_order_tap.dart';
import 'ongoing_order_tap.dart';

class OrderView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: OrderTopBar(),
        body: TabBarView(
          children: [
            OnGoingOrderTabView(),
            HistoryOrderTapView(),
          ],
        ),
      ),
    );
  }
}