<?php
// backend/Controllers/Controller_agenda.php
require_once 'Models/Model.php';

class Controller_agenda extends Controller
{
    private function mustBePraticien() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'praticien') {
            header('Location: index.php?Controller=connexion&action=index'); exit;
        }
    }

    public function action_index() {
        $this->mustBePraticien();
        $me = [
            'name'   => $_SESSION['user_name']   ?? '—',
            'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
            'role'   => $_SESSION['user_title']  ?? 'Praticien',
        ];
        // l’onglet actif sert à allumer l’icône dans la sidebar
        $this->render('agenda', ['me' => $me, 'active' => 'agenda']);
    }

    public function action_settings() {
        $this->mustBePraticien();
        $me = [
            'name'   => $_SESSION['user_name']   ?? '—',
            'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
            'role'   => $_SESSION['user_title']  ?? 'Praticien',
        ];
        $this->render('agenda_settings', ['me' => $me, 'active' => 'settings']);
    }

    /* =======================
     * ======  API JSON  ======
     * ======================= */

    // GET ?Controller=agenda&action=api_slots&from=YYYY-MM-DD&to=YYYY-MM-DD
    public function action_api_slots() {
        $this->mustBePraticien();
        header('Content-Type: application/json; charset=utf-8');

        $from = $_GET['from'] ?? '';
        $to   = $_GET['to']   ?? '';
        if (!$from || !$to) { http_response_code(400); echo json_encode(['error'=>'missing from/to']); return; }

        $m = Model::getModel();
        $pid = $_SESSION['praticien_id'] ?? $_SESSION['user_id'] ?? null;
        $slots = $m->agenda_listSlotsInRange((int)$pid, $from, $to);

        // calc: est-ce que tous les jours entre from et to ont au moins un slot "free" ?
        $allFree = $m->agenda_allDaysHaveFree((int)$pid, $from, $to);

        echo json_encode(['slots'=>$slots, 'all_free'=>$allFree]);
    }

    // POST JSON {date,start,end,status,title,place}
    // -> ?Controller=agenda&action=api_save_slot
    public function action_api_save_slot() {
        $this->mustBePraticien();
        header('Content-Type: application/json; charset=utf-8');

        $body = json_decode(file_get_contents('php://input'), true) ?: [];
        $date   = trim($body['date']   ?? '');
        $start  = trim($body['start']  ?? '');
        $end    = trim($body['end']    ?? '');
        $status = trim($body['status'] ?? 'free');
        $title  = trim($body['title']  ?? '');
        $place  = trim($body['place']  ?? 'cabinet');

        if (!$date || !$start || !$end) { http_response_code(400); echo json_encode(['error'=>'missing required fields']); return; }

        $pid = $_SESSION['praticien_id'] ?? $_SESSION['user_id'] ?? null;
        $m = Model::getModel();

        // anti-doublon exact (même date + start + end + status)
        if ($m->agenda_slotExists((int)$pid, $date, $start, $end, $status)) {
            echo json_encode(['ok'=>true, 'duplicate'=>true]); return;
        }

        $id = $m->agenda_saveSlot((int)$pid, $date, $start, $end, $status, $title, $place);
        echo json_encode(['ok'=>true, 'id'=>$id]);
    }

    // POST JSON {month:'YYYY-MM', start:'HH:MM', end:'HH:MM'} -> crée des "free" 1/jour
    // -> ?Controller=agenda&action=api_mark_all_free
    public function action_api_mark_all_free() {
        $this->mustBePraticien();
        header('Content-Type: application/json; charset=utf-8');

        $body  = json_decode(file_get_contents('php://input'), true) ?: [];
        $month = trim($body['month'] ?? '');     // ex: 2025-09
        $start = trim($body['start'] ?? '09:00');
        $end   = trim($body['end']   ?? '09:45');

        if (!preg_match('~^\d{4}-\d{2}$~', $month)) { http_response_code(400); echo json_encode(['error'=>'bad month']); return; }

        $pid = $_SESSION['praticien_id'] ?? $_SESSION['user_id'] ?? null;
        $m = Model::getModel();

        // évite la redondance: n’ajoute que pour les jours où il n’existe PAS déjà de "free"
        $added = $m->agenda_markMonthAllFree((int)$pid, $month, $start, $end);

        // renvoyer l’état "all_free" pour désactiver le bouton
        $from = $month . '-01';
        $to   = date('Y-m-t', strtotime($from));
        $allFree = $m->agenda_allDaysHaveFree((int)$pid, $from, $to);

        echo json_encode(['ok'=>true, 'added'=>$added, 'all_free'=>$allFree]);
    }
    public function action_sessions()
{
    $this->mustBePraticien();

    // onglet + identité pour la sidebar si besoin
    $me = [
        'name'   => $_SESSION['user_name']   ?? '—',
        'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
        'role'   => $_SESSION['user_title']  ?? 'Praticien',
    ];

    // portée d’affichage: day|week|month (défaut: day)
    $scope = $_GET['scope'] ?? 'day';
    $today = new DateTimeImmutable('today');
    switch ($scope) {
        case 'week':
            $monday = $today->modify('monday this week');
            $from = $monday->format('Y-m-d');
            $to   = $monday->modify('+6 days')->format('Y-m-d');
            break;
        case 'month':
            $first = $today->modify('first day of this month');
            $from = $first->format('Y-m-d');
            $to   = $first->modify('last day of this month')->format('Y-m-d');
            break;
        default: // day
            $from = $today->format('Y-m-d');
            $to   = $today->format('Y-m-d');
            break;
    }

    // filtres optionnels
    $status     = $_GET['status']     ?? '';          // 'upcoming' | 'past' | '' (tous)
    $patientId  = isset($_GET['patient']) ? (int)$_GET['patient'] : null;
    $specialite = $_GET['specialite'] ?? '';

    $pid = (int)($_SESSION['praticien_id'] ?? $_SESSION['user_id'] ?? 0);
    $m   = Model::getModel();

    // liste + facettes pour les menus
    $sessions   = $m->agenda_listSessions($pid, $from, $to, $status, $patientId, $specialite);
    $patients   = $m->agenda_sessionsDistinctPatients($pid, $from, $to);
    $specialites= $m->agenda_sessionsDistinctSpecialites($pid, $from, $to);

    $this->render('agenda_sessions', [
        'me'          => $me,
        'active'      => 'agenda',
        'scope'       => $scope,
        'from'        => $from,
        'to'          => $to,
        'sessions'    => $sessions,
        'patients'    => $patients,
        'specialites' => $specialites,
        'status'      => $status,
        'patientId'   => $patientId,
        'specialite'  => $specialite,
    ]);
}


    public function action_default(){ $this->action_index(); }
}
