<?php
require_once('../dist/db.php');
require_once('./layout.php');
include('../dist/server.php');
$id = $_GET['id'];

if($_SESSION['logged'] != 1) {
  header('location: admin_login.php');
}

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM msglauncher WHERE id = ? LIMIT 1');
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

                <div class='card-body' action='msg_launcher_detail.php?id=$id'>
                  <form method='post'>
                    <input type='hidden' name='id' value='$id'>
                    
                      <div class='row'>
                       <div class='col-md-12'>
                          <div class='form-group'>
                            <label class='bmd-label-floating'>Linha 1</label>
                            <input type='text' name='linha1' value='$row->linha1' class='form-control'>
                          </div>
                        </div>
                      </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 2</label>
                          <input type='text' name='linha2' value='$row->linha2' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 3</label>
                          <input type='text' name='linha3' value='$row->linha3' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 4</label>
                          <input type='text' name='linha4' value='$row->linha4' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 5</label>
                          <input type='text' name='linha5' value='$row->linha5' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 6</label>
                          <input type='text' name='linha6' value='$row->linha6' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 7</label>
                          <input type='text' name='linha7' value='$row->linha7' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 8</label>
                          <input type='text' name='linha8' value='$row->linha8' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 9</label>
                          <input type='text' name='linha9' value='$row->linha9' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 10</label>
                          <input type='text' name='linha10' value='$row->linha10' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 11</label>
                          <input type='text' name='linha11' value='$row->linha11' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 12</label>
                          <input type='text' name='linha12' value='$row->linha12' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 13</label>
                          <input type='text' name='linha13' value='$row->linha13' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 14</label>
                          <input type='text' name='linha14' value='$row->linha14' class='form-control'>
                        </div>
                      </div>
                    </div>

                    <div class='row'> 
                      <div class='col-md-12'>
                        <div class='form-group'>
                          <label class='bmd-label-floating'>Linha 15</label>
                          <input type='text' name='linha15' value='$row->linha15' class='form-control'>
                        </div>
                      </div>
                    </div>


                      
                    </div>
                    <button type='submit' name='update_msg_launcher' class='btn btn-primary pull-right'>Save</button>
                    <div class='clearfix'></div>
                  </form>
                </div>
              </div>
            </div></div></div></div>";
 buildLayout($html);
 $db = null;
?>