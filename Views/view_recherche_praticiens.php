<?php require "view_begin.php"; ?>

<?php
// valeurs initiales
$modalite   = $modalite   ?? ($_POST['modalite']   ?? 'cabinet');
$specialite = $specialite ?? ($_POST['specialite'] ?? '');
$approche   = $approche   ?? ($_POST['approche']   ?? '');
$ville_cp   = $ville_cp   ?? ($_POST['ville_cp']   ?? '');
?>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_recherche.css"/>

<div class="holinea-search-wrap">
  <form method="POST" action="index.php?Controller=recherche&action=recherche" class="holinea-search-form">
    <!-- Toggle CABINET / DISTANCE -->
    <div class="toggle-pill">
      <input class="toggle-radio" type="radio" id="cabinet"  name="modalite" value="cabinet"  <?= ($modalite==='cabinet'?'checked':'') ?>>
      <input class="toggle-radio" type="radio" id="distance" name="modalite" value="distance" <?= ($modalite==='distance'?'checked':'') ?>>
      <div class="pill">
        <label for="cabinet" class="pill-opt">
          <i class="fa-solid fa-building"></i>
          <span>CABINET</span>
        </label>
        <label for="distance" class="pill-opt">
          <i class="fa-solid fa-video"></i>
          <span>DISTANCE</span>
        </label>
        <span class="pill-slider" aria-hidden="true"></span>
      </div>
    </div>

    <!-- Filtres -->
    <div class="filters-row">
      <!-- Spécialité (écriture + suggestions) -->
      <div class="select">
        <input
          type="text"
          name="specialite"
          list="dl-specialites"
          placeholder="Spécialité (ex : Naturopathe)"
          value="<?= htmlspecialchars($specialite) ?>"
          class="input-text"
          aria-label="Spécialité (saisie libre)">
        <datalist id="dl-specialites">
          <?php foreach (($specialites ?? []) as $s): ?>
            <option value="<?= htmlspecialchars($s) ?>"></option>
          <?php endforeach; ?>
        </datalist>
      </div>

      <!-- Ville/CP avec SUGGESTIONS AJAX (affiché seulement en mode CABINET via CSS) -->
      <div class="select field-localisation" style="position:relative">
        <input
          type="text"
          id="ville_cp"
          name="ville_cp"
          placeholder="Ville ou code postal"
          value="<?= htmlspecialchars($ville_cp) ?>"
          class="input-loc"
          autocomplete="off"
          aria-label="Ville ou code postal">
        <ul id="ville_suggest" class="suggest"></ul>
      </div>

      <!-- Type d'approche (écriture + suggestions) -->
      <div class="select">
        <input
          type="text"
          name="approche"
          list="dl-approches"
          placeholder="Type d’approche"
          value="<?= htmlspecialchars($approche) ?>"
          class="input-text"
          aria-label="Type d’approche (saisie libre)">
        <datalist id="dl-approches">
          <?php foreach (($approches ?? []) as $a): ?>
            <option value="<?= htmlspecialchars($a) ?>"></option>
          <?php endforeach; ?>
        </datalist>
      </div>

      <!-- Bouton -->
      <button class="btn-search" type="submit">
        <i class="fa-solid fa-magnifying-glass"></i>
        <span>Rechercher</span>
      </button>
    </div>
  </form>
</div>

<!-- JS: suggestions AJAX pour Ville/CP -->
<script>
(function(){
  const input   = document.getElementById('ville_cp');
  const list    = document.getElementById('ville_suggest');
  const form    = document.querySelector('.holinea-search-form');
  let aborter   = null;
  let idx       = -1;
  let items     = [];

  // petit utilitaire debounce
  const debounce = (fn, d=220) => { let t; return (...a)=>{ clearTimeout(t); t=setTimeout(()=>fn(...a), d); }; };

  // Rendu des items
  function render(data){
    items = data || [];
    list.innerHTML = '';
    if (!items.length){ list.classList.remove('show'); idx = -1; return; }
    items.forEach((it,i)=>{
      const li = document.createElement('li');
      li.innerHTML = `<strong>${it.cp}</strong> ${it.ville}`;
      li.addEventListener('mousedown', (e)=>{ e.preventDefault(); choose(i); });
      list.appendChild(li);
    });
    list.classList.add('show');
    idx = -1;
  }

  // Choix d'un item
  function choose(i){
    const it = items[i];
    if (!it) return;
    input.value = `${it.cp} ${it.ville}`;
    list.classList.remove('show');
  }

  // Appel AJAX
  const fetchIt = debounce(async (term)=>{
    term = term.trim();
    if (!term || term.length < 2){ render([]); return; }
    if (aborter) aborter.abort();
    aborter = new AbortController();
    try{
      const url = `index.php?Controller=api&action=villes&term=${encodeURIComponent(term)}&limit=10`;
      const r = await fetch(url, {signal: aborter.signal});
      if (!r.ok) throw new Error('http');
      const data = await r.json();
      render(data);
    }catch(e){/* abort ignore */}
  }, 220);

  input?.addEventListener('input', e => fetchIt(e.target.value));

  // Fermer au clic extérieur
  document.addEventListener('click', (e)=>{
    if (!list.contains(e.target) && e.target !== input) list.classList.remove('show');
  });

  // Navigation clavier
  input?.addEventListener('keydown', (e)=>{
    if (!list.classList.contains('show')) return;
    const len = list.children.length;
    if (e.key === 'ArrowDown'){ e.preventDefault(); idx = (idx+1) % len; highlight(); }
    else if (e.key === 'ArrowUp'){ e.preventDefault(); idx = (idx-1+len) % len; highlight(); }
    else if (e.key === 'Enter'){ e.preventDefault(); if (idx>=0) choose(idx); else form.requestSubmit(); }
    else if (e.key === 'Escape'){ list.classList.remove('show'); }
  });

  function highlight(){
    [...list.children].forEach((li,i)=>{
      li.style.background = (i===idx) ? '#eef2ff' : '';
    });
    if (idx>=0) list.children[idx].scrollIntoView({block:'nearest'});
  }
})();
</script>

<?php require "view_end.php"; ?>
