

<?php
// Connexion à la base de données
$dsn = "mysql:host=localhost;dbname=holinea;charset=utf8";
$login = "root";
$mdp = "";

try {
    $pdo = new PDO($dsn, $login, $mdp);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Requête pour récupérer les praticiens et leurs créneaux
    $sql = "
        SELECT 
            p.Id_PRATICIEN,
            p.nom, 
            p.prenom, 
            p.photo_profil_url,
            p.specialite1,
            p.specialite2,
            p.specialite3,
            p.description,
            p.tarifs_consultaion,
            p.mode_consultation,
            c.Jour, 
            TIME_FORMAT(c.Heure_debut, '%H:%i') as Heure_debut,
            TIME_FORMAT(c.Heure_fin, '%H:%i') as Heure_fin
        FROM Praticien p
        LEFT JOIN Agenda a ON p.Id_PRATICIEN = a.Id_PRATICIEN
        LEFT JOIN Créneaux c ON a.Id_agenda = c.Id_agenda
        WHERE c.Jour BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
        ORDER BY p.nom, c.Jour, c.Heure_debut
    ";

    $stmt = $pdo->query($sql);
    $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    die("Erreur base de données : " . $e->getMessage());
}

// Organiser les données pour l'affichage
$praticiens = array();
foreach ($resultats as $ligne) {
    $id = $ligne['Id_PRATICIEN'];
    if (!isset($praticiens[$id])) {
        $praticiens[$id] = array(
            'id' => $id,
            'nom' => $ligne['nom'],
            'prenom' => $ligne['prenom'],
            'photo' => !empty($ligne['photo_profil_url']) ? $ligne['photo_profil_url'] : 'default-therapist.jpg',
            'specialites' => array_filter(array($ligne['specialite1'], $ligne['specialite2'], $ligne['specialite3'])),
            'description' => $ligne['description'],
            'tarif' => $ligne['tarifs_consultaion'],
            'mode_consultation' => $ligne['mode_consultation'],
            'creneaux' => array()
        );
    }
    
    if (!empty($ligne['Jour'])) {
        $praticiens[$id]['creneaux'][$ligne['Jour']][] = array(
            'debut' => $ligne['Heure_debut'],
            'fin' => $ligne['Heure_fin']
        );
    }
}

// Générer les dates pour les 30 prochains jours
$dates = array();
for ($i = 0; $i < 30; $i++) {
    $date = new DateTime();
    $date->add(new DateInterval("P{$i}D"));
    $dates[] = $date->format('Y-m-d');
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Annuaire des Thérapeutes HoliNea</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #f8f9fc;
            --accent-color: #1cc88a;
        }
        
        body {
            background-color: #f8f9fc;
            font-family: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }
        
        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
        }
        
        .therapist-card {
            transition: all 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            height: 100%;
        }
        
        .therapist-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .therapist-img {
            height: 120px;
            width: 120px;
            object-fit: cover;
            border: 3px solid white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .calendar-header {
            background-color: var(--primary-color);
            color: white;
            border-radius: 10px 10px 0 0;
        }
        
        .calendar-day {
            border: 1px solid #e3e6f0;
            min-height: 100px;
            position: relative;
        }
        
        .calendar-day-header {
            background-color: var(--secondary-color);
            padding: 5px;
            font-weight: bold;
            text-align: center;
        }
        
        .date-number {
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        .time-slot {
            background-color: var(--accent-color);
            color: white;
            border-radius: 4px;
            padding: 2px 5px;
            font-size: 0.8rem;
            margin: 2px 0;
            display: inline-block;
            cursor: pointer;
        }
        
        .today {
            background-color: rgba(78, 115, 223, 0.1);
            border: 2px solid var(--primary-color);
        }
        
        .badge-specialite {
            background-color: var(--primary-color);
            margin-right: 5px;
            margin-bottom: 5px;
        }
        
        .consultation-mode {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .tarif-badge {
            background-color: #1cc88a;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    

    <!-- Main Content -->
    <div class="container mb-5">
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-white">
                        <h4 class="m-0 font-weight-bold text-primary">
                            <i class="far fa-calendar-alt me-2"></i>Calendrier des disponibilités
                        </h4>
                        <div>
                            <span class="me-2"><strong>Période :</strong> <?= date('d/m/Y') ?> - <?= date('d/m/Y', strtotime('+30 days')) ?></span>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Filtres -->
                        <div class="row mb-4">
                            <div class="col-md-4 mb-2">
                                <select class="form-select" id="filterSpecialite">
                                    <option value="">Toutes les spécialités</option>
                                    <?php
                                    $specialites = array();
                                    foreach ($praticiens as $praticien) {
                                        foreach ($praticien['specialites'] as $spec) {
                                            if (!empty($spec) && !in_array($spec, $specialites)) {
                                                $specialites[] = $spec;
                                                echo '<option value="'.htmlspecialchars($spec).'">'.htmlspecialchars($spec).'</option>';
                                            }
                                        }
                                    }
                                    ?>
                                </select>
                            </div>
                            <div class="col-md-4 mb-2">
                                <select class="form-select" id="filterMode">
                                    <option value="">Tous les modes</option>
                                    <option value="Présentiel">Présentiel</option>
                                    <option value="Visio">Visio</option>
                                    <option value="Mixte">Mixte</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-2">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchInput" placeholder="Rechercher un praticien...">
                                    <button class="btn btn-outline-primary" type="button" id="searchButton">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Therapist Cards -->
                        <div class="row" id="therapistCards">
                            <?php if (!empty($praticiens)): ?>
                                <?php foreach ($praticiens as $id => $praticien): ?>
                                    <div class="col-md-6 col-lg-4 mb-4 therapist-item" 
                                         data-specialites="<?= htmlspecialchars(implode(',', $praticien['specialites'])) ?>"
                                         data-mode="<?= htmlspecialchars($praticien['mode_consultation']) ?>"
                                         data-name="<?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?>">
                                        <div class="card therapist-card h-100">
                                            <div class="card-body text-center">
                                                <img src="<?= htmlspecialchars($praticien['photo']) ?>" 
                                                     alt="<?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?>" 
                                                     class="therapist-img rounded-circle mb-3">
                                                <h5 class="card-title"><?= htmlspecialchars($praticien['prenom'].' '.$praticien['nom']) ?></h5>
                                                
                                                <div class="mb-2">
                                                    <?php foreach ($praticien['specialites'] as $spec): ?>
                                                        <?php if (!empty($spec)): ?>
                                                            <span class="badge badge-specialite rounded-pill"><?= htmlspecialchars($spec) ?></span>
                                                        <?php endif; ?>
                                                    <?php endforeach; ?>
                                                </div>
                                                
                                                <p class="consultation-mode mb-2">
                                                    <i class="fas fa-<?= $praticien['mode_consultation'] == 'Visio' ? 'video' : ($praticien['mode_consultation'] == 'Présentiel' ? 'building' : 'random') ?> me-1"></i>
                                                    <?= htmlspecialchars($praticien['mode_consultation']) ?>
                                                </p>
                                                
                                                <span class="badge tarif-badge rounded-pill mb-3">
                                                    <?= number_format($praticien['tarif'], 2) ?> € / séance
                                                </span>
                                                
                                                <p class="text-muted mb-3 small">
                                                    <?= htmlspecialchars($praticien['description']) ?>
                                                </p>
                                                
                                                <div class="d-flex justify-content-between">
                                                    <button class="btn btn-sm btn-outline-primary view-calendar" data-id="<?= $id ?>">
                                                        <i class="far fa-calendar-alt me-1"></i> Disponibilités
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-success view-profile" data-id="<?= $id ?>">
                                                        <i class="far fa-user me-1"></i> Profil
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <div class="col-12">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i> Aucun thérapeute avec des disponibilités pour les 30 prochains jours.
                                    </div>
                                </div>
                            <?php endif; ?>
                        </div>
                        
                        <!-- Calendar View -->
                        <div class="card shadow mb-4 d-none" id="calendarView">
                            <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-white">
                                <h5 class="m-0 font-weight-bold text-primary" id="therapistName">
                                    <i class="fas fa-user-md me-2"></i>
                                </h5>
                                <div>
                                    <button class="btn btn-sm btn-outline-secondary" id="backToList">
                                        <i class="fas fa-arrow-left me-1"></i> Retour à la liste
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <!-- Calendar Navigation -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="d-flex align-items-center">
                                            <span class="me-3"><strong>Période :</strong></span>
                                            <span class="text-primary"><?= date('d/m/Y') ?> - <?= date('d/m/Y', strtotime('+30 days')) ?></span>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Calendar Grid -->
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="therapistCalendar">
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
                                                // Organiser les dates par semaine
                                                $weeks = array();
                                                $currentWeek = array();
                                                $today = date('Y-m-d');
                                                
                                                foreach ($dates as $date) {
                                                    $dateObj = new DateTime($date);
                                                    $dayOfWeek = $dateObj->format('N') - 1; // 0 pour Lundi, 6 pour Dimanche
                                                    
                                                    // Si c'est Lundi et que la semaine en cours n'est pas vide, on l'ajoute
                                                    if ($dayOfWeek == 0 && !empty($currentWeek)) {
                                                        $weeks[] = $currentWeek;
                                                        $currentWeek = array();
                                                    }
                                                    
                                                    $currentWeek[$dayOfWeek] = $date;
                                                    
                                                    // Si c'est la dernière date, on ajoute la semaine en cours
                                                    if ($date === end($dates)) {
                                                        // Remplir les jours manquants jusqu'à Dimanche
                                                        for ($i = $dayOfWeek + 1; $i < 7; $i++) {
                                                            $currentWeek[$i] = null;
                                                        }
                                                        $weeks[] = $currentWeek;
                                                    }
                                                }
                                                
                                                // Afficher les semaines
                                                foreach ($weeks as $week): 
                                            ?>
                                                <tr>
                                                    <?php for ($i = 0; $i < 7; $i++): ?>
                                                        <?php 
                                                            $date = isset($week[$i]) ? $week[$i] : null;
                                                            $isToday = $date === $today;
                                                        ?>
                                                        <td class="calendar-day <?= $isToday ? 'today' : '' ?>" data-date="<?= $date ?>">
                                                            <?php if ($date): ?>
                                                                <div class="calendar-day-header">
                                                                    <div class="date-number"><?= date('j', strtotime($date)) ?></div>
                                                                    <div><?= date('M', strtotime($date)) ?></div>
                                                                </div>
                                                                <div class="calendar-slots p-1">
                                                                    <!-- Les créneaux seront ajoutés dynamiquement -->
                                                                </div>
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
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Appointment -->
    <div class="modal fade" id="appointmentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Prendre rendez-vous</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="appointmentForm">
                        <div class="mb-3">
                            <label class="form-label">Thérapeute</label>
                            <input type="text" class="form-control" id="modalTherapist" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Date</label>
                            <input type="text" class="form-control" id="modalDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Créneau horaire</label>
                            <input type="text" class="form-control" id="modalTime" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="patientName" class="form-label">Votre nom</label>
                            <input type="text" class="form-control" id="patientName" required>
                        </div>
                        <div class="mb-3">
                            <label for="patientPhone" class="form-label">Téléphone</label>
                            <input type="tel" class="form-control" id="patientPhone" required>
                        </div>
                        <div class="mb-3">
                            <label for="patientEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="patientEmail" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="button" class="btn btn-primary" id="confirmAppointment">Confirmer</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Convert PHP data to JS
            const therapistsData = <?php echo json_encode($praticiens); ?>;
            let currentTherapistId = null;
            
            // Filter therapists
            function filterTherapists() {
                const specialite = $('#filterSpecialite').val().toLowerCase();
                const mode = $('#filterMode').val();
                const search = $('#searchInput').val().toLowerCase();
                
                $('.therapist-item').each(function() {
                    const $item = $(this);
                    const specialites = $item.data('specialites').toLowerCase();
                    const itemMode = $item.data('mode');
                    const name = $item.data('name').toLowerCase();
                    
                    const specialiteMatch = !specialite || specialites.includes(specialite);
                    const modeMatch = !mode || itemMode === mode;
                    const searchMatch = !search || name.includes(search);
                    
                    if (specialiteMatch && modeMatch && searchMatch) {
                        $item.show();
                    } else {
                        $item.hide();
                    }
                });
            }
            
            // Apply filters
            $('#filterSpecialite, #filterMode, #searchInput').on('change keyup', filterTherapists);
            $('#searchButton').click(filterTherapists);
            
            // Show calendar for therapist
            $('.view-calendar').click(function() {
                const therapistId = $(this).data('id');
                currentTherapistId = therapistId;
                const therapist = therapistsData[therapistId];
                
                // Update therapist name in header
                $('#therapistName').html(
                    `<i class="fas fa-user-md me-2"></i> ${therapist.prenom} ${therapist.nom} - ${therapist.specialites.join(', ')}`
                );
                
                // Hide cards and show calendar
                $('#therapistCards').addClass('d-none');
                $('#calendarView').removeClass('d-none');
                
                // Populate calendar with slots
                $('.calendar-day').each(function() {
                    const date = $(this).data('date');
                    const slotsContainer = $(this).find('.calendar-slots');
                    slotsContainer.empty();
                    
                    if (date && therapist.creneaux[date]) {
                        therapist.creneaux[date].forEach(slot => {
                            const slotElement = $(`
                                <div class="time-slot" data-date="${date}" data-start="${slot.debut}" data-end="${slot.fin}">
                                    ${slot.debut} - ${slot.fin}
                                </div>
                            `);
                            
                            slotElement.click(function() {
                                showAppointmentModal(therapist, date, slot);
                            });
                            
                            slotsContainer.append(slotElement);
                        });
                    }
                });
            });
            
            // Back to list button
            $('#backToList').click(function() {
                $('#calendarView').addClass('d-none');
                $('#therapistCards').removeClass('d-none');
                currentTherapistId = null;
            });
            
            // Show appointment modal
            function showAppointmentModal(therapist, date, slot) {
                $('#modalTherapist').val(`${therapist.prenom} ${therapist.nom}`);
                $('#modalDate').val(new Date(date).toLocaleDateString('fr-FR', { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                }));
                $('#modalTime').val(`${slot.debut} - ${slot.fin}`);
                
                const modal = new bootstrap.Modal(document.getElementById('appointmentModal'));
                modal.show();
            }
            
            // Confirm appointment
            $('#confirmAppointment').click(function() {
                // Here you would typically send the data to the server
                alert('Rendez-vous confirmé! Un email de confirmation vous a été envoyé.');
                $('#appointmentModal').modal('hide');
                $('#appointmentForm')[0].reset();
            });
            
            // Highlight today's date
            const today = new Date().toISOString().split('T')[0];
            $(`.calendar-day[data-date="${today}"]`).addClass('today');
        });
    </script>
</body>
</html>
