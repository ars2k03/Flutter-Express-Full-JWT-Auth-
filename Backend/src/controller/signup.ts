import { type Request, type Response } from "express";
import bcrypt from "bcrypt";
import User from "../model/user.model.ts";
import { sendMail } from "../utils/sendMail.ts";
import Verification from "../model/verification.model.ts";


export const signUp = async (req : Request, res : Response) => {
    try{
        const {name, email, password} = req.body;
        const oneUser = await User.findOne({email});
        if(oneUser){
            return res.status(400).json({
                message: "User already exists",
            })
        }

        const hashPass = await bcrypt.hash(password, 10);

        const newUser = await User.create(
            {
                name : name,
                email : email,
                password : hashPass
            }
        );

        const verificationCode = Math.floor(
            100000 + Math.random() * 900000
        ).toString();

        await Verification.create({

            email: email,

            code: verificationCode,

            expiresAt: new Date(
                Date.now() +  30 * 1000
            ),

        });

        await sendMail(
            email,
            "Verification Code",
            `Your verification code is ${verificationCode}`
        );

        return res.status(201).json({
            message: "User registered",
            data : newUser,
        })

    }catch(e){
        res.status(500).send("Server Error");
    }
}