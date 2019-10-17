import * as functions from 'firebase-functions';
import * as bcrypt from 'bcryptjs';
import { validateJSON } from '../lib/validator';
import { NewUserSchema } from '../schemas';

export const createNewUser = functions.https.onRequest((req, res) => {
  if (!validateJSON(NewUserSchema, req.body).valid) {
    res.sendStatus(400).json({
      status: 'failed',
      message: 'Request Body Contains Errors'
    });
  }
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
    res.json({
      email,
      first_name,
      last_name,
      role,
      hash,
    });
  } catch (e) {
    res.sendStatus(500).json({
      status: 'failed',
      message: 'Error Storing Password'
    });
  }
});