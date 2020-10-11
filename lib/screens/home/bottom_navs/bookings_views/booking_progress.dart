import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/services/auth.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingProgress extends StatefulWidget{
   final int bookingProgress;
   final String bookingId;
   final String serviceID;
   final String custId;
   const BookingProgress({Key key, this.bookingProgress,this.bookingId,this.serviceID, this.custId}) : super(key: key);

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
            Colors.indigoAccent,
            Colors.indigo,
          ],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF5c65f7).withOpacity(0.2),
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            title: Text(
              'Bookings Progress',
              style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: false,
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:8.0,bottom: 15,top: 25),
                child: Text('Current Status of the Booking', style: GoogleFonts.quicksand(fontSize: 17,color: Colors.white),),
              ),
              Expanded(child: TimelineDelivery(bookingProgress: widget.bookingProgress, bookingId:widget.bookingId, serviceID: widget.serviceID, custId: widget.custId)),
            ],
          ),
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class TimelineDelivery extends StatefulWidget {

  final int bookingProgress;
  final String bookingId;
  final String serviceID;
  final String custId;
  const TimelineDelivery({Key key, this.bookingProgress, this.bookingId,this.serviceID, this.custId}) : super(key: key);

  @override
  _TimelineDeliveryState createState() => _TimelineDeliveryState();
}

class _TimelineDeliveryState extends State<TimelineDelivery> {
  final AuthServices _auth = AuthServices();
  double rating = 0.0;
  TextEditingController controller = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
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
                    width: 20,
                    color: Colors.orangeAccent,
                    padding: EdgeInsets.all(6),
                  ),
                  rightChild:
                  widget.bookingProgress == 1 ? _RightChild(
                    disabled: true,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
                  ): widget.bookingProgress == 2 ? _RightChild(
                    disabled: true,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
                  ): widget.bookingProgress == 3 ? _RightChild(
                    disabled: false,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
                  ): widget.bookingProgress == 4 ? _RightChild(
                    disabled: false,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
                  ): widget.bookingProgress == 5 ? _RightChild(
                    disabled: false,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
                  ):
                  _RightChild(
                    disabled: true,
                    asset: 'assets/delivery/order_processed.png',
                    title: 'PROCESS FINISHED',
                    message: 'Your Service Process Finished.',
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
                    color: Color(0xFF1db884),
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
                    color: Color(0xFF827265),
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
                    disabled: true,
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
          ),
          widget.bookingProgress == 5 ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              child: Text("Rate and Review".toUpperCase(),
                style: GoogleFonts.quicksand(
                  fontSize: 20
                ),
              ),
              textColor: Colors.white,
              color: Colors.blueAccent,
              onPressed: () {
                _customAlertDialog(context, 'Add a Comment');
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0)),
            ),
          ): Container(),
        ],
      ),
    );
  }


  _customAlertDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Icon(
                          Icons.done_all,
                          color: Colors.red,
                          size: 50,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Your Services Process has been Completed',
                          style: GoogleFonts.quicksand(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Center(
                            child: SmoothStarRating(
                              rating: rating,
                              isReadOnly: false,
                              size: 40,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              borderColor: Color(0xffe3830e),
                              color: Color(0xffe3830e),
                              allowHalfRating: true,
                              spacing: 2.0,
                              onRated: (value) {
                                setState(() {
                                  rating = value;
                                });
                                print(" value -> $value");
                                print(" rating value -> $rating");
                              },
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Add Comment',
                              errorText: _validate ? 'Value Can\'t Be Empty' : null,
                            ),
                            controller: controller,
                          ),
                        ),
                        SizedBox(height: 10,),

                        Divider(),
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('Submit'),
                            onPressed: () async {
                              setState(()  {
                                controller.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                              if (_validate == false && rating != 0.0) {
                                final uid = await _auth.getCurrentUID();
                                await Firestore.instance.collection('Customers')
                                    .document(uid).collection('ongoing')
                                    .document(widget.bookingId).setData({
                                  'Rating': rating,
                                  'Comment': controller.text.toString(),
                                  'progressStage': 6,

                                },merge: true).then((docRef) {

                                  Firestore.instance.collection('Services')
                                      .document(widget.serviceID)
                                      .collection('ongoing')
                                      .document(widget.bookingId).setData({
                                    'Rating': rating,
                                    'Comment': controller.text.toString(),
                                    'progressStage': 6,
                                  },merge: true).then((value) {

                                  Firestore.instance.collection('Reviews')
                                      .add(
                                      {
                                        'Rating': rating,
                                        'Comment': controller.text.toString(),
                                        'BookingId': widget.bookingId,
                                        'CustId': widget.custId,
                                        'datetime': DateTime.now(),
                                        'serviceID': widget.serviceID
                                      }

                                  );
                                  }

                                  );
                                }
                                );
//                                var result = Firestore.instance.collection('Service').document(widget.serviceID).get();


                                print('Succesfully Rated');
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }

//                              DocumentSnapshot snapshot= await Firestore.instance.collection('Services').document(widget.serviceID).get();
//                              var channelName = snapshot['channelName'];
//                              print(channelName);


                            }
                          ),
                        ),
//                      SizedBox(
//                        width: double.infinity,
//                        child: FlatButton(
//                          padding: const EdgeInsets.all(5.0),
//                          child: Text('SKIP'),
//                          onPressed: () {
//                            Navigator.pop(context, true);
//                            Navigator.pop(context, true);
//                          }
//                        ),
//                      ),

                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
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
            color: Colors.white.withOpacity(0.9),
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
          disabled == false ? Icon(Icons.done_all,color: Colors.white,size: 28,):
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),

            strokeWidth: 4,
          ),
//          Opacity(
//            child: Image.asset(asset, height: 50),
//            opacity: disabled ? 0.5 : 1,
//          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.dmSans(
                  color: disabled
                      ? Colors.white24
                      :  Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.quicksand(
                  color: disabled
                      ? Colors.white24
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


