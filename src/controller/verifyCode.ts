import type { Request, Response } from "express";
import Verification from "../model/verification.model";

export const verifyCode = async (
    req: Request,
    res: Response
) => {

    try {

        const { email, code } = req.body;

        const verifyData = await Verification.findOne({
            email: email,
            code: code,
        });

        if (!verifyData) {

            return res.status(400).json({
                message: "Invalid Code",
            });

        }

        if (new Date() > verifyData.expiresAt) {
            return res.status(400).json({
                message: "Code Expired",
            });
        }

        return res.status(200).json({
            message: "Verification Success",
        });

    } catch (e) {

        return res.status(500).json({
            message: "Server Error",
        });

    }
};