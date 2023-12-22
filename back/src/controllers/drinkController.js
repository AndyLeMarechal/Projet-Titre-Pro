import { Drink } from "../models/index.js";
import Joi from 'joi';

export async function getAllDrinks(req, res) {
  try{
    const drinks = await Drink.findAll({
      order: ["id"],});
    if(!drinks){
      return res.status(404).json({error: '/drinks not found'});
    }
    res.status(200).json(drinks);
  }
  catch(error){
    console.error(error);
    res.status(500).json({error: '500 Internal Server Error'});
  }
}


export async function getOneDrink(req, res) {
  try{
    const drinkId = Number.parseInt(req.params.id, 10);
    if(isNaN(drinkId)){
      return res.status(400).json({error: 'Drink ID should be a valid integer'});
    }
  
    const drink = await Drink.findByPk(drinkId,{
      order: ["id"],});
    if(!drink){
      return res.status(404).json({error: 'Drink not found. Please verify the provided id.'});
    }
    res.status(200).json(drink);
  }
  catch(error){
    console.error(error);
    res.status(500).json({error: '500 Internal Server Error'});
  }
}


export async function createdDrink(req, res) {
  try{
    const createDrinkSchema = Joi.object({
      soft: Joi.boolean(),
      
      
      title: Joi.string()
        .min(3)
        .max(40)
        .required(),
      price_in_euro: Joi.number()
        .min(1)
        .max(4)
        .required(),
  
      img: Joi.string().empty('').dataUri()
    });
    const { error } = createDrinkSchema.validate(req.body);
    if (error) { return res.status(400).json({ error: error.message }); }
  
    const createdDrink = await Drink.create({
      title: req.body.title,
      soft: req.body.soft,
      price_in_euro: req.body.price_in_euro || '0' ,
      img: req.body.img || "."
    });
    res.status(201).json(createdDrink);
  }
  catch(error){
    console.error(error);
    res.status(500).json({error: '500 Internal Server Error'});
  }
}


export async function updatedDrink(req, res) {
  try{
    const drinkId = Number.parseInt(req.params.id, 10);
    if(isNaN(drinkId)){
      return res.status(400).json({error: 'Drink ID should be a valid integer'});
    }
  
    const drink = await Drink.findByPk(drinkId,);
    if(!drink){
      return res.status(404).json({error: 'Drink not found. Please verify the provided id.'});
    }
  
    const updateDrinkSchema = Joi.object({
      soft: Joi.boolean(),
  
      title: Joi.string()
        .min(3)
        .max(40)
        .required(),
  
      price_in_euro: Joi.number()
        .min(1)
        .max(4)
        .required(),
  
      img: Joi.string().empty('').dataUri()
    });
    const { error } = updateDrinkSchema.validate(req.body);
    if (error) { return res.status(400).json({ error: error.message }); }
  
    const updatedDrink = await drink.update({
      title: req.body.title,
      soft: req.body.soft,
      price_in_euro: req.body.price_in_euro,
      img: req.body.img
    });
    res.status(200).json(updatedDrink);
  }
  catch(error){
    console.error(error);
    res.status(500).json({error: '500 Internal Server Error'});
  }
}


export async function deletedDrink(req, res) {
  try{
    const drinkId = Number.parseInt(req.params.id, 10);
    if(isNaN(drinkId)){
      return res.status(400).json({error: 'Drink ID should be a valid integer'});
    }
  
    const drink = await Drink.findByPk(drinkId);
    if(!drink){
      return res.status(404).json({error: 'Drink not found. Please verify the provided id.'});
    }
    await drink.destroy();
    res.status(204).end();
  }
  catch(error){
    console.error(error);
    res.status(500).json({error: '500 Internal Server Error'});
  }
}