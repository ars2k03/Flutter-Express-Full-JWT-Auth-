import type { Request, Response, NextFunction } from "express";
import jwt, { type JwtPayload } from "jsonwebtoken";
import User from "../model/user.model";

export const authMiddleWare = async ( 
  req: Request,
  res: Response,
  next: NextFunction
)  => {
  try {

    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        message: "No token provided",
      });
    }

    const token = authHeader.split(" ")[1];

    const result = jwt.verify(
      token as string,
      "ars2k03"
    ) as JwtPayload;

    const user = await User.findById(result.id);

    if (!user) {
      return res.status(404).json({
        message: "User not found",
      });
    }

    (req as any).user = {
      id : user._id,
      name : user.name,
      email : user.email,
      role : user.role,
      picture : user.picture
    };

    next();

  } catch (error) {
    return res.status(401).json({
      message: "Invalid token",
    });
  }
};
