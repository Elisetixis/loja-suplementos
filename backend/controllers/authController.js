const bcrypt = require("bcryptjs");
const db = require("../models/db");

// CADASTRO
exports.cadastro = async (req, res) => {
  const { nome, email, senha, telefone, endereco, cidade, estado } = req.body;

  try {
    const senhaHash = await bcrypt.hash(senha, 10);

    db.query(
      `INSERT INTO usuarios 
      (nome, email, senha, telefone, endereco, cidade, estado)
      VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [nome, email, senhaHash, telefone, endereco, cidade, estado],
      (err) => {
        if (err) return res.status(500).json({ erro: err.message });

        res.json({ mensagem: "Usuário cadastrado!" });
      }
    );
  } catch {
    res.status(500).json({ erro: "Erro no cadastro" });
  }
};

// 🔥 LOGIN CORRIGIDO
exports.login = (req, res) => {
  const { email, senha } = req.body;

  db.query(
    "SELECT * FROM usuarios WHERE email = ?",
    [email],
    async (err, results) => {
      if (err) return res.status(500).json(err);

      if (results.length === 0) {
        return res.status(400).json({ erro: "Usuário não encontrado" });
      }

      const usuario = results[0];

      const senhaCorreta = await bcrypt.compare(senha, usuario.senha);

      if (!senhaCorreta) {
        return res.status(400).json({ erro: "Senha incorreta" });
      }

      // ✅ RESPOSTA ÚNICA E CORRETA
      res.json({
        usuarioId: usuario.id
      });
    }
  );
};
// BUSCAR USUÁRIO
exports.getUsuario = (req, res) => {
  const { id } = req.query;

  db.query(
    "SELECT nome, email, telefone, endereco, cidade, estado, foto FROM usuarios WHERE id = ?",
    [id],
    (err, result) => {
      res.json(result[0]);
    }
  );
};

// UPLOAD FOTO
exports.uploadFoto = (req, res) => {
  const { usuarioId } = req.body;

  const foto = req.file.filename;

  db.query(
    "UPDATE usuarios SET foto = ? WHERE id = ?",
    [foto, usuarioId],
    (err) => {
      if (err) return res.status(500).json({ erro: err.message });

      res.json({ mensagem: "Foto atualizada!" });
    }
  );
};