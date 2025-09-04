<section class="features">
  <div class="container features-list">
    <div>
      <h2>Pourquoi Holinea ?</h2>
      <ul>
        <li>🌱 Parcours de santé personnalisés par IA</li>
        <li>🤝 Approche globale (physique & mentale)</li>
        <li>🧑‍⚕️ Praticiens certifiés, coaching, formations</li>
        <li>📊 Tableau de bord, suivi et ajustement</li>
        <li>🔒 Données sécurisées & confidentialité</li>
      </ul>
      <a href="#" class="btn">Rejoindre maintenant</a>
    </div>
    <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=500&q=80" alt="Santé holistique" class="feature-img">
  </div>
</section>
<footer>
  <div class="container">
    <p>&copy; 2025 Holinea • <a href="#">Mentions légales</a> • <a href="#">Contact</a></p>
  </div>
</footer>
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

</body>
</html>
