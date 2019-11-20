import db from '../index';
import { Provider } from '../models/provider';

const COLLECTION = 'provider';

export function findAll() {
  return db.collection(COLLECTION).get();
};

export function findOne(id: string) {
  return db.collection(COLLECTION).doc(id).get();
}

export function insertOne(provider: Provider) {
  return db.collection(COLLECTION).add(provider);
}

export function deleteOne(id: string) {
  return db.collection(COLLECTION).doc(id).delete();
}

export function updateOne(id: string, data: any) {
  return db.collection(COLLECTION).doc(id).set(data, { merge: true });
}
