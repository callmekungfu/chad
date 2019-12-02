import * as express from 'express';
import * as moment from 'moment';
import * as Providers from '../services/provider';
import * as Services from '../services/services';
import * as ProviderServices from '../services/provider_services';
import { validateJSON } from '../lib/validator';
import { postProviderSchema, putProviderSchema, postProviderServicesSchema, postAppointmentSchema } from '../lib/schemas/index';

export async function findAll(req: express.Request, res: express.Response) {
  try {
    const providerResults: any = []
    const findResult = await Providers.findAll();
    findResult.forEach(async (document: any) => {
      const data = document.data();
      /*
      if (req.query.time && req.query.date) {
        const providerLastAppointment = await Providers.findLastAppointment(document.id, req.query.date);
        if (providerLastAppointment.size !== 0) {
          const providerLastAppointmentResults: any = [];
          providerLastAppointment.forEach((subDocument: any) => {
            providerLastAppointmentResults.push({
              id: subDocument.id,
              data: subDocument.data()
            });
          });
          const lastTime = moment(providerLastAppointmentResults[0].data.time, "H:mm")
          const curTime = moment(req.query.time, "H:mm")
          const duration = moment.duration(lastTime.diff(curTime));
          const hours = duration.asHours();
          const minutes = duration.asMinutes() % 60;
          data.waitTime = `${hours}:${minutes}`;
        } else {
          data.waitTime = `${hours}:${minutes}`;
        }
      }
      */
      providerResults.push({
        id: document.id,
        data
      });
    });
    return res.status(200).json({
      isSuccess: true,
      provider: providerResults,
      time: req.query.time,
      date: req.query.date,

    });
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function findOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      const providerResult = await Providers.findOne(id);
      if (providerResult.exists) {
        const services: any = [];
        const servicesIdResult: any = await ProviderServices.findOne(id);
        if (servicesIdResult.exists) {
          const object = servicesIdResult.data();
          const keys: any[] = Object.keys(object).filter(key => object[key] === true);
          const servicesResult = await Services.findBatch(keys);
          servicesResult.forEach((service: any) => {
            services.push({
              id: service.id,
              data: service.data()
            });
          });
        }
        return res.status(200).json({
          isSuccess: true,
          provider: {
            id: providerResult.id,
            data: providerResult.data(),
            services
          }
        });
      } else {
        return res.status(204).json({
          isSuccess: true,
          data: {}
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function insertOne(req: express.Request, res: express.Response) {
  try {
    if (validateJSON(req.body, postProviderSchema).errors.length > 0) {
      return res.status(400).json({
        isSuccess: false,
        msg: 'invalid body'
      });
    } else {
      const providerInsert = await Providers.insertOne(req.body);
      const providerResult = await providerInsert.get();
      await Providers.initOne(providerInsert.id);
      return res.status(201).json({
        isSuccess: true,
        provider: {
          id: providerInsert.id,
          data: providerResult.data(),
        }
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function deleteOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      await Providers.deleteOne(id);
      return res.status(204).json({
        isSuccess: true,
        service: {}
      });
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function updateOne(req: express.Request, res: express.Response) {
  try {
    const id = req.params.id;
    if (id) {
      if (validateJSON(req.body, putProviderSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        await Providers.updateOne(id, req.body);
        return res.status(200).json({
          isSuccess: true,
          provider: {
            id,
            service: req.body
          }
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function addService(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    if (providerId) {
      if (validateJSON(req.body, postProviderServicesSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        await ProviderServices.insertOne(providerId, req.body.serviceId);
        return res.status(201).json({
          isSuccess: true,
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function deleteService(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    const serviceId = req.params.serviceId;
    if (providerId && serviceId) {
      await ProviderServices.deleteOne(providerId, serviceId);
      return res.status(204).json({
        isSuccess: true,
        data: {}
      });
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function findServices(req: express.Request, res: express.Response) {
  try {
    const servicesResults: any = []
    const findResult = await Providers.findAll();
    findResult.forEach((document: any) => {
      servicesResults.push({
        id: document.id,
        data: document.data()
      });
    });
    return res.status(200).json({
      isSuccess: true,
      provider: servicesResults,
    });
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function insertAppointment(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    const date = req.params.date;
    if (providerId && date) {
      if (validateJSON(req.body, postAppointmentSchema).errors.length > 0) {
        return res.status(400).json({
          isSuccess: false,
          msg: 'invalid body'
        });
      } else {
        const providerLastAppointmentResults: any = [];
        const data: any = req.body
        data.timeInt = parseInt(req.body.time.replace(':', ''));
        const providerLastAppointment = await Providers.findLastAppointment(providerId, date);
        if (providerLastAppointment.size === 0) {
          if (req.query.startTime) {
            if (data.timeInt >= parseInt(req.query.endTime.replace(':', ''))) {
              return res.status(403).json({
                isSuccess: false,
                msg: 'service provider closed'
              });
            } else if (data.timeInt > parseInt(req.query.startTime.replace(':', ''))) {
              data.time = req.body.time;
            } else {
              data.time = req.query.startTime;
              data.timeInt = parseInt(req.query.startTime.replace(':', ''));
            }
          }
        } else {
          providerLastAppointment.forEach((document: any) => {
            providerLastAppointmentResults.push({
              id: document.id,
              data: document.data()
            });
          });
          if (req.query.endTime) {
            if (providerLastAppointmentResults[0].data.timeInt + 15 >= parseInt(req.query.endTime.replace(':', ''))) {
              return res.status(403).json({
                isSuccess: false,
                msg: 'service provider closed'
              });
            }
          }
          if (data.timeInt <= providerLastAppointmentResults[0].data.timeInt + 15) {
            const newTime = moment(providerLastAppointmentResults[0].data.time, "H:mm").add(15, 'minutes').format("H:mm");
            data.time = newTime;
            data.timeInt = parseInt(newTime.replace(':', ''));
          }
        }
        const providerAppointmentInsert = await Providers.insertAppointment(providerId, date, data);
        const providerAppointmentResult = await providerAppointmentInsert.get();
        return res.status(201).json({
          isSuccess: true,
          provider: {
            id: providerAppointmentInsert.id,
            data: providerAppointmentResult.data(),
          }
        });
      }
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}

export async function findAllAppointments(req: express.Request, res: express.Response) {
  try {
    const providerId = req.params.providerId;
    const date = req.params.date;
    if (providerId && date) {
      const providerAppointmentsResults: any = []
      let findResult;
      if (req.query.time) {
        const rawTime = req.query.time;
        const curTime = parseInt(rawTime.replace(':', ''));
        findResult = await Providers.findAllAppointments(providerId, date, curTime);
      } else {
        findResult = await Providers.findAllAppointments(providerId, date);
      }
      findResult.forEach((document: any) => {
        providerAppointmentsResults.push({
          id: document.id,
          data: document.data()
        });
      });
      return res.status(200).json({
        isSuccess: true,
        appointment: providerAppointmentsResults,
      });
    } else {
      return res.status(400).json({
        isSuccess: false,
      });
    }
  } catch (error) {
    return res.status(500).json({
      isSuccess: false,
      error
    });
  }
}
