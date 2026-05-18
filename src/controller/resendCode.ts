import type { Request, Response } from "express";
import Verification from "../model/verification.model";
import { sendMail } from "../utils/sendMail";

export const resendCode = async (
    req: Request,
    res: Response
) => {

    try {

        const { email } = req.body;

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

            "Verification Code",

            `Your verification code is ${verificationCode}`

        );

        return res.status(200).json({

            message: "New verification code sent",

        });

    } catch (e) {

        return res.status(500).json({

            message: "Server Error",

        });

    }
};