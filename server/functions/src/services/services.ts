import db from '../index';
import { Service } from '../models/service';

const COLLECTION = 'services';

export function findAll() {
  return db.collection(COLLECTION).get();
};

export function findOne(id: string) {
  return db.collection(COLLECTION).doc(id).get();
}

export function insertOne(service: Service) {
  return db.collection(COLLECTION).add(service);
}

export function deleteOne(id: string) {
  return db.collection(COLLECTION).doc(id).delete();
}

export function updateOne(id: string, data: any) {
  return db.collection(COLLECTION).doc(id).set(data, { merge: true });
}
