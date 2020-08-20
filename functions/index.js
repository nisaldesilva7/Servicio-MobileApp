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



exports.sendBookingConfirmation  = functions.firestore
                         .document('Services/{ServicesId}/Bookings/{BookingsId}')
                         .onUpdate(async (snapshot, context) => {

    const order = snapshot.after.data();
    const uid = snapshot.before.data().CustId;
    const serviceId = snapshot.before.data().ServiceId;

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
            payload = {
                  notification: {
                    title: 'Booking Confirmed by ' + serviceId,
                    body: order.ServiceType,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK'
                  }
                };

            return fcm.sendToDevice(recentComments, payload);
         })
         .catch(err => console.log(err) )
  });


//  .firestore()
//                .collection('users')
//                .where('id', '==', idFrom)
//                .get()
//                .then(querySnapshot2 => {