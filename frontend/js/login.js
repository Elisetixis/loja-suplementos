const API = "http://localhost:3000/auth";

function login() {
  const email = document.getElementById("email").value;
  const senha = document.getElementById("senha").value;

  fetch(`${API}/login`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ email, senha })
  })
    .then(res => res.json())
    .then(data => {
      console.log("LOGIN:", data);

      if (data.erro) {
        alert(data.erro);
        return;
      }

      localStorage.setItem("usuarioId", data.usuarioId);


      alert("Login realizado com sucesso!");

      window.location.href = "index.html";
    })
    .catch(() => {
      alert("Erro ao logar");
    });
}