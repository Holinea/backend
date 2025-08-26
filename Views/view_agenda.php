<?php
    
    require "view_begin_therapeute.php";
?>

<!-- FullCalendar CSS & JS CDN (charge à la volée, pas besoin d'installation) -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

<style>
  #agenda-calendar {
    max-width: 850px;
    margin: 32px auto;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.07);
    padding: 18px;
  }
  .fc-toolbar-title {
    color: #15193a; /* holinea-bleu-fonce */
  }
  .fc-button-primary {
    background: #f27c5a;  /* holinea-orange */
    border: none;
  }
  .fc-event, .fc-event-dot {
    background: #90d7bd !important; /* holinea-vert-eau */
    border: 1px solid #fbbfa6;
  }
</style>

<section class="agenda-thera">
    <div class="container">
        <h2 style="text-align:center; margin-top:1.5em;">Mon agenda thérapeute</h2>
        <div id='agenda-calendar'></div>
    </div>
</section>

<script>
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('agenda-calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    locale: 'fr',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    buttonText: {
      today:    'Aujourd\'hui',
      month:    'Mois',
      week:     'Semaine',
      day:      'Jour'
    },
    events: [
      // Evénements de test, à remplacer par la BDD
      {
        title: 'Consultation - Jean Dupont',
        start: '2025-08-02T14:00:00',
        end:   '2025-08-02T15:00:00',
        color: '#ffd447'
      },
      {
        title: 'Visio - Sophie Martin',
        start: '2025-08-05T10:00:00',
        end:   '2025-08-05T10:45:00'
      },
      {
        title: 'Congé',
        start: '2025-08-07',
        allDay: true,
        color: '#fbbfa6'
      }
    ]
  });
  calendar.render();
});
</script>

<?php
    require "view_end.php";
?>
