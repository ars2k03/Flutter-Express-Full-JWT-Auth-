import type { Request } from "express";
import multer from "multer";

const storage = multer.diskStorage({
    destination : (req : Request, file, cb) => {
        cb(null, 'uploads/');
    },

    filename : (req : Request, file, cb) => {
        const uniqueName =
        Date.now() + "-" + file.originalname;

        cb(null, uniqueName);
    }


});

export const upload = multer({
  storage,
});