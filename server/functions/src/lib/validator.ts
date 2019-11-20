import * as Schema from 'jsonschema';

const validator = new Schema.Validator();

export const validateJSON = (json: object, schema: object) => {
  return validator.validate(json, schema);
}
