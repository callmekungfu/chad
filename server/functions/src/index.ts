import * as functions from 'firebase-functions';

import { createNewUser } from './functions/create-new-user'

export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

export const newUser = createNewUser;