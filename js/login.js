document.getElementById("loginForm").addEventListener("submit", function(event) {
    event.preventDefault();
  
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
  
    // Send login request to PHP script
    fetch('php/verificar_login.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = "html/menu.php";
        } else {
            document.getElementById("errorMessage").textContent = "Usuário ou senha inválidos.";
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.getElementById("errorMessage").textContent = "Erro ao tentar fazer login.";
    });
});
  
const togglePassword = document.getElementById("togglePassword");
const passwordInput = document.getElementById("password");
  
togglePassword.addEventListener("click", () => {
    const isPassword = passwordInput.type === "password";
    passwordInput.type = isPassword ? "text" : "password";
    togglePassword.classList.toggle("fa-eye");
    togglePassword.classList.toggle("fa-eye-slash");
});
  