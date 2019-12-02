import { Application } from 'express';
import * as Auth from "./auth/authenticated";
import * as Services from './controllers/services';
import * as Users from './controllers/user';
import * as Providers from './controllers/provider';

export function routerConfig(app: Application) {

  app.post('/login',
    Auth.login
  );

  app.post('/users',
    Users.insertOne
  );

  app.post('/services',
    Services.insertOne
  );

  app.get('/services',
    Services.findAll
  );

  app.get('/services/:id',
    Services.findOne
  );

  app.delete('/services/:id',
    Services.deleteOne
  );

  app.put('/services/:id',
    Services.updateOne
  );

  app.post('/providers',
    Providers.insertOne
  );

  app.get('/providers',
    Providers.findAll
  );

  app.get('/providers/:id',
    Providers.findOne
  );

  app.delete('/providers/:id',
    Providers.deleteOne
  );

  app.put('/providers/:id',
    Providers.updateOne
  );

  app.post('/providers/:providerId/services',
    Providers.addService
  );

  app.delete('/providers/:providerId/services/:serviceId',
    Providers.deleteService
  );

  app.post('/providers/:providerId/dates/:date',
    Providers.insertAppointment
  )

  app.get('/providers/:providerId/dates/:date',
    Providers.findAllAppointments
  )
}
