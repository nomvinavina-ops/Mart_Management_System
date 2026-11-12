(async function(){
  try{
    const me=await API.get('api/auth/me.php');
    window.currentUser=me.data;
    const path=location.pathname.split('/').pop();
    const nav=[
      ['dashboard.html','🏠','Dashboard'],['products.html','📦','Products'],['pos.html','🧾','POS'],
      ['reports.html','📊','Reports'],['customers.html','👥','Customers'],['suppliers.html','🚚','Suppliers'],
      ['purchases.html','🛒','Purchases'],['inventory.html','📋','Inventory']
    ];
    document.getElementById('app').innerHTML=`
      <div class="shell">
        <aside class="sidebar"><div class="logo">🛒 <span>Mart System</span></div>
        <nav>${nav.map(n=>`<a class="${path===n[0]?'active':''}" href="${n[0]}">${n[1]} <span>${n[2]}</span></a>`).join('')}</nav>
        <button id="logout" class="logout">↪ Logout</button></aside>
        <main class="main"><header class="topbar"><button id="menu" class="menu">☰</button><input class="search" placeholder="Search..."><div class="user">🔔 <b>${me.data.username}</b><small>${me.data.role_name}</small></div></header><section id="page" class="page"></section></main>
      </div>`;
    document.getElementById('logout').onclick=async()=>{await API.post('api/auth/logout.php',{});location.href='login.html';};
    document.getElementById('menu').onclick=()=>document.querySelector('.sidebar').classList.toggle('open');
    window.dispatchEvent(new Event('layout-ready'));
  }catch(e){location.href='login.html';}
})();
