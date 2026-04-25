const usuarioId = localStorage.getItem("usuarioId");

let total = 0;

function carregarCarrinho() {
  fetch(`http://localhost:3000/carrinho/${usuarioId}`)
    .then(res => res.json())
    .then(produtos => {
      const lista = document.getElementById("listaCarrinho");
      const totalEl = document.getElementById("total");

      lista.innerHTML = "";
      total = 0;

      if (produtos.length === 0) {
        lista.innerHTML = "<p>Seu carrinho está vazio 🛒</p>";
        totalEl.innerText = "R$ 0,00";
        return;
      }

      produtos.forEach(item => {
        total += Number(item.preco) * Number(item.quantidade);

        const div = document.createElement("div");
        div.classList.add("card");

        div.innerHTML = `
          <img src="${item.imagem}">
          <h3>${item.nome}</h3>
          <p>Qtd: ${item.quantidade}</p>
          <p>R$ ${Number(item.preco).toFixed(2)}</p>
          <button onclick="removerItem(${item.id_carrinho})">
            Remover
          </button>
        `;

        lista.appendChild(div);
      });

      totalEl.innerText = "R$ " + total.toFixed(2);
    });
}

function removerItem(id) {
  fetch(`http://localhost:3000/carrinho/${id}`, {
    method: "DELETE"
  })
    .then(() => carregarCarrinho());
}

function finalizarCompra() {
  const pagamento = document.getElementById("pagamento").value;

  if (!pagamento) {
    alert("Escolha uma forma de pagamento!");
    return;
  }

  fetch("http://localhost:3000/finalizar-pedido", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      usuario_id: usuarioId
    })
  })
    .then(res => res.json())
    .then(data => {
      if (data.erro) {
        alert(data.erro);
        return;
      }

      alert(`Compra finalizada com sucesso!\nPagamento: ${pagamento}\nTotal: R$ ${total.toFixed(2)}`);
      window.location.href = "conta.html";
    })
    .catch(() => {
      alert("Erro ao finalizar compra");
    });
}

carregarCarrinho();