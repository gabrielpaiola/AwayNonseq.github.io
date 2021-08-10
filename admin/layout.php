<?php
function buildLayout($html)
{
  echo "<html lang='en'>
  <head>
    <title>Painel Admin</title>
    <!-- Required meta tags -->
    <meta charset='utf-8'>
    <meta content='width=device-width, initial-scale=1.0' name='viewport' />
    <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
    <!--     Fonts and icons     -->
    <link rel='stylesheet' type='text/css' href='https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons' />
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css'>
    <!-- Material Kit CSS -->
    <link href='assets/css/material-dashboard.css?v=2.1.2' rel='stylesheet' />
    <script type='text/javascript' src='assets/jquery-3.6.0.min.js'></script>
    <link rel='stylesheet' type='text/css' href='https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css'>
    <script type='text/javascript' charset='utf8' src='https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js'></script>
  </head>
  <body>
    <div class='wrapper '>
      <div class='sidebar' data-color='purple' data-background-color='white'>
        <!--
        Tip 1: You can change the color of the sidebar using: data-color='purple | azure | green | orange | danger'
  
        Tip 2: you can also add an image using data-image tag
    -->
        <div class='logo'>
          <a href='#' class='simple-text logo-mini'>
            Primo Marcos
          </a>
          <a href='#' class='simple-text logo-normal'>
            Painel Admin
          </a>
        </div>
        <div class='sidebar-wrapper'>
          <ul class='nav'>
          <li class='nav-item'>
          <a class='nav-link' href='update_status.php'>
            <i class='material-icons'>archive</i>
            <p>Update Users Status</p>
          </a>
          </li>
            <li class='nav-item'>
            <a class='nav-link' href='../date.php' target='_blank'>
              <i class='material-icons'>date_range</i>
              <p>Data</p>
            </a>
            </li>
          <li class='nav-item'>
          <a class='nav-link' href='../msglauncherauto.php' target='_blank'>
            <i class='material-icons'>dvr</i>
            <p>Message DB</p>
          </a>
          </li>
        <li class='nav-item'>
        <a class='nav-link' href='../infos.php' target='_blank'>
          <i class='material-icons'>format_list_numbered</i>
          <p>Version DB</p>
        </a>
        </li>
        <li class='nav-item'>
        <a class='nav-link' href='logout.php'>
          <i class='material-icons'>exit_to_app</i>
          <p>Logout</p>
        </a>
        </li>
            <!-- your sidebar here -->
          </ul>
        </div>
      </div>
      <div class='main-panel'>
        <!-- Navbar -->
        <nav class='navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top '>
          <div class='container-fluid'>
            <div class='navbar-wrapper'>
            <a class='navbar-brand' href='users_table.php'>Users Table</a>
              <a class='navbar-brand' href='infos_table.php'>Infos Table</a>
              <a class='navbar-brand' href='msg_launcher_table.php'>Msg Launcher</a>
              <a class='navbar-brand' href='cupons_table.php'>Cupons</a>
            </div>
            <button class='navbar-toggler' type='button' data-toggle='collapse' aria-controls='navigation-index' aria-expanded='false' aria-label='Toggle navigation'>
              <span class='sr-only'>Toggle navigation</span>
              <span class='navbar-toggler-icon icon-bar'></span>
              <span class='navbar-toggler-icon icon-bar'></span>
              <span class='navbar-toggler-icon icon-bar'></span>
            </button>
            <div class='collapse navbar-collapse justify-content-end'>
            </div>
          </div>
        </nav>
        <!-- End Navbar -->
        <div class='content'>
          <div class='container-fluid'>
            ".$html."
          </div>
        </div>
        <footer class='footer'>
          <div class='container-fluid'>
            <nav class='float-left'>
              <ul>
                <li>
                  <a href='#'>
                  </a>
                </li>
              </ul>
            </nav>
            <div class='copyright float-right'>
              Copyright &copy; Primo Marcos 2021;
            </div>
            <!-- your footer here -->
          </div>
        </footer>
      </div>
    </div>
  </body>
  <script>
            $(document).ready( function () {
                $('#users').DataTable();
            });
  </script>
  </html>";
} 
?>