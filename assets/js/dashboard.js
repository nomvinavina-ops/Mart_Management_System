window.addEventListener('layout-ready',()=>{
  const page=document.getElementById('page');
  page.innerHTML=`<div class="page-title"><div><h1>Dashboard</h1><p>Welcome back, ${window.currentUser.username}</p></div></div>
  <div class="cards">
    <div class="stat blue"><span>📦</span><div><small>Total Products</small><strong id="productsCount">-</strong></div></div>
    <div class="stat green"><span>💵</span><div><small>Today's Sales</small><strong id="todaySales">$0.00</strong></div></div>
    <div class="stat purple"><span>👥</span><div><small>Total Customers</small><strong>—</strong></div></div>
    <div class="stat orange"><span>🚚</span><div><small>Total Suppliers</small><strong>—</strong></div></div>
  </div>
  <div class="grid2"><div class="panel"><h3>Sales Overview</h3><canvas id="salesChart" height="150"></canvas></div><div class="panel"><h3>Low Stock Alerts</h3><div id="lowStock">Loading...</div></div></div>
  <div class="panel"><h3>Quick Actions</h3><div class="quick"><a href="products.html">+ Add Product</a><a href="pos.html">Open POS</a><a href="reports.html">View Reports</a></div></div>`;
  loadDash();
});
async function loadDash(){
  try{
    const p=await API.get('api/products/index.php'); document.getElementById('productsCount').textContent=p.data.length;
    const inv=await API.get('api/inventory/index.php'); const low=inv.data.filter(x=>+x.quantity<=5);
    document.getElementById('lowStock').innerHTML=low.length?low.map(x=>`<div class="stock-row"><b>${x.product_name}</b><span class="badge low">${x.quantity} Low</span></div>`).join(''):'<p class="muted">No low-stock products.</p>';
  }catch(e){console.error(e);}
}
