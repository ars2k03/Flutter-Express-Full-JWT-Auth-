import express, { type Request, type Response } from "express";
import { signUp } from "../controller/signup.ts";
import { login } from "../controller/login.ts";
import { authMiddleWare } from "../middleware/auth.middle.ts";
import { verifyCode } from "../controller/verifyCode.ts";
import { resendCode } from "../controller/resendCode.ts";
import { forgetPassword } from "../controller/forgetPassword.ts";
import { resetPass } from "../controller/resetPass.ts";
import { googleLogin } from "../controller/googleLogin.ts";
import { refreshAccessToken } from "../controller/refreshToken.ts";
import { upload } from "../middleware/upload.ts";
import { uploadProfile } from "../controller/user.controller.ts";

const router = express.Router();

router.post("/google-login", googleLogin);
router.post('/signUp', signUp);
router.post('/login', login);
router.post("/refresh", refreshAccessToken);
router.post("/verifycode", verifyCode);
router.patch("/resetpassword", resetPass);
router.post("/forget-password", forgetPassword);
router.post("/resend-code", resendCode);
router.patch(
  "/upload-profile",
  authMiddleWare,
  upload.single("picture"),
  uploadProfile
);

router.get("/profile", authMiddleWare, (req : Request, res : Response) => {

    const user = (req as any).user;

    return res.status(200).json({
      message: "Welcome to profile",
      user,
    });

  }
);

export default router;