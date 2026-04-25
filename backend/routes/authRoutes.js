const express = require("express");
const router = express.Router();
const authController = require("../controllers/authController");

const multer = require("multer");
const path = require("path");

// CONFIGURAÇÃO DO UPLOAD
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage });

router.post("/cadastro", authController.cadastro);
router.post("/login", authController.login);
router.get("/usuario", authController.getUsuario);

// NOVA ROTA FOTO
router.post("/upload-foto", upload.single("foto"), authController.uploadFoto);

module.exports = router;