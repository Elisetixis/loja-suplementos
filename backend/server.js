const express = require("express");
const cors = require("cors");
const path = require("path");
const db = require("./models/db");

const app = express();

app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, "../frontend")));
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

const authRoutes = require("./routes/authRoutes");
app.use("/auth", authRoutes);


app.get("/produtos", (req, res) => {
  const { marca, busca, categoria } = req.query;

  let sql = "SELECT * FROM produtos WHERE 1=1";
  let params = [];

  if (marca) {
    sql += " AND marca = ?";
    params.push(marca);
  }

  if (busca) {
    sql += " AND nome LIKE ?";
    params.push("%" + busca + "%");
  }

  if (categoria) {
    sql += " AND categoria = ?";
    params.push(categoria);
  }

  db.query(sql, params, (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});


app.post("/carrinho", (req, res) => {
  const { usuario_id, produto_id, quantidade } = req.body;

  db.query(
    "INSERT INTO carrinho (usuario_id, produto_id, quantidade) VALUES (?, ?, ?)",
    [usuario_id, produto_id, quantidade || 1],
    (err) => {
      if (err) return res.status(500).json(err);
      res.json({ message: "Adicionado ao carrinho" });
    }
  );
});

app.get("/carrinho/:usuarioId", (req, res) => {
  const { usuarioId } = req.params;

  const sql = `
    SELECT c.id_carrinho, p.nome, p.preco, p.imagem, c.quantidade
    FROM carrinho c
    JOIN produtos p ON c.produto_id = p.id_produto
    WHERE c.usuario_id = ?
  `;

  db.query(sql, [usuarioId], (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});

app.delete("/carrinho/:id", (req, res) => {
  const { id } = req.params;

  db.query("DELETE FROM carrinho WHERE id_carrinho = ?", [id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Removido" });
  });
});


app.get("/pedidos/usuario/:usuarioId", (req, res) => {
  const { usuarioId } = req.params;

  const sql = `
    SELECT 
      p.id_pedido,
      p.data,
      pr.nome,
      pr.preco,
      pr.imagem,
      pi.quantidade
    FROM pedidos p
    INNER JOIN pedido_itens pi ON p.id_pedido = pi.pedido_id
    INNER JOIN produtos pr ON pi.produto_id = pr.id_produto
    WHERE p.usuario_id = ?
    ORDER BY p.data DESC
  `;

  db.query(sql, [usuarioId], (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});


app.post("/finalizar-pedido", (req, res) => {
  const { usuario_id } = req.body;

  if (!usuario_id) {
    return res.status(400).json({ erro: "Usuário não informado" });
  }

  db.query(
    "SELECT produto_id, SUM(quantidade) AS quantidade FROM carrinho WHERE usuario_id = ? GROUP BY produto_id",
    [usuario_id],
    (err, itens) => {
      if (err) return res.status(500).json(err);

      if (itens.length === 0) {
        return res.status(400).json({ erro: "Carrinho vazio" });
      }

      db.query("INSERT INTO pedidos (usuario_id) VALUES (?)", [usuario_id], (err, pedidoResult) => {
        if (err) return res.status(500).json(err);

        const pedidoId = pedidoResult.insertId;

        const valores = itens.map(item => [
          pedidoId,
          item.produto_id,
          item.quantidade
        ]);

        db.query(
          "INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES ?",
          [valores],
          (err) => {
            if (err) return res.status(500).json(err);

            db.query("DELETE FROM carrinho WHERE usuario_id = ?", [usuario_id], (err) => {
              if (err) return res.status(500).json(err);

              res.json({ message: "Pedido finalizado com sucesso!" });
            });
          }
        );
      });
    }
  );
});

app.listen(3000, () => {
  console.log("🔥 Servidor rodando em: http://localhost:3000");
});