const API = "http://localhost:3000/produtos";

function carregarProdutos(url = API) {
  fetch(url)
    .then(res => res.json())
    .then(produtos => {
      const container = document.getElementById('produtos');
      container.innerHTML = '';

      produtos.forEach(p => {
        container.innerHTML += `
          <div class="card">
            <img src="${p.imagem}">
            <h3>${p.nome}</h3>
            <p>R$ ${Number(p.preco).toFixed(2)}</p>

            <div class="quantidade">
              <button onclick="diminuir(${p.id_produto})">-</button>
              <span id="qtd-${p.id_produto}">1</span>
              <button onclick="aumentar(${p.id_produto})">+</button>
            </div>

            <button onclick="adicionarCarrinho(${p.id_produto})">
              Adicionar
            </button>
          </div>
        `;
      });
    });
}


function aumentar(id) {
  const span = document.getElementById(`qtd-${id}`);
  span.innerText = Number(span.innerText) + 1;
}


function diminuir(id) {
  const span = document.getElementById(`qtd-${id}`);
  let valor = Number(span.innerText);

  if (valor > 1) {
    span.innerText = valor - 1;
  }
}


function adicionarCarrinho(produtoId) {
  const usuarioId = localStorage.getItem("usuarioId");

  if (!usuarioId) {
    alert("Você precisa estar logado!");
    window.location.href = "login.html";
    return;
  }

  const quantidade = Number(document.getElementById(`qtd-${produtoId}`).innerText);

  fetch("http://localhost:3000/carrinho", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      usuario_id: usuarioId,
      produto_id: produtoId,
      quantidade: quantidade
    })
  })
    .then(res => res.json())
    .then(() => {
      alert(`Adicionado ao carrinho (x${quantidade})`);
    });
}


function filtrar() {
  const busca = document.getElementById('busca').value;
  const marca = document.getElementById('filtroMarca').value;
  const categoria = document.getElementById('filtroCategoria').value;

  let url = API + '?';

  if (busca) url += `busca=${busca}&`;
  if (marca) url += `marca=${marca}&`;
  if (categoria) url += `categoria=${categoria}`;

  carregarProdutos(url);
}

carregarProdutos();