import db from '../index';

const PROVIDER_SERVICES = 'provider_services';

export function findAll() {
  return db.collection(PROVIDER_SERVICES).get();
};

export function findOne(id: string) {
  return db.collection(PROVIDER_SERVICES).doc(id).get();
}

export function insertOne(providerId: string, serviceId: string) {
  const update: { [id: string]: any; } = {};
  update[serviceId] = true;
  return db.collection(PROVIDER_SERVICES).doc(providerId).set(update, { merge: true });
}

export function deleteOne(providerId: string, serviceId: string) {
  const update: { [id: string]: any; } = {};
  update[serviceId] = null;
  return db.collection(PROVIDER_SERVICES).doc(providerId).set(update, { merge: true });
}

export function updateOne(id: string, data: any) {
  return db.collection(PROVIDER_SERVICES).doc(id).set(data, { merge: true });
}
