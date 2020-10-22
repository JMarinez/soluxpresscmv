import * as functions from 'firebase-functions';

import * as admin from 'firebase-admin';
admin.initializeApp();
const db = admin.firestore();

import * as sgMail from '@sendgrid/mail';

const API_KEY = functions.config().sendgrid.key;
const TEMPLATE_ID = functions.config().sendgrid.key;
sgMail.setApiKey(API_KEY);

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const newService = functions.firestore.document('users/{userId}/services/{serviceId}').onCreate(async (change, context) => {
    
    const serviceSnap = await db.collection('services').doc(context.params.serviceId).get();

    const service = serviceSnap.data() || {};

    var serviceType = '';

    if (service.serviceType == '1') {
        serviceType = 'Electricidad';
    }
    else if (service.serviceType == '2') {
        serviceType = 'Instalacion';  
    }
    else if (service.serviceType == '3') {
        serviceType = 'Micelaneos'; 
    }
    else if (service.serviceType == '4') {
        serviceType = 'Pintura';
    }
    else if (service.serviceType == '5') {
        serviceType = 'Plomeria';   
    }
    else if (service.serviceType == '6') {
        serviceType = 'Presupuesto';   
    }

    const msg = {
        to: 'Promotoramv3@gmail.com',
        from: 'service@soluxpress.com',
        templateId: TEMPLATE_ID,
        dynamic_template_data: {
            subject: `Servicio creado ${serviceType} - ${service.uid}`,
            client: service.userFullName,
             phoneNumber: service.userPhoneNumber,
             address: service.address,
             service: serviceType,
             description: service.description
        },
    };

    return sgMail.send(msg);
});