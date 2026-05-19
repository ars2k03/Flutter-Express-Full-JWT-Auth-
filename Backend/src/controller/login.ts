import type { Request, Response } from "express";
import User from "../model/user.model";
import bycrypt from "bcrypt";
import jwt from "jsonwebtoken";


export const login = async (req : Request, res : Response) => {
    try{
        const {email, password} = req.body;

        const user = await User.findOne({email});

        if(!user){
            return res.status(404).json({
                message : "User not found",
            })
        }

        const isPassMatch = await bycrypt.compare(password, user.password);

        if (!isPassMatch) {
            return res.status(400).json({
                message: "Password Incorrect",
            });
        }

        const token = jwt.sign(
            {
                id : user._id,
                role : user.role,
            },

            "ars2k03", //Private Key

            {
                expiresIn : "1m"
            }
        );

        const refreshToken = jwt.sign(
            {
                id : user._id,
                role : user.role,
            },
            "arsarafat",
            {
                expiresIn : "30d"
            }
        );

        res.status(200).json({
            message: "Login successful",
            token,
            refreshToken,
            user: {
                id: user._id,
                email: user.email,
                role: user.role,
            }
        });

    }catch(e){
        return res.status(500).json({
            message : "Server Error"
        })
    }
}