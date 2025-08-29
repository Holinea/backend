<?php
class Controller_dossier extends Controller
{
    /** Page dossier à partir d’un CSV.
     *  Filtres acceptés: ?patient=YASMINE (ou mail=..., id=...)
     */
    public function action_show() {
        $csvPath = __DIR__ . '/../Data/fillout_results.csv';
        if (!is_file($csvPath)) {
            $this->render('dossier_error', ['msg' => "CSV introuvable: $csvPath"]);
            return;
        }

        $rows = $this->readCsvAssoc($csvPath);
        if (!$rows) {
            $this->render('dossier_error', ['msg' => "CSV vide ou illisible."]);
            return;
        }

        // Choix du patient (par prénom/nom, email, id…). Default = 1er
        $needleName = trim($_GET['patient'] ?? '');
        $needleMail = trim($_GET['mail'] ?? '');
        $row = $rows[0];

        foreach ($rows as $r) {
            if ($needleMail && $this->match($r, ['email','mail','courriel'], $needleMail)) { $row = $r; break; }
            if ($needleName && $this->match($r, ['nom_complet','nom','prenom','name','full_name'], $needleName, true)) { $row = $r; break; }
        }

        // Mappage souple (alias d’entêtes)
        $data = [
            'identite' => [
                'nom'     => $this->get($row, ['nom_complet','full_name','nomprenom','name','nom','prenom']),
                'genre'   => $this->get($row, ['genre','sexe']),
                'age'     => $this->getInt($row, ['age','âge']),
                'avatar'  => $this->get($row, ['avatar','photo','image_url'])
            ],

            // Tuiles KPI
            'energie_note'  => $this->getFloat($row, ['energie','énergie','energie_note','energy_score','energie_10']),
            'sommeil_pct'   => $this->getFloat($row, ['sommeil_qualite','qualite_sommeil','sleep_quality','sommeil_pct']),
            'humeur'        => $this->get($row, ['humeur','mood_state','etat_humeur','humeur_etat']),
            'douleur_note'  => $this->getFloat($row, ['douleur','douleurs','pain_score','douleur_10']),
            'douleur_zone'  => $this->get($row, ['zone_douleur','douleur_zone','pain_zone']),

            // Séries rapides (loisirs, stress, émotions…)
            'loisir_notes'  => $this->getArrayNums($row, ['loisir1','loisir2','loisir3','loisir4']),
            'stress_series' => $this->getArrayNums($row, ['stress_j1','stress_j2','stress_j3','stress_j4','stress_j5']),
            'emo_series'    => $this->getArrayNums($row, ['emotion_j1','emotion_j2','emotion_j3','emotion_j4','emotion_j5']),
            'sleep_scores'  => $this->getArrayNums($row, ['sleep_q1','sleep_q2','sleep_q3','sleep_q4']),
            'pain_avg'      => $this->getFloat($row, ['douleur_moy','pain_avg']),
            'pain_peak'     => $this->getFloat($row, ['douleur_pic','pain_peak']),

            // Panneau de droite (priorités, indicateurs, tags)
            'priorites'     => $this->getTags($row, ['priorites','priorites_detectees','priorities']),
            'indicateurs'   => $this->getTags($row, ['indicateurs','indicateurs_suivis','trackers']),
            'attentes'      => $this->getTags($row, ['attentes','expectations']),
            'env'           => $this->getTags($row, ['environnement','environnement_mode_de_vie','lifestyle']),
            'symptomes'     => [
                'douleur_moy' => $this->getFloat($row, ['douleur_moy','pain_avg']),
                'douleur_pic' => $this->getFloat($row, ['douleur_pic','pain_peak']),
                'zone'        => $this->get($row, ['zone_douleur','douleur_zone']),
                'sommeil_pct' => $this->getFloat($row, ['sommeil_qualite','sleep_quality','sommeil_pct']),
                'pb_sommeil'  => $this->get($row, ['problemes_sommeil','sleep_issues'])
            ],
            'emotions'      => [
                'liste'       => $this->getTags($row, ['emotions','emotions_list']),
                'intensite'   => $this->getFloat($row, ['intensite_emotions','emo_intensity']),
                'stress'      => $this->getFloat($row, ['stress_niveau','stress']),
                'isolement'   => $this->get($row, ['isolement','isolation']),
                'moments'     => $this->get($row, ['moments_sensibles','sensitive_times'])
            ],
            'objectifs'     => $this->getTags($row, ['objectifs','goals']),
            'intentions'    => $this->getTags($row, ['intentions','intent']),
            'accompagnement'=> $this->get($row, ['accompagnement','support_level']),
            'rappels_freq'  => $this->get($row, ['frequence_rappels','reminder_freq']),
            'partage'       => $this->get($row, ['partage','sharing_level']),
            'notes_suivi'   => $this->get($row, ['notes_suivi','followup_notes']),
        ];

        // Valeurs par défaut élégantes
        if ($data['humeur'] === '') $data['humeur'] = 'Stable';

        $this->render('dossier_patient', [
            'pageTitle' => 'Dossier de '.$data['identite']['nom'] ?: 'Patient',
            'csv_row'   => $row,
            'data'      => $data
        ]);
    }

    /* ---------- helpers CSV tolérants ---------- */

    private function readCsvAssoc(string $path): array {
        $fh = fopen($path, 'r');
        if (!$fh) return [];
        $headers = fgetcsv($fh);
        if (!$headers) return [];
        $norm = array_map(fn($h)=>$this->normKey($h), $headers);
        $rows = [];
        while (($r = fgetcsv($fh)) !== false) {
            $row = [];
            foreach ($norm as $i=>$k) $row[$k] = $r[$i] ?? '';
            $rows[] = $row;
        }
        fclose($fh);
        return $rows;
    }
    private function normKey($s){ return strtolower(trim(preg_replace('~[^a-z0-9]+~i','_', $s))); }
    private function get(array $row, array $aliases, $default=''){
        foreach ($aliases as $a){ $k=$this->normKey($a); if (array_key_exists($k,$row) && $row[$k]!=='') return $row[$k]; }
        return $default;
    }
    private function getFloat(array $row, array $aliases, $default=null){
        $v = $this->get($row,$aliases,'');
        if ($v==='') return $default;
        return floatval(str_replace([',','%'],'.', $v));
    }
    private function getInt(array $row, array $aliases, $default=null){
        $v = $this->get($row,$aliases,'');
        if ($v==='') return $default;
        return intval($v);
    }
    private function getArrayNums(array $row, array $aliases): array {
        $out=[]; foreach($aliases as $a){ $k=$this->normKey($a); if(isset($row[$k]) && $row[$k]!=='') $out[] = floatval(str_replace(',','.',$row[$k])); }
        return $out;
    }
    private function getTags(array $row, array $aliases): array {
        $v = $this->get($row,$aliases,''); if ($v==='') return [];
        // supporte “, ; |”
        $v = preg_split('~[;,|]~', $v);
        return array_values(array_filter(array_map('trim', $v), fn($x)=>$x!==''));
    }
    private function match(array $row, array $aliases, string $needle, bool $contains=false): bool {
        foreach($aliases as $a){
            $k = $this->normKey($a);
            if (!isset($row[$k]) || $row[$k]==='') continue;
            $v = mb_strtolower($row[$k]);
            $n = mb_strtolower($needle);
            if ($contains ? (str_contains($v,$n)) : ($v === $n)) return true;
        }
        return false;
    }

    public function action_default(){ $this->action_show(); }
}
