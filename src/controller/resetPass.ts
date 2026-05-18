import type { Request, Response } from "express";
import User from "../model/user.model";
import  bcrypt from "bcrypt";

export const resetPass = async (req : Request, res : Response) => {
    try {

        const { email, password } = req.body;

        const user = await User.findOne({
            email: email,
        });

        if (!user) {
            return res.status(404).json({
                message: "User not found",
            });
        }

        if(await bcrypt.compare(password, user.password)){
            return res.status(400).json({
                message: "New password cannot be the same as old password",
            })
        }

        const newHashPass = await bcrypt.hash(password, 10);

        await User.findByIdAndUpdate(
            user._id,
            {
                password: newHashPass,
            }
        )
        
        return res.status(200).json({
            message: "Password change Successfull",

        });

    } catch (e) {

        return res.status(500).json({

            message: "Server Error",

        });

    }
}