<?php
class Index {

    public static function Index() {
        if(session_status() === PHP_SESSION_NONE){
            session_start();
        }
        header("Location: ");
    }
}
