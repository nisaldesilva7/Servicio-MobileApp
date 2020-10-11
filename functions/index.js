const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();


exports.sendToDevices  = functions.firestore
  .document('orders/{ordersId}')
  .onCreate(async snapshot => {

    const order = snapshot.data();
//    const querySnapshot = await db
//      .collection('Customers')
//      .document('fv7ICvE5V1f3LMTAGyXWvASgTty1')
//      .collection('tokens')
//      .get();


//    const querySnapshot = await db.document('Customers/fv7ICvE5V1f3LMTAGyXWvASgTty1/{tokens}/{tokensId}').get();
//     console.log('hello');

//const querySnapshot = await db.doc('Customers/${fv7ICvE5V1f3LMTAGyXWvASgTty1}/tokens/{tokensId}')
//      .get();
//
//    const tokens = querySnapshot.docs.map(snap => snap.id);
//     console.log(tokens);
//     payload = {
//      notification: {
//        title: 'Booking Confirmed',
//        body: 'nice',
//        click_action: 'FLUTTER_NOTIFICATION_CLICK'
//      }
//    };
//
//    return fcm.sendToDevice(tokens, payload);

var uid ='fv7ICvE5V1f3LMTAGyXWvASgTty1'
    // ref to the parent document
    const docRef = admin.firestore().collection('Customers').doc(uid)

    // get all comments and aggregate
    return docRef.collection('tokens')
         .get()
         .then(querySnapshot => {
           const recentComments = [];
            // add data from the 5 most recent comments to the array
            querySnapshot.forEach(doc => {
                recentComments.push( doc.data().token )
            });
            console.log(recentComments);
            payload = {
                  notification: {
                    title: 'Booking Confirmed',
                    body: order.msg,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                  }
                };

            return fcm.sendToDevice(recentComments, payload);
         })
         .catch(err => console.log(err) )
  });



//Function for booking Confirmation
exports.sendBookingConfirmation  = functions.firestore
                         .document('Services/{ServicesId}/Bookings/{BookingsId}')
                         .onUpdate(async (snapshot, context) => {

    const order = snapshot.after.data();
    const uid = snapshot.before.data().CustId;
    const serviceId = snapshot.before.data().ServiceName;
    const bookingStatus = snapshot.after.data().BookingStatus;
    console.log("The value of Booking  is " + context.params.BookingsId);
    console.log("The value of Service is " + context.params.ServicesId);

//    const serviceRef = admin.firestore().collection('Services').doc(serviceId).get()
//    const serviceName = serviceRef.before.date().Service_Name


    // ref to the parent document
    const docRef = admin.firestore().collection('Customers').doc(uid)
    // get all comments and aggregate
    return docRef.collection('tokens')
         .get()
         .then(querySnapshot => {
           const recentComments = [];
            // add data from the 5 most recent comments to the array
            querySnapshot.forEach(doc => {
                recentComments.push( doc.data().token )
            });
            console.log(recentComments);

            if(bookingStatus === "Declined"){
                payload = {
                      notification: {
                        title: 'Booking Declined By ' + serviceId,
                        body: order.ServiceType,
                        click_action: 'FLUTTER_NOTIFICATION_CLICK'
                      }
                    };
                }
             else if(bookingStatus === "Accepted"){
                 payload = {
                                  notification: {
                                    title: 'Booking Confirmed By ' + serviceId,
                                    body: order.ServiceType,
                                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                                  }
                                };
              }
              else if(bookingStatus === "Not Available"){
                               payload = {
                                                notification: {
                                                  title: 'Please Select Another Available Time' + serviceId,
                                                  body: order.ServiceType,
                                                  click_action: 'FLUTTER_NOTIFICATION_CLICK'
                                                }
                                              };
                            }

            return fcm.sendToDevice(recentComments, payload);
         })
         .catch(err => console.log(err) )
  });



//Function for booking Stages
exports.sendBookingProgress  = functions.firestore
                         .document('Customers/{CustomersId}/ongoing/{ongoingId}')
                         .onUpdate(async (snapshot, context) => {

    const ongoing = snapshot.after.data();
    const uid = snapshot.before.data().CustId;
    const ServiceName = snapshot.before.data().ServiceName;

    // ref to the parent document
    const docRef = admin.firestore().collection('Customers').doc(uid)
    // get all comments and aggregate
    return docRef.collection('tokens')
         .get()
         .then(querySnapshot => {
           const recentComments = [];
            // add data from the 5 most recent comments to the array
            querySnapshot.forEach(doc => {
                recentComments.push( doc.data().token )
            });
            console.log(recentComments);

            if(ongoing.progressStage  == 1){
            payload = {
                  notification: {
                    title: 'Vehicle Reached To ' + ServiceName,
                    body: ongoing.VehicleDetails.brand,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                  }
                };
            }
            else if(ongoing.progressStage == 2){
                        payload = {
                              notification: {
                                title: 'Service Started By ' + ServiceName,
                                body: ongoing.VehicleDetails.brand,
                                click_action: 'FLUTTER_NOTIFICATION_CLICK'
                              }
                            };
             }
              else if(ongoing.progressStage == 3){
                         payload = {
                               notification: {
                                 title: 'Service Finished By ' + ServiceName,
                                 body: ongoing.VehicleDetails.brand,
                                 click_action: 'FLUTTER_NOTIFICATION_CLICK'
                               }
                             };
              }
               else if(ongoing.progressStage == 4){
                                       payload = {
                                             notification: {
                                               title: 'Ready To Pick Up Your Vehicle Now',
                                               body: 'Please Pick Your Vehicle ' + ongoing.VehicleDetails.brand,
                                               click_action: 'FLUTTER_NOTIFICATION_CLICK'
                                             }
                                           };
               }
                else if(ongoing.progressStage == 5){
                                        payload = {
                                              notification: {
                                                title: 'Service Completed By ' + ServiceName,
                                                body: 'Please Rate and Review. Vehicle: ' + ongoing.VehicleDetails.brand,
                                                click_action: 'FLUTTER_NOTIFICATION_CLICK'
                                              }
                                            };
               }
               else if(ongoing.progressStage == 6){
                                                       payload = {
                                                             notification: {
                                                               title: ServiceName,
                                                               body: "Your Booking Process Fully Completed Now \n Thanks For Using Our Service\n " + ongoing.Vehicle,
                                                               click_action: 'FLUTTER_NOTIFICATION_CLICK'
                                                             }
                                                           };
                              }
                else{
                    payload = {
                      notification: {
                        title: 'Error Booking Progress in ' + ServiceName,
                        body: ongoing.Vehicle,
                        click_action: 'FLUTTER_NOTIFICATION_CLICK'
                  }
                };
            }


            console.log(ongoing.progressStage);
            return fcm.sendToDevice(recentComments, payload);
         })
         .catch(err => console.log(err) )
  });


exports.sendMessages  = functions.firestore
                         .document('Messaging/{customerId}/Services/{serviceId}/msg/{msgId}')
                         .onCreate(async (snapshot, context) => {


    const uid = context.params.customerId;
    const serviceId = context.params.serviceId;

    const user = snapshot.data().id;
    const textMsg = snapshot.data().text;
    console.log("xxxxxxxxxx" + user);
    var nameOfService;

    var docRef1 = admin.firestore().collection("Services").doc(serviceId);

    docRef1.get().then(function(doc) {
        if (doc.exists) {
            console.log("Document data:" + doc.data().Service_Name);
            nameOfService = doc.data().Service_Name;

        } else {
            // doc.data() will be undefined in this case
            console.log("No such document!");
        }
    }).catch(function(error) {
        console.log("Error getting document:" + error);
    });


    console.log("The value of customer is " + context.params.customerId);
    console.log("The value of service is " + context.params.serviceId);

    console.log("Send msg1" + context.params);
    console.log("Send msg2" + context.params.id);

    // ref to the parent document
    const docRef = admin.firestore().collection('Customers').doc(uid)
    // get all comments and aggregate
    return docRef.collection('tokens')
         .get()
         .then(querySnapshot => {
           const recentComments = [];
            // add data from the 5 most recent comments to the array
            querySnapshot.forEach(doc => {
                recentComments.push( doc.data().token )
            });

            console.log(recentComments);
            if(user == 1){
            payload = {
                  notification: {
                    title: 'Received a New Message From ' + nameOfService ,
                    body: textMsg,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                  }
                };
                return fcm.sendToDevice(recentComments, payload);
                }

         })
         .catch(err => console.log(err) )
  });




//  .firestore()
//                .collection('users')
//                .where('id', '==', idFrom)
//                .get()
//                .then(querySnapshot2 => {







//
//
//const functions = require('firebase-functions');
//const admin = require('firebase-admin');
//
//admin.initializeApp();
//
//var msgData;
//
//exports.newSubscriberNotification = functions.firestore
//    .document('client/{clientId}')
//    .onCreate((snap, context) => {
//        msgData = snap.data();
//        admin.firestore().collection('Customers').document('fv7ICvE5V1f3LMTAGyXWvASgTty1').collection('tokens').get().then((snap) => {
//            var tokens = [];
//            if (snap.empty) {
//                console.log('No Device');
//            } else {
//                for (var token of snap.docs) {
//                    tokens.push(token.data().token);
//                }
//                var payload = {
//                    "notification": {
//                        "title": "From " + msgData.name,
//                        "body": "Motive " ,
//                        "sound": "default"
//                    },
//                    "data": {
//                        "sendername": msgData.name,
//                    }
//                }
//                return admin.messaging().sendToDevice(tokens, payload).then((response) => {
//                    console.log('Pushed them all');
//                }).catch((err) => {
//                    console.log(err);
//                });
//            }
//        });
//    });

