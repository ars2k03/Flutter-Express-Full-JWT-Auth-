import type { Request, Response } from "express";
import User from "../model/user.model";

export const uploadProfile = async (
  req: Request,
  res: Response
) => {
  try {
    const file = req.file;

    if (!file) {
      return res.status(400).json({
        success: false,
        message: "No image uploaded",
      });
    }

    const userId = (req as any).user.id;

    const imagePath = `http://172.21.100.188:8000/uploads/${file.filename}`;

    const user = await User.findByIdAndUpdate(
      userId,
      {
        picture: imagePath,
      },
      { new: true }
    );

    const newUser = {
      id : user?._id,
      name : user?.name,
      role : user?.role,
      picture : user?.picture,
      email : user?.email
    }

    res.status(200).json({
      success: true,
      message: "Profile uploaded successfully",
      newUser,
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: "Server Error",
      error,
    });

  }
};