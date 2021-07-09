<?php
require_once('../dist/db.php');
require_once('./layout.php');
include('../dist/server.php');
$id = $_GET['id'];

if($_SESSION['logged'] != 1) {
  header('location: admin_login.php');
}

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE id = ?');
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
                <div class='card-body' action='user_detail.php?id=$id'>
                  <form method='post'>
                    <input type='hidden' name='id' value='$id'>
                    <div class='row'>
                      <div class='col-md-3'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Username *</label>
                          <input type='text' name='username' value='$row->username' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-5'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Email *</label>
                          <input type='email' name ='email' value='$row->email' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-4'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Team</label>
                          <input type='text' name ='team' value='$row->team' class='form-control'>
                        </div>
                      </div>
                    </div>
                    <div class='row'>
                      <div class='col-md-6'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Indicacao</label>
                          <input type='text' name ='server' value='$row->server' class='form-control'>
                        </div>
                      </div>
                      <div class='col-md-6'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Discord Tag</label>
                          <input type='text' name ='disc' value='$row->discord_tag' class='form-control'>
                        </div>
                      </div>
                    </div>
                    <div class='row'>
                    <div class='col-md-2'>
                    <div class='form-group'>
                      <label class='bmd-label-floating'>Expiry Date *</label>
                      <input type='text' name ='expiry_date' value='$row->expiry_date' class='form-control'>
                      </div>
                    </div>
                      <div class='col-md-2'>
                      <div class='form-group'>
                        <label class='bmd-label-floating'>Status *</label>
                        <input type='text' name ='status' value='$row->status' class='form-control'>
                      </div>
                    </div>
                    <div class='col-md-4'>
                      <div class='form-group'>
                        <label class='bmd-label-floating'>Package</label>
                        <input type='text' name ='package' value='$row->package' list='PacotesList' class='form-control'>
                        <datalist id='PacotesList'>
                            <option value='Trial'/>
                            <option value='Mensal'/>
                            <option value='Trimestral'/>
                            <option value='STAFF'/>
                        </datalist>
                      </div>
                    </div>
                    <div class='col-md-4'>
                      <div class='form-group'>
                        <label class='bmd-label-floating'>Descricao</label>
                        <input type='text' name ='desc' value='$row->description' class='form-control'>
                      </div>
                    </div>
                    </div>
                    <div class='row'>
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Machine ID1</label>
                          <input type='text' name ='machineid1' value='$row->machine_id1' class='form-control'>
                        </div>
                      </div>
                    </div>
                    <div class='row'>
                    <div class='col-md-12'>
                      <div class='form-group'>
                        <label class='bmd-label-floating'>Machine ID2</label>
                        <input type='text' name ='machineid2' value='$row->machine_id2' class='form-control'>
                      </div>
                    </div>
                  </div>
                  <div class='row'>
                  <div class='col-md-12'>
                    <div class='form-group'>
                      <label class='bmd-label-floating'>Machine ID3</label>
                      <input type='text' name ='machineid3' value='$row->machine_id3' class='form-control'>
                    </div>
                  </div>
                </div>
                <div class='row'>
                <div class='col-md-6'>
                  <div class='form-group'>
                    <label class='bmd-label-floating'>Password *</label>
                    <input type='password' name ='password' value='$row->password' class='form-control'>
                  </div>
                </div>
              </div>
                    <button type='submit' name='update_user' class='btn btn-primary pull-right'>Save</button>
                    <div class='clearfix'></div>
                  </form>
                </div>
              </div>
            </div></div></div></div>";
 buildLayout($html);
 $db = null;
?>