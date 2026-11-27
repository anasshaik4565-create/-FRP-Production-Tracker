import {db} from './db.js';
import bcrypt from 'bcryptjs';
import readline from 'node:readline/promises';
const r=readline.createInterface({input:process.stdin,output:process.stdout});
try {const email=(await r.question('Email: ')).trim().toLowerCase();const role=(await r.question('Role (ADMIN/READER): ')).trim().toUpperCase();const password=await r.question('Password (visible locally): ');if(!email.includes('@')||!['ADMIN','READER'].includes(role)||password.length<12)throw Error('Valid email, role and password of at least 12 characters required');const hash=await bcrypt.hash(password,12);await db.user.upsert({where:{email},create:{email,role,password:hash},update:{role,password:hash,active:true}});console.log('Account saved');}finally{r.close();await db.$disconnect();}
