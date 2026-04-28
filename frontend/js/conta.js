const API = "http://localhost:3000/auth";
const usuarioId = localStorage.getItem("usuarioId");

if (!usuarioId) {
  alert("Você precisa estar logado!");
  window.location.href = "login.html";
}

fetch(`${API}/usuario?id=${usuarioId}`)
  .then(res => {
    if (!res.ok) throw new Error("Erro ao buscar usuário");
    return res.json();
  })
  .then(data => {
    if (!data) return;

    document.getElementById("nome").innerText = data.nome;
    document.getElementById("email").innerText = data.email;
    document.getElementById("telefone").innerText = data.telefone;
    document.getElementById("endereco").innerText = data.endereco;
    document.getElementById("cidade").innerText = data.cidade;
    document.getElementById("estado").innerText = data.estado;

    document.getElementById("fotoPerfil").src =
      data.foto
        ? `http://localhost:3000/uploads/${data.foto}`
        : "img/user.png";
  })
  .catch(err => {
    console.error(err);
    alert("Erro ao carregar dados do usuário");
  });


fetch(`http://localhost:3000/pedidos/usuario/${usuarioId}`)
  .then(res => res.json())
  .then(pedidos => {
    const areaPedidos = document.getElementById("lista-pedidos");

    if (!pedidos || pedidos.length === 0) {
      areaPedidos.innerHTML = "<p>Você ainda não fez nenhum pedido.</p>";
      return;
    }

    areaPedidos.innerHTML = pedidos.map(pedido => `
      <div class="pedido-card">
        <img 
          src="${pedido.imagem ? pedido.imagem : 'img/produto.png'}" 
          class="pedido-img"
        >

        <div class="pedido-info">
          <h3>${pedido.nome}</h3>
          <p><strong>Pedido:</strong> #${pedido.id_pedido}</p>
          <p><strong>Quantidade:</strong> ${pedido.quantidade}</p>
          <p><strong>Preço:</strong> R$ ${Number(pedido.preco).toFixed(2)}</p>
          <p><strong>Data:</strong> ${new Date(pedido.data).toLocaleDateString("pt-BR")}</p>
        </div>
      </div>
    `).join("");
  })
  .catch(err => {
    console.error("Erro ao carregar pedidos:", err);
  });

function enviarFoto() {
  const file = document.getElementById("inputFoto").files[0];

  if (!file) {
    alert("Escolha uma imagem");
    return;
  }

  const formData = new FormData();
  formData.append("foto", file);
  formData.append("usuarioId", usuarioId);

  fetch(`${API}/upload-foto`, {
    method: "POST",
    body: formData
  })
    .then(res => res.json())
    .then(() => {
      alert("Foto atualizada!");
      location.reload();
    })
    .catch(() => {
      alert("Erro ao enviar foto");
    });
}

function logout() {
  localStorage.removeItem("usuarioId");
  window.location.href = "login.html";
}