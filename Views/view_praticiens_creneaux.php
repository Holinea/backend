<?php require "view_begin_therapeute.php"; ?>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Calendrier des créneaux des praticiens</h2>

    <div class="row" id="therapistCards">
        <?php if (!empty($praticiens)): ?>
            <?php foreach ($praticiens as $id => $praticien): ?>
                <div class="col-md-6 col-lg-4 mb-4 therapist-item"
                     data-name="<?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?>"
                     data-mode="<?= htmlspecialchars($praticien['mode_consultation']) ?>">
                    <div class="card therapist-card h-100 shadow-sm">
                        <div class="card-body text-center">
                            <img src="<?= htmlspecialchars($praticien['photo']) ?>"
                                 alt="<?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?>"
                                 class="rounded-circle mb-3" style="height: 100px; width: 100px; object-fit: cover;">
                            <h5><?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?></h5>
                            <span class="badge bg-primary mb-2"><?= htmlspecialchars($praticien['mode_consultation']) ?></span>
                            <p class="small text-muted mb-2"><?= htmlspecialchars($praticien['description']) ?></p>
                            <p class="mb-0"><strong><?= number_format($praticien['tarif'], 2) ?> €</strong> / séance</p>
                        </div>
                        <div class="card-footer bg-white">
                            <button class="btn btn-outline-primary btn-sm w-100 view-calendar" data-id="<?= $id ?>">
                                Voir les créneaux
                            </button>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="col-12"><div class="alert alert-info">Aucun praticien trouvé.</div></div>
        <?php endif; ?>
    </div>

    <div class="card mt-5 d-none" id="calendarView">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span id="therapistName" class="fw-bold"></span>
            <button class="btn btn-link" id="backToList"><i class="fas fa-arrow-left"></i> Retour</button>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered align-middle" id="therapistCalendar">
                    <thead>
                        <tr class="calendar-header">
                            <?php 
                                $jours = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
                                foreach ($jours as $jour): 
                            ?>
                                <th class="text-center"><?= $jour ?></th>
                            <?php endforeach; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                            // Organisation des dates par semaine
                            $weeks = [];
                            $currentWeek = [];
                            $today = date('Y-m-d');
                            foreach ($dates as $date) {
                                $d = new DateTime($date);
                                $dow = $d->format('N') - 1; // 0=Lun ... 6=Dim
                                if ($dow == 0 && !empty($currentWeek)) {
                                    $weeks[] = $currentWeek;
                                    $currentWeek = [];
                                }
                                $currentWeek[$dow] = $date;
                                if ($date === end($dates)) {
                                    for ($i = $dow + 1; $i < 7; $i++) $currentWeek[$i] = null;
                                    $weeks[] = $currentWeek;
                                }
                            }
                            foreach ($weeks as $week): ?>
                            <tr>
                                <?php for ($i = 0; $i < 7; $i++): ?>
                                    <?php $date = $week[$i] ?? null; ?>
                                    <td class="calendar-day<?= ($date === $today) ? ' bg-light border-primary' : '' ?>" data-date="<?= $date ?>">
                                        <?php if ($date): ?>
                                            <div class="fw-bold"><?= date('d/m', strtotime($date)) ?></div>
                                            <div class="calendar-slots p-1"></div>
                                        <?php endif; ?>
                                    </td>
                                <?php endfor; ?>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Optionnel : Modal de prise de RDV à brancher si tu veux un jour ! -->

<link rel="stylesheet" href="public/css/praticiens_creneaux.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- FontAwesome, Bootstrap si besoin (sinon retire) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<script>
$(function() {
    const therapistsData = <?= json_encode($praticiens) ?>;
    let currentId = null;

    $('.view-calendar').click(function() {
        currentId = $(this).data('id');
        const t = therapistsData[currentId];
        $('#therapistName').text(`${t.prenom} ${t.nom} — ${t.mode_consultation}`);
        $('#therapistCards').hide();
        $('#calendarView').removeClass('d-none');
        // Remplit le calendrier
        $('.calendar-slots').empty();
        $('.calendar-day').each(function() {
            const $slot = $(this).find('.calendar-slots');
            const date = $(this).data('date');
            if (date && t.creneaux[date]) {
                t.creneaux[date].forEach(slot => {
                    $slot.append(`<div class="badge bg-success mb-1">${slot.debut} - ${slot.fin}</div>`);
                });
            }
        });
    });

    $('#backToList').click(function() {
        $('#calendarView').addClass('d-none');
        $('#therapistCards').show();
        currentId = null;
    });
});
</script>
<?php require "view_end.php"; ?>
