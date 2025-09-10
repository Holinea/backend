<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$me = $me ?? [];
$active = 'agenda';
?>

<link rel="stylesheet" href="./Content/css/holinea_agenda.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<div class="layout agenda-layout">
  <!-- Sidebar (pliable) -->
  <aside class="sidebar">
    <div class="brand">
      <button class="collapse-btn" aria-label="Replier la navigation" aria-expanded="true">
        <i class="fa-solid fa-bars"></i>
      </button>
      <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
    </div>

    <nav class="menu">
      <a href="index.php?Controller=clients&action=index" class="item">
        <i class="fa-solid fa-users"></i> <span class="txt">Mes clients</span>
      </a>
      <a href="index.php?Controller=agenda&action=index" class="item active">
        <i class="fa-solid fa-calendar"></i> <span class="txt">Agenda</span>
      </a>
      <a href="#" class="item"><i class="fa-solid fa-chart-line"></i> <span class="txt">Mes Statistiques</span></a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> <span class="txt">Messagerie</span></a>
      <a href="index.php?Controller=agenda&action=settings" class="item"><i class="fa-solid fa-gear"></i> <span class="txt">Paramètres</span></a>
    </nav>

    <div class="sidebar-cta">
      <div class="me">
        <img src="<?= h($me['avatar'] ?? 'Content/img/avatar.png') ?>" class="me-avatar" alt="">
        <div class="me-meta">
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
        <option value="free" selected>Disponible</option>
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
      <option value="cabinet" selected>Cabinet / Visio</option>
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
      <p>Les créneaux s’enregistrent en base et alimentent l’annuaire (recherche).</p>
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
        <a href="index.php?Controller=agenda&action=settings" class="btn dark">Paramètres</a>
        <a href="index.php?Controller=agenda&action=sessions" class="btn soft">Voir mes séances</a>
        <button id="markAllFree" class="btn green">Tout disponible</button>
      </div>
    </header>

    <!-- en-têtes des jours (Lun..Dim) -->
    <div class="weekdays" id="weekdays"></div>
    <section id="calendar" class="calendar month"></section>
  </main>
</div>

<!-- ===== Sidebar: toggle + persistance (UI) ===== -->
<script>
(function(){
  const KEY = 'holinea_sidebar_collapsed';
  const layout = document.querySelector('.layout');
  const btn = document.querySelector('.collapse-btn');
  const collapsed = localStorage.getItem(KEY) === '1';
  if (collapsed) layout.classList.add('is-collapsed');
  if (btn) btn.setAttribute('aria-expanded', (!collapsed).toString());
  document.querySelectorAll('.menu .item').forEach(a=>{
    const t = a.querySelector('.txt')?.textContent?.trim();
    if (t) a.title = t;
  });
  btn && btn.addEventListener('click', ()=>{
    const isCollapsed = layout.classList.toggle('is-collapsed');
    localStorage.setItem(KEY, isCollapsed ? '1' : '0');
    btn.setAttribute('aria-expanded', (!isCollapsed).toString());
  });
})();
</script>

<!-- ====== Agenda connecté à la base (API JSON) ====== -->
<script>
const $  = (s,root=document)=>root.querySelector(s);
const $$ = (s,root=document)=>[...root.querySelectorAll(s)];

let current = new Date();                                     // mois/semaine affiché
let view    = localStorage.getItem('agenda_view') || 'month'; // 'month' | 'week'
let slots   = [];                                             // données venant de l'API

const WD = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];

/* ---------- UI helpers ---------- */
function renderWeekdays(){
  $('#weekdays').innerHTML = WD.map(d=>`<div class="wd">${d}</div>`).join('');
}
function updateMonthLabel(){
  const m = current.toLocaleString('fr-FR',{month:'long', year:'numeric'});
  $('#curMonth').textContent = m.charAt(0).toUpperCase()+m.slice(1);
}
function sameDate(a,b){
  return a.getFullYear()===b.getFullYear() && a.getMonth()===b.getMonth() && a.getDate()===b.getDate();
}

/* ---------- Range (from/to) selon la vue ---------- */
function getMonthRange(dt){
  const y = dt.getFullYear(), m = dt.getMonth();
  const first = new Date(y,m,1);
  const last  = new Date(y,m+1,0);
  return { from:first.toISOString().slice(0,10), to:last.toISOString().slice(0,10) };
}
function getWeekRange(dt){
  const d0 = new Date(dt);
  d0.setDate(d0.getDate() - ((d0.getDay()+6)%7)); // lundi
  const d6 = new Date(d0); d6.setDate(d0.getDate()+6);
  return { from:d0.toISOString().slice(0,10), to:d6.toISOString().slice(0,10) };
}
function getRange(){
  return view==='month' ? getMonthRange(current) : getWeekRange(current);
}

/* ---------- Rendu grille ---------- */
function dayCell(date){
  const c = document.createElement('div');
  c.className = 'cell';
  c.dataset.date = date.toISOString().slice(0,10);
  if (sameDate(date, new Date())) c.classList.add('today');

  const h = document.createElement('div');
  h.className = 'cell-head';
  h.textContent = date.getDate();
  c.appendChild(h);

  const list = document.createElement('div');
  list.className = 'events';
  c.appendChild(list);

  c.addEventListener('click', ()=>{ $('#f-date').value = c.dataset.date; });
  return c;
}
function renderGrid(){
  renderWeekdays();
  const cal = $('#calendar');
  cal.className = 'calendar '+view;
  cal.innerHTML = '';

  if(view==='month'){
    const y = current.getFullYear(), m = current.getMonth();
    const first = new Date(y,m,1);
    const start = new Date(first);
    start.setDate(1 - ((first.getDay()+6)%7)); // Lundi de la grille
    for(let i=0;i<42;i++){
      const d = new Date(start); d.setDate(start.getDate()+i);
      const cell = dayCell(d);
      if(d.getMonth()!==m) cell.classList.add('muted');
      cal.appendChild(cell);
    }
  } else {
    const d0 = new Date(current);
    d0.setDate(d0.getDate() - ((d0.getDay()+6)%7));
    for(let i=0;i<7;i++){
      const d = new Date(d0); d.setDate(d0.getDate()+i);
      const col = dayCell(d); col.classList.add('weekcol');
      cal.appendChild(col);
    }
  }
}

/* ---------- Remplissage des évts ---------- */
function fillEvents(){
  const f = $('#filterType').value; // all | free | rdv | block
  $$('.events').forEach(e=>e.innerHTML='');

  // on trie pour un rendu stable
  const sorted = [...slots].sort((a,b)=>{
    if (a.date!==b.date) return a.date < b.date ? -1 : 1;
    return (a.start||'') < (b.start||'') ? -1 : 1;
  });

  for(const ev of sorted){
    if (f!=='all' && ev.status!==f) continue;
    const box = document.querySelector(`.cell[data-date="${ev.date}"] .events`);
    if(!box) continue;
    const pill = document.createElement('div');
    pill.className = `evt ${ev.status}`;
    const label = (ev.title && ev.title.trim()!=='' ? ev.title : (ev.status==='free'?'Créneau dispo':ev.status));
    pill.innerHTML = `<span class="t">${(ev.start||'').slice(0,5)}</span> <span class="txt">${label}</span>`;
    box.appendChild(pill);
  }
}

/* ---------- Appels API ---------- */
async function fetchSlots(){
  const r = getRange();
  const res = await fetch(`index.php?Controller=agenda&action=api_slots&from=${r.from}&to=${r.to}`, {credentials:'same-origin'});
  if(!res.ok) throw new Error('fetch slots');
  const json = await res.json();
  slots = json.slots || [];
  // désactive le bouton si tout le mois/semaine est déjà dispo
  const btn = $('#markAllFree');
  if (btn){
    btn.disabled = !!json.all_free;
    btn.title = btn.disabled ? 'Déjà tout disponible pour la période' : '';
  }
}
async function postJSON(url, payload){
  const res = await fetch(url, {
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body: JSON.stringify(payload),
    credentials:'same-origin'
  });
  if(!res.ok) throw new Error('post '+url);
  return res.json();
}

/* ---------- Actions UI ---------- */
function renderAll(){
  updateMonthLabel();
  renderGrid();
  fillEvents();
}

$('#prev').onclick = async ()=>{
  if(view==='month') current.setMonth(current.getMonth()-1);
  else current.setDate(current.getDate()-7);
  renderAll();
  await fetchSlots().then(fillEvents).catch(()=>{});
};
$('#next').onclick = async ()=>{
  if(view==='month') current.setMonth(current.getMonth()+1);
  else current.setDate(current.getDate()+7);
  renderAll();
  await fetchSlots().then(fillEvents).catch(()=>{});
};
$('#todayBtn').onclick = async ()=>{
  current = new Date();
  renderAll();
  await fetchSlots().then(fillEvents).catch(()=>{});
};
$('#viewMode').onchange = async (e)=>{
  view = e.target.value;
  localStorage.setItem('agenda_view', view);
  renderAll();
  await fetchSlots().then(fillEvents).catch(()=>{});
};
$('#filterType').onchange = ()=> fillEvents();

$('#save-slot').onclick = async ()=>{
  const ev = {
    date:  $('#f-date').value || new Date().toISOString().slice(0,10),
    status:$('#f-status').value,
    start: $('#f-start').value || '09:00',
    end:   $('#f-end').value   || '09:45',
    title: $('#f-title').value.trim(),
    place: $('#f-place').value
  };
  try{
    const json = await postJSON('index.php?Controller=agenda&action=api_save_slot', ev);
    // si doublon exact, on ne ré-affiche pas deux fois (l’unicité DB nous protège déjà)
    await fetchSlots();
    fillEvents();
    $('#f-title').value = '';
  }catch(e){ console.error(e); }
};

$('#markAllFree').onclick = async ()=>{
  const y = current.getFullYear();
  const m = String(current.getMonth()+1).padStart(2,'0');
  const month = `${y}-${m}`;                                   // YYYY-MM
  const json = await postJSON('index.php?Controller=agenda&action=api_mark_all_free', {
    month, start: $('#f-start').value || '09:00', end: $('#f-end').value || '09:45'
  });
  // si tout est désormais dispo, on désactive le bouton
  const btn = $('#markAllFree');
  btn.disabled = !!json.all_free;
  await fetchSlots(); fillEvents();
};

/* ---------- Initialisation ---------- */
(function init(){
  $('#viewMode').value = view;
  renderAll();                 // dessine la grille immédiatement
  fetchSlots().then(fillEvents).catch(()=>{}); // puis charge depuis l’API
})();

// <button class="btn soft">Voir mes séances</button>
</script>

