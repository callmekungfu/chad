import { Application } from 'express';
import * as Auth from "./auth/authenticated";
import * as Services from './controllers/services';
import * as Users from './controllers/user';

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
}
