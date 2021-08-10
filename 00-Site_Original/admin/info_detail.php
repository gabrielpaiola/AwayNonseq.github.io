<?php
require_once('../dist/db.php');
require_once('./layout.php');
include('../dist/server.php');
$id = $_GET['id'];

if($_SESSION['logged'] != 1) {
  header('location: admin_login.php');
}
if($_SESSION['adm_logged'] != 1) {
  header('location: users_table.php');
}

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM infos WHERE id = ? LIMIT 1');
 $result = $stmt->execute([$id]);
 $row = $stmt->fetchObject();

 if($row == null) {
     return;
 }

$html = "<div class='content'>
        <div class='container-fluid'>
          <div class='row'>
            <div class='col-md-12'>
              <div class='card'>
                <div class='card-header card-header-primary'>
                  <h4 class='card-title'>Update User</h4>
                </div>

                <div class='card-body' action='info_detail.php?id=$id'>
                  <form method='post'>
                    <input type='hidden' name='id' value='$id'>
                    <div class='row'>

                      <div class='col-md-3'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Versao Oficial</label>
                          <input type='text' name='versao_oficial' value='$row->versao_oficial' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-5'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Versao Beta</label>
                          <input type='text' name ='versao_beta' value='$row->versao_beta' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-4'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Versao Launcher</label>
                          <input type='text' name ='versao_launcher' value='$row->versao_launcher' class='form-control'>
                        </div>
                      </div>
                    </div>
                    <div class='row'>
                      <div class='col-md-6'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Link para Download</label>
                          <input type='text' name ='link_download' value='$row->link_download' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-6'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Segurança</label>
                          <input type='text' name ='security' value='$row->security' class='form-control'>
                        </div>
                      </div>
                      
                    </div>
                    <button type='submit' name='update_infos' class='btn btn-primary pull-right'>Save</button>
                    <div class='clearfix'></div>
                  </form>
                </div>
              </div>
            </div></div></div></div>";
 buildLayout($html);
 $db = null;
?>