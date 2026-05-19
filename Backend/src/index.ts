import express, { type Application} from "express";
import mongoose from "mongoose";
import router from "./router/route.user.ts";
import dotenv from "dotenv";
dotenv.config();
const app : Application = express()
const port : number = 8000

mongoose.connect('mongodb://127.0.0.1:27017/Resgister')
.then(() => console.log("MongoDB is Connected Successfully"))
.catch(e => console.log(`Error : ${e}`));

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");

  if (req.method === "OPTIONS") {
    return res.sendStatus(200);
  }

  next();
});

app.use(express.json());

app.use('/', router);

app.listen(port, "0.0.0.0", () => {
  console.log(`Server is Running on port ${port}`)
})
