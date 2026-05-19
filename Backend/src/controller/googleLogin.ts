import type { Request, Response } from "express";
import { OAuth2Client } from "google-auth-library";
import jwt from "jsonwebtoken";
import User from "../model/user.model";
import bcrypt from "bcrypt";

const client = new OAuth2Client();

export const googleLogin = async (
  req: Request,
  res: Response
) => {

  try {

    const { idToken } = req.body;

    if (!idToken) {

      return res.status(400).json({
        message: "Google token missing",
      });

    }

    const ticket = await client.verifyIdToken({idToken});

    const payload = ticket.getPayload();

    if (!payload) {

      return res.status(401).json({
        message: "Invalid Google token",
      });

    }
    

    let user = await User.findOne({email: (payload.email) as string});

    const hashedPassword = await bcrypt.hash(
      crypto.randomUUID(),
      10
    );

    if (!user) {
      user = await User.create({
        name: payload.name as string,
        email: payload.email as string,
        password: hashedPassword
      });
    }

    const token = jwt.sign(

      {
        id: user._id,
        role: user.role,
      },

      "ars2k03",

      {
        expiresIn: "1m",
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

    return res.status(200).json({

      message: "Google login successful",

      token,
      refreshToken,

      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        picture: payload.picture,
      },

    });

  } catch (error) {

    console.log(error);

    return res.status(500).json({
      message: "Google login failed",
    });

  }

};