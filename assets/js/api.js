const API = {
  async request(url, options={}) {
    const res = await fetch('../' + url, {
      credentials:'same-origin',
      headers:{'Content-Type':'application/json', ...(options.headers||{})},
      ...options
    });
    const data = await res.json().catch(()=>({success:false,message:'Invalid server response'}));
    if(!res.ok || !data.success) throw new Error(data.message || 'Request failed');
    return data;
  },
  get(url){return this.request(url);},
  post(url, body){return this.request(url,{method:'POST',body:JSON.stringify(body)});},
  put(url, body){return this.request(url,{method:'PUT',body:JSON.stringify(body)});},
  delete(url){return this.request(url,{method:'DELETE'});}
};
