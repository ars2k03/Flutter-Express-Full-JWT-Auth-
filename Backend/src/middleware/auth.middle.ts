import type { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

export const authMiddleWare = ( 
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {

    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        message: "No token provided",
      });
    }

    const token = authHeader.split(" ")[1];

    jwt.verify(
      token as string,
      "ars2k03"
    );

    next();

  } catch (error) {
    return res.status(401).json({
      message: "Invalid token",
    });
  }
};
