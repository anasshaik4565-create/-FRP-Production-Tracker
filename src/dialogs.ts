function dialog(message:string, initial?:string):Promise<string|null|boolean>{
 return new Promise(resolve=>{
  const previous=document.activeElement as HTMLElement|null;
  const node=document.createElement('dialog');node.className='center-dialog';node.setAttribute('aria-labelledby','dialog-title');
  const form=document.createElement('form');form.method='dialog';
  const title=document.createElement('h2');title.id='dialog-title';title.textContent=initial===undefined?'Confirm Action':message;
  form.append(title);
  const input=document.createElement('input');
  if(initial!==undefined){input.value=initial;input.setAttribute('aria-label',message);form.append(input)}else{const text=document.createElement('p');text.textContent=message;form.append(text)}
  const actions=document.createElement('div');actions.className='dialog-actions';
  const cancel=document.createElement('button');cancel.type='button';cancel.className='secondary-button';cancel.textContent='Cancel';cancel.onclick=()=>node.close('cancel');
  const ok=document.createElement('button');ok.type='submit';ok.value='ok';ok.textContent=initial===undefined?'Confirm':'Save';actions.append(cancel,ok);form.append(actions);node.append(form);document.body.append(node);
  form.addEventListener('submit',e=>{e.preventDefault();node.close('ok')});
  node.addEventListener('cancel',e=>{e.preventDefault();node.close('cancel')});
  node.addEventListener('close',()=>{const accepted=node.returnValue==='ok';node.remove();previous?.focus();resolve(initial===undefined?accepted:accepted?input.value:null)},{once:true});
  node.showModal();if(initial!==undefined){input.focus();input.select()}else cancel.focus();
 });
}
export async function askConfirm(message:string):Promise<boolean>{return (await dialog(message))===true}
export async function askText(message:string,initial=''):Promise<string|null>{const result=await dialog(message,initial);return typeof result==='string'?result:null}
