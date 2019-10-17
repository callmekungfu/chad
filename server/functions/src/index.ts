import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

import { createNewUser } from './functions/create-new-user'

admin.initializeApp(functions.config().firebase);

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

export const newUser = createNewUser;