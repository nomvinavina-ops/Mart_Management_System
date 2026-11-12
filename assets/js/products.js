window.addEventListener('layout-ready',()=>{
  document.getElementById('page').innerHTML=`<div class="page-title"><div><h1>Products & Inventory</h1><p>Manage products, prices and stock.</p></div><button class="btn primary" id="addBtn">+ Add New Product</button></div>
  <div class="panel"><div class="toolbar"><input id="search" placeholder="Search by code or name..."><select id="cat"><option value="0">All Categories</option></select></div>
  <div class="table-wrap"><table><thead><tr><th>Code</th><th>Product Name</th><th>Category</th><th>Stock</th><th>Expiry Date</th><th>Status</th><th>Action</th></tr></thead><tbody id="rows"></tbody></table></div></div>
  <dialog id="productDialog"><form method="dialog" id="productForm" class="dialog-form"><button class="x" type="button" onclick="productDialog.close()">×</button><h2>Add New Product</h2>
  <input name="product_code" placeholder="Product Code" required><input name="product_name" placeholder="Product Name" required><input name="brand" placeholder="Brand"><input name="unit" value="pcs" placeholder="Unit">
  <input name="cost_price" type="number" min="0" step="0.01" placeholder="Cost Price" required><input name="selling_price" type="number" min="0" step="0.01" placeholder="Selling Price" required><input name="stock" type="number" min="0" placeholder="Stock" required><input name="expiry_date" type="date">
  <button class="btn primary full">Save</button><div id="productError" class="error"></div></form></dialog>`;
  const dialog=document.getElementById('productDialog');
  document.getElementById('addBtn').onclick=()=>dialog.showModal();
  async function load(){const q=encodeURIComponent(document.getElementById('search').value); const r=await API.get('api/products/index.php?search='+q); document.getElementById('rows').innerHTML=r.data.map(p=>`<tr><td>${p.product_code}</td><td>${p.product_name}</td><td>${p.category_name||'-'}</td><td>${p.quantity??0}</td><td>${p.expiry_date||'-'}</td><td><span class="badge ${+(p.quantity??0)<=5?'low':'ok'}">${+(p.quantity??0)<=5?'Low':'Available'}</span></td><td><button class="icon-btn" onclick="deleteProduct(${p.product_id})">🗑</button></td></tr>`).join('');}
  window.deleteProduct=async id=>{if(confirm('Delete this product?')){try{await API.delete('api/products/index.php?id='+id);load();}catch(e){alert(e.message);}}};
  document.getElementById('productForm').onsubmit=async e=>{e.preventDefault();const d=Object.fromEntries(new FormData(e.target));try{await API.post('api/products/index.php',d);dialog.close();e.target.reset();load();}catch(err){document.getElementById('productError').textContent=err.message;}};
  document.getElementById('search').oninput=load; load();
});
