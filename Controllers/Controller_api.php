<?php
class Controller_api extends Controller
{
    public function action_villes()
    {
        header('Content-Type: application/json; charset=utf-8');
        header('Cache-Control: no-store');

        $term  = trim($_GET['term'] ?? '');
        $limit = (int)($_GET['limit'] ?? 10);
        if ($limit < 1 || $limit > 50) $limit = 10;

        if ($term === '' || mb_strlen($term) < 2) {
            echo json_encode([]); return;
        }

        $model = Model::getModel();
        try {
            $rows = $model->searchCommunes($term, $limit);
            // Normalisation pour l’autocomplete
            $out = array_map(function($r){
                return [
                  'cp'    => $r['code_postal'],
                  'ville' => $r['nom_commune'],
                  'label' => $r['code_postal'].' '.$r['nom_commune'],
                ];
            }, $rows);
            echo json_encode($out, JSON_UNESCAPED_UNICODE);
        } catch (Throwable $e) {
            http_response_code(500);
            echo json_encode(['error' => 'server_error']);
        }
    }

    public function action_default() { $this->action_villes(); }
}
?>