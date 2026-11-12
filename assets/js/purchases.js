window.addEventListener('layout-ready',()=>{
 document.getElementById('page').innerHTML=`<div class="page-title"><div><h1>Purchase Management</h1><p>Create purchase orders and increase inventory.</p></div></div><div class="panel"><div class="empty-state">Purchase API is available at <code>api/purchases/create.php</code>. Build the purchase cart here using the same product selection pattern as POS.</div></div>`;
});
