document.getElementById('loginForm').addEventListener('submit', async e=>{
  e.preventDefault();
  const error=document.getElementById('loginError'); error.textContent='';
  try{
    await API.post('api/auth/login.php',{
      login:document.getElementById('login').value.trim(),
      password:document.getElementById('password').value
    });
    location.href='dashboard.html';
  }catch(err){error.textContent=err.message;}
});
