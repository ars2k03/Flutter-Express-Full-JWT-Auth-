import type { Request, Response } from "express";
import jwt from "jsonwebtoken";

export const refreshAccessToken = async (
  req: Request,
  res: Response
) => {

  try {

    const { refreshToken } = req.body;

    if (!refreshToken) {
      return res.status(401).json({
        message: "No refresh token",
      });
    }

    jwt.verify(
      refreshToken,
      "arsarafat",

      (err: any, decoded: any) => {

        if (err) {
          return res.status(403).json({
            message: "Invalid refresh token",
          });
        }

        const accessToken = jwt.sign(
          {
            id: decoded.id,
            role: decoded.role,
          },

          "ars2k03",

          {
            expiresIn: "1m",
          }
        );

        return res.status(200).json({
          message: "New access token generated",
          accessToken,
        });
      }
    );

  } catch (e) {

    return res.status(500).json({
      message: "Server Error",
    });

  }
};