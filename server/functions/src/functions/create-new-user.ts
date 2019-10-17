import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as bcrypt from 'bcryptjs';
import { validateJSON } from '../lib/validator';
import { NewUserSchema } from '../schemas';

export const createNewUser = functions.https.onRequest(async (req, res) => {
  if (!validateJSON(NewUserSchema, req.body).valid) {
    res.sendStatus(400).json({
      status: 'failed',
      message: 'Request Body Contains Errors'
    });
  }
  
  const db = admin.firestore();

  const {
    email,
    first_name,
    last_name,
    role,
    password,
  }= req.body;
  try {
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(password, salt);
    await db.collection('users').doc().set({
      email,
      first_name,
      last_name,
      role,
      password: hash,
    });
    res.json({
      status: 'done',
      message: 'New User Created',
      stored: {
        email,
        first_name,
        last_name,
        role,
        password: hash,
      }
    });
  } catch (e) {
    res.sendStatus(500).json({
      status: 'failed',
      message: 'Error Storing Password'
    });
  }
});