const API = "http://localhost:3000/auth";

// LOGIN
const formLogin = document.getElementById("formLogin");

if (formLogin) {
  formLogin.addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    const res = await fetch(`${API}/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, senha })
    });

    const data = await res.json();

    if (res.ok) {
      localStorage.setItem("usuarioId", data.usuarioId);
      window.location.href = "index.html";
    } else {
      alert(data.erro);
    }
  });
}

// CADASTRO
const formCadastro = document.getElementById("formCadastro");

if (formCadastro) {
  formCadastro.addEventListener("submit", async (e) => {
    e.preventDefault();

    const nome = document.getElementById("nome").value;
    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;
    const telefone = document.getElementById("telefone").value;
    const endereco = document.getElementById("endereco").value;
    const cidade = document.getElementById("cidade").value;
    const estado = document.getElementById("estado").value;
    const foto = document.getElementById("foto").files[0];

    // CADASTRO
    const res = await fetch(`${API}/cadastro`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        nome, email, senha, telefone, endereco, cidade, estado
      })
    });

    const data = await res.json();

    if (!res.ok) {
      return alert(data.erro);
    }

    // LOGIN AUTOMÁTICO
    const loginRes = await fetch(`${API}/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, senha })
    });

    const loginData = await loginRes.json();
    const usuarioId = loginData.usuarioId;

    localStorage.setItem("usuarioId", usuarioId);

    // UPLOAD FOTO (SE EXISTIR)
    if (foto) {
      const formData = new FormData();
      formData.append("foto", foto);
      formData.append("usuarioId", usuarioId);

      await fetch(`${API}/upload-foto`, {
        method: "POST",
        body: formData
      });
    }

    alert("Cadastro realizado!");
    window.location.href = "index.html";
  });
}