import express, { type Request, type Response } from "express";
import { signUp } from "../controller/signup.ts";
import { login } from "../controller/login.ts";
import { authMiddleWare } from "../middleware/auth.middle.ts";
import { verifyCode } from "../controller/verifyCode.ts";
import { resendCode } from "../controller/resendCode.ts";
import { forgetPassword } from "../controller/forgetPassword.ts";
import { resetPass } from "../controller/resetPass.ts";

const router = express.Router();

router.post('/signUp', signUp);
router.post('/login', login);
router.post("/verifycode", verifyCode);
router.patch("/resetpassword", resetPass);
router.post("/forget-password", forgetPassword);
router.post("/resend-code", resendCode);

router.get("/profile", authMiddleWare, (req : Request, res : Response) => {

    return res.status(200).json({
      message: "Welcome to profile",
    });

  }
);

export default router;