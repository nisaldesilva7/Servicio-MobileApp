import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/services/auth.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingProgress extends StatefulWidget{
   final int bookingProgress;
   const BookingProgress({Key key, this.bookingProgress}) : super(key: key);

  @override
  _BookingProgressState createState() => _BookingProgressState();
}

class _BookingProgressState extends State<BookingProgress> {
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF1049e6),
            Color(0xFF082e96),
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF5c65f7).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Upcoming Bookings',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: false,
            body: Column(
              children: <Widget>[
                Expanded(child: TimelineDelivery(bookingProgress: widget.bookingProgress)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class TimelineDelivery extends StatefulWidget {

  final int bookingProgress;
  const TimelineDelivery({Key key, this.bookingProgress}) : super(key: key);

  @override
  _TimelineDeliveryState createState() => _TimelineDeliveryState();
}

class _TimelineDeliveryState extends State<TimelineDelivery> {
  final AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild:
            widget.bookingProgress == 1  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ):
            widget.bookingProgress == 2  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ):widget.bookingProgress == 3  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ): widget.bookingProgress == 4  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ): widget.bookingProgress == 5  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ):
            _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_placed.png',
              title: 'VEHICLE REACHED',
              message: 'We have received your vehicle.',
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            rightChild:
            widget.bookingProgress == 1  ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ):
            widget.bookingProgress == 2  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ):
            widget.bookingProgress == 3  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ):widget.bookingProgress == 4  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ):widget.bookingProgress == 5  ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ):
            _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_placed.png',
              title: 'PROCESS STARTED',
              message: 'Your service has been started.',
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            indicatorStyle: const IndicatorStyle(
              indicator: _IconIndicator(
                iconData: Icons.calendar_today,
                size: 20,
                color: Colors.red,
              ),
//              indicatorY: 0.6,
              drawGap: true,
              width: 30,
              height: 30,
              padding: EdgeInsets.all(6),
            ),
            rightChild:
            widget.bookingProgress == 1 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ): widget.bookingProgress == 2 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ): widget.bookingProgress == 3 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ): widget.bookingProgress == 4 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ): widget.bookingProgress == 5 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ):
            _RightChild(
              disabled: true,
              asset: 'assets/delivery/order_processed.png',
              title: 'PROCESS FINISHED',
              message: 'We are preparing your order.',
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
            bottomLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFFDADADA),
              padding: EdgeInsets.all(6),
            ),
            rightChild:
            widget.bookingProgress == 1 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ):
            widget.bookingProgress == 2 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ): widget.bookingProgress == 3 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ):
            widget.bookingProgress == 4 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ): widget.bookingProgress == 5 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ): _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'READY TO PICKUP',
              message: 'Your vehicle is ready for pickup.',
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),

          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: 0.1,
            isLast: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFFDADADA),
              padding: EdgeInsets.all(6),
            ),
            rightChild:
            widget.bookingProgress == 1 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ): widget.bookingProgress == 2 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ): widget.bookingProgress == 3 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ): widget.bookingProgress == 4 ? _RightChild(
              disabled: true,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ): widget.bookingProgress == 5 ? _RightChild(
              disabled: false,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ):
            _RightChild(
              disabled: false,
              asset: 'assets/delivery/ready_to_pickup.png',
              title: 'SERVICE COMPLETED',
              message: 'Rate and Review Your Service....',
            ),
            topLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),


        ],
      ),
    );
  }
  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance.collection('Services').document('Flsu3hG8AMUvYAdpN2KT2FOoJ5A3').collection('ongoing').snapshots();
  }
}


class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    Key key,
    this.iconData,
    this.size,
    this.color,
  }) : super(key: key);

  final IconData iconData;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                iconData,
                size: size,
                color: color.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? Colors.grey[400]
                      :  Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? Colors.grey[400]
                      :  Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


