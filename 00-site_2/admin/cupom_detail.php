<?php
require_once('../dist/db.php');
require_once('./layout.php');
include('../dist/server.php');
$id = $_GET['id'];

if($_SESSION['logged'] != 1) {
  header('location: admin_login.php');
}

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM cupons WHERE id = ? LIMIT 1');
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
                  <h4 class='card-title'>Update Cupom</h4>
                </div>

                <div class='card-body' action='info_detail.php?id=$id'>
                  <form method='post'>
                    <input type='hidden' name='id' value='$id'>
                    <div class='row'>

                      <div class='col-md-3'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Cupom</label>
                          <input type='text' name='cupom' value='$row->cupom' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-5'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Dias</label>
                          <input type='text' name ='dias' value='$row->dias' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-4'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Validade</label>
                          <input type='text' name ='validade' value='$row->validade' class='form-control'>
                        </div>
                      </div>
                    </div>
                      
                    </div>
                    <button type='submit' name='update_cuponm' class='btn btn-primary pull-right'>Save</button>
                    <div class='clearfix'></div>
                  </form>
                </div>
              </div>
            </div></div></div></div>";
 buildLayout($html);
 $db = null;
?>