import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

import { createNewUser } from './functions/create-new-user'
import { authenticateWithPassword } from './functions/authenticate';

admin.initializeApp(functions.config().firebase);

export const newUser = createNewUser;
export const login = authenticateWithPassword;
