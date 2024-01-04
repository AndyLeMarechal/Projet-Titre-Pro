import Joi from "joi";
import { joiPasswordExtendCore } from 'joi-password';
const joiPassword = Joi.extend(joiPasswordExtendCore);

export default Joi.object({
  username: Joi.string()
    .alphanum()
    .min(3)
    .max(30)
    .required(),

  password: joiPassword
    .string()
    .minOfSpecialCharacters(1)
    .minOfLowercase(4)
    .minOfUppercase(1)
    .minOfNumeric(2)
    .noWhiteSpaces()
    .onlyLatinCharacters()
    .messages({
      'password.minOfUppercase': '{#label} should contain at least {#min} uppercase character',
      'password.minOfSpecialCharacters':
                  '{#label} should contain at least {#min} special character',
      'password.minOfLowercase': '{#label} should contain at least {#min} lowercase character',
      'password.minOfNumeric': '{#label} should contain at least {#min} numeric character',
      'password.noWhiteSpaces': '{#label} should not contain white spaces',
      'password.onlyLatinCharacters': '{#label} should contain only latin characters',
    }),

  passwordConfirm: Joi.ref('password'),

  firstname: Joi.string()
    .alphanum()
    .min(3)
    .max(30)
    .required(),

  lastname: Joi.string()
    .alphanum()
    .min(3)
    .max(30)
    .required(),

  address: Joi.string()
    .min(3)
    .max(200)
    .required(),

  role: Joi.string()
    .alphanum()
    .min(3)
    .max(30),

  email: Joi.string()
    .email({ minDomainSegments: 2, tlds: { allow: ['com', 'net', 'fr'] } }) ,
});