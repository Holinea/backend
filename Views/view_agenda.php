<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$me = $me ?? [];
?>
<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="./Content/css/holinea_agenda.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<div class="layout agenda-layout">
  <!-- Sidebar de nav (facultative). Tu peux réutiliser celle des clients si tu préfères -->
  <aside class="sidebar">
    <div class="brand">
      <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
    </div>
    <nav class="menu">
      <a href="index.php?Controller=clients&action=index" class="item">
        <i class="fa-solid fa-users"></i> Mes clients
      </a>
      <a href="index.php?Controller=agenda&action=index" class="item active">
        <i class="fa-solid fa-calendar"></i> Agenda
      </a>
      <a href="#" class="item"><i class="fa-solid fa-chart-line"></i> Mes Statistiques</a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> Messagerie</a>
      <a href="#" class="item"><i class="fa-solid fa-gear"></i> Paramètres</a>
    </nav>

    <div class="sidebar-cta">
      <div class="me">
        <img src="<?= h($me['avatar'] ?? 'Content/img/avatar.png') ?>" class="me-avatar" alt="">
        <div>
          <div class="me-name"><?= h($me['name'] ?? '—') ?></div>
          <div class="me-role"><?= h($me['role'] ?? '') ?></div>
        </div>
      </div>
    </div>
  </aside>

  <!-- Colonne gauche : création rapide -->
  <aside class="agenda-left">
    <h3>Création rapide</h3>

    <label>Date</label>
    <input id="f-date" type="date">

    <label>Statut</label>
    <div class="row">
      <select id="f-status">
        <option value="rdv">RDV</option>
        <option value="free">Disponible</option>
        <option value="block">Bloqué</option>
      </select>
    </div>

    <label>Début</label>
    <input id="f-start" type="time" value="09:00">

    <label>Fin</label>
    <input id="f-end" type="time" value="09:45">

    <label>Titre (client / note)</label>
    <input id="f-title" type="text" placeholder="Ex: RDV — Marc Dupont">

    <label>Lieu</label>
    <select id="f-place">
      <option value="cabinet">Cabinet / Visio</option>
      <option value="cabinet_only">Cabinet</option>
      <option value="visio">Visio</option>
    </select>

    <button id="save-slot" class="btn primary full">Enregistrer le créneau</button>

    <div class="legend">
      <h3>Légende</h3>
      <div class="chip chip-rdv">RDV</div>
      <div class="chip chip-free">Disponible</div>
      <div class="chip chip-block">Bloqué</div>
    </div>

    <div class="tip">
      <h3>Conseil</h3>
      <p>
        Cliquez un jour (vue mois) ou une colonne (vue semaine)
        pour préremplir la création avec cette date/colonne.
        Les données sont enregistrées dans <strong>localStorage</strong> (<code>holinea_agenda</code>).
      </p>
    </div>
  </aside>

  <!-- Zone calendrier -->
  <main class="agenda-main">
    <header class="agenda-topbar">
      <div class="title"><i class="fa-solid fa-calendar-check"></i> Mon agenda</div>

      <div class="toolbar">
        <button id="prev" class="btn ghost"><i class="fa-solid fa-chevron-left"></i></button>
        <div id="curMonth" class="pill"></div>
        <button id="next" class="btn ghost"><i class="fa-solid fa-chevron-right"></i></button>

        <select id="viewMode" class="btn ghost">
          <option value="month">Vue mois</option>
          <option value="week">Vue semaine</option>
        </select>

        <select id="filterType" class="btn ghost">
          <option value="all">Tous</option>
          <option value="rdv">RDV</option>
          <option value="free">Disponible</option>
          <option value="block">Bloqué</option>
        </select>

        <button id="todayBtn" class="btn ghost">Aujourd’hui</button>
        <button class="btn soft">Voir mes séances</button>
        <button id="markAllFree" class="btn green">Tout disponible</button>
        <button class="btn dark">Paramètres</button>
      </div>
    </header>

    <section id="calendar" class="calendar month"></section>
  </main>
</div>

<script>
// ====== Mini "agendrier" sans lib, avec persistance localStorage ======
const storeKey = 'holinea_agenda';
const $ = (s,root=document)=>root.querySelector(s);
const $$ = (s,root=document)=>[...root.querySelectorAll(s)];

let current = new Date(); // mois affiché
let view = localStorage.getItem('agenda_view') || 'month';

const data = load();
renderToolbar();
render();

function load(){
  try { return JSON.parse(localStorage.getItem(storeKey) || '[]'); }
  catch(e){ return []; }
}
function save(){ localStorage.setItem(storeKey, JSON.stringify(data)); }

function renderToolbar(){
  $('#viewMode').value = view;
  updateMonthLabel();
}
function updateMonthLabel(){
  const m = current.toLocaleString('fr-FR',{month:'long', year:'numeric'});
  $('#curMonth').textContent = m.charAt(0).toUpperCase()+m.slice(1);
}

$('#prev').onclick = ()=>{ view==='month' ? current.setMonth(current.getMonth()-1)
                                         : current.setDate(current.getDate()-7);
                           updateMonthLabel(); render(); };
$('#next').onclick = ()=>{ view==='month' ? current.setMonth(current.getMonth()+1)
                                         : current.setDate(current.getDate()+7);
                           updateMonthLabel(); render(); };
$('#todayBtn').onclick = ()=>{ current = new Date(); updateMonthLabel(); render(); };
$('#viewMode').onchange = e=>{ view = e.target.value; localStorage.setItem('agenda_view',view); render(); };
$('#filterType').onchange = ()=> render();
$('#markAllFree').onclick = ()=>{
  // marque tous les jours du mois courant comme "Disponible" à 09:00-09:45 (démo)
  const y = current.getFullYear(), m = current.getMonth();
  const d = new Date(y,m,1);
  while(d.getMonth()===m){
    data.push({date:d.toISOString().slice(0,10),start:'09:00',end:'09:45',status:'free',title:'Créneau dispo',place:'cabinet'});
    d.setDate(d.getDate()+1);
  }
  save(); render();
};

function render(){
  const cal = $('#calendar');
  cal.className = 'calendar '+view;
  cal.innerHTML = '';
  if(view==='month') renderMonth(cal); else renderWeek(cal);
}

function dayCell(date){
  const c = document.createElement('div');
  c.className = 'cell';
  c.dataset.date = date.toISOString().slice(0,10);

  const h = document.createElement('div');
  h.className = 'cell-head';
  h.textContent = date.getDate();
  c.appendChild(h);

  const list = document.createElement('div');
  list.className = 'events';
  c.appendChild(list);

  c.addEventListener('click', ()=>{
    $('#f-date').value = c.dataset.date;
  });

  return c;
}

function renderMonth(cal){
  const y = current.getFullYear(), m = current.getMonth();
  const first = new Date(y,m,1);
  const start = new Date(first);
  start.setDate(1 - ((first.getDay()+6)%7)); // Lundi

  for(let i=0;i<42;i++){
    const d = new Date(start); d.setDate(start.getDate()+i);
    const cell = dayCell(d);
    if(d.getMonth()!==m) cell.classList.add('muted');
    cal.appendChild(cell);
  }
  fillEvents();
}

function renderWeek(cal){
  const d0 = new Date(current);
  d0.setDate(d0.getDate() - ((d0.getDay()+6)%7)); // lundi de la semaine
  for(let i=0;i<7;i++){
    const d = new Date(d0); d.setDate(d0.getDate()+i);
    const col = dayCell(d);
    col.classList.add('weekcol');
    cal.appendChild(col);
  }
  fillEvents();
}

function fillEvents(){
  const f = $('#filterType').value;
  $$('.events').forEach(e=>e.innerHTML='');
  data.forEach(ev=>{
    if(f!=='all' && ev.status!==f) return;
    const box = document.querySelector(`.cell[data-date="${ev.date}"] .events`);
    if(!box) return;
    const pill = document.createElement('div');
    pill.className = `evt ${ev.status}`;
    pill.innerHTML = `<span class="t">${ev.start}</span> <span class="txt">${(ev.title||ev.status).slice(0,18)}</span>`;
    box.appendChild(pill);
  });
}

// === Création rapide
$('#save-slot').onclick = ()=>{
  const ev = {
    date:  $('#f-date').value || new Date().toISOString().slice(0,10),
    status:$('#f-status').value,
    start: $('#f-start').value || '09:00',
    end:   $('#f-end').value   || '09:45',
    title: $('#f-title').value.trim(),
    place: $('#f-place').value
  };
  data.push(ev); save(); render();
  $('#f-title').value = '';
};
</script>

<?php require 'view_end.php'; ?>
