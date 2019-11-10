import * as Schema from 'jsonschema';

const validator = new Schema.Validator();

export const validateJSON = (schema: object, json: object) => {
  return validator.validate(json, schema);
}