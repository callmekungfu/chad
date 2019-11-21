import db from '../index';
import { Service } from '../models/service';

const SERVICES = 'services';

export function findAll() {
  return db.collection(SERVICES).get();
}

export function findBatch(ids: string[]) {
  const documents: any = [];
  ids.forEach((id: any) => {
    const document = db.doc(`${SERVICES}/${id}`);
    documents.push(document);
  });
  return db.getAll(...documents);
}

export function findOne(id: string) {
  return db.collection(SERVICES).doc(id).get();
}

export function insertOne(service: Service) {
  return db.collection(SERVICES).add(service);
}

export function deleteOne(id: string) {
  return db.collection(SERVICES).doc(id).delete();
}

export function updateOne(id: string, data: any) {
  return db.collection(SERVICES).doc(id).set(data, { merge: true });
}
