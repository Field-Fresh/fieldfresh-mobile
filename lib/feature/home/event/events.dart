import 'package:fieldfreshmobile/feature/home/bloc/home_event.dart';
import 'package:fieldfreshmobile/feature/home/bloc/side_type.dart';

/* Potential events that are triggered from the UI

1. User clicks on a "Top 10" product the "Market is buying."

2. User clicks on "View ALL" products the "Market is buying."

3. User clicks on a "Top 10" product the "Market is selling."

4. User clicks on "View All" products the "Market is selling."

5. User clicks on "Pending Orders."

6. User clicks on "Open Matches."

*/

class TopProductClickEvent extends HomePageEvent {
  final String productId;
  final Side side;

  TopProductClickEvent(this.productId, this.side) : super([productId, side]);

  @override
  String toString() => 'TopProductClickEvent';
}
