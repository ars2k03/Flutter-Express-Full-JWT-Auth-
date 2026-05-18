import type { Request, Response } from "express";
import User from "../model/user.model";
import Verification from "../model/verification.model";
import { sendMail } from "../utils/sendMail";

export const forgetPassword = async (
    req: Request,
    res: Response
) => {

    try {

        const { email } = req.body;

        const user = await User.findOne({
            email: email,
        });

        if (!user) {

            return res.status(404).json({
                message: "User not found",
            });

        }

        await Verification.deleteMany({
            email: email,
        });

        const verificationCode = Math.floor(
            100000 + Math.random() * 900000
        ).toString();

        await Verification.create({

            email: email,

            code: verificationCode,

            expiresAt: new Date(
                Date.now() + 30 * 1000
            ),

        });

        await sendMail(

            email,

            "Reset Password Code",

            `Your reset password code is ${verificationCode}`

        );

        return res.status(200).json({

            message: "Verification code sent",

        });

    } catch (e) {

        return res.status(500).json({

            message: "Server Error",

        });

    }
};