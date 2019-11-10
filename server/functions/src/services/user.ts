import db from '../index';
import * as bcrypt from 'bcrypt';
import { User } from '../models/user';

const COLLECTION = 'users';

export function findAll() {
  return db.collection(COLLECTION).get();
};

export function findOne(username: string) {
  return db.collection(COLLECTION).doc(username).get();
}

export function insertOne(user: User) {
  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(user.password, salt);
  user.password = hash;
  return db.collection(COLLECTION).doc(user.userName).set(user);
}

export function deleteOne(username: string) {
  return db.collection(COLLECTION).doc(username).delete();
}

export function updateOne(username: string, data: any) {
  return db.collection(COLLECTION).doc(username).set(data, { merge: true });
}
