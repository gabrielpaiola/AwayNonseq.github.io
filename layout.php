<?php
$URL = 'https://primomarcos.com';
function buildLayout($html)
{
  echo "
  
  
  
  <html lang='en'>
    <head>
        <meta charset='utf-8' />
        <meta http-equiv='X-UA-Compatible' content='IE=edge' />
        <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no' />
        <meta name='description' content='' />
        <meta name='author' content='' />
        <link rel='icon' type='image/x-icon' href='$URL/Imagens/PrimoMarcos/ICONE.png' />
        <link href='https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css' rel='stylesheet' />
        <link href='$URL/css/styles.css' rel='stylesheet' />
        <script src='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js' crossorigin='anonymous'></script>
    </head>
    <body class='sb-nav-fixed'>
        <nav class='sb-topnav navbar navbar-expand navbar-dark bg-dark'>
            <!-- Navbar Brand-->
            <a class='navbar-brand ps-3' href='$URL/index.php'>Primo Marcos</a>
            <!-- Sidebar Toggle-->
            <button class='btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0' id='sidebarToggle' href='#!'><i class='fas fa-bars'></i></button>
            <!-- Navbar Search-->
            <form class='d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0'>
                <div class='input-group'>
                    <a class='nav-link' href='$URL/user/user_login.php'> <div class='sb-nav-link-icon'></div> User Login </a>
                </div>
            </form>
        </nav> 
        <div id='layoutSidenav'>
            <div id='layoutSidenav_nav'>
                <nav class='sb-sidenav accordion sb-sidenav-dark' id='sidenavAccordion'>
                    <div class='sb-sidenav-menu'>
                        <div class='nav'>
                            <div class='sb-sidenav-menu-heading'>Panels</div>
                            <a class='nav-link' href='$URL/Sobre/Pacotes.php'> <div class='sb-nav-link-icon'></div> Pacotes </a>
                            <a class='nav-link' href='$URL/register/register.php'> <div class='sb-nav-link-icon'></div> User Register </a>
                            <a class='nav-link' href='$URL/user/user_login.php'> <div class='sb-nav-link-icon'></div> User Login </a>
                            <a class='nav-link' href='$URL/user/users_page.php'> <div class='sb-nav-link-icon'></div> User Panel </a>   

                            
                            <div class='sb-sidenav-menu-heading'>Informações</div>

                            <a class='nav-link collapsed' href='#' data-bs-toggle='collapse' data-bs-target='#collapsePrivacy' aria-expanded='false' aria-controls='collapswePrivacy'>
                                <div class='sb-nav-link-icon'><i></i></div> Privacy <div class='sb-sidenav-collapse-arrow'><i class='fas fa-angle-down'></i></div></a>
                                <div class='collapse' id='collapsePrivacy' aria-labelledby='headingOne' data-bs-parent='#sidenavAccordion'>
                                    <nav class='sb-sidenav-menu-nested nav'>
                                    <a class='nav-link' href='$URL/Sobre/Whatis.php'>Sobre</a>
                                    <a class='nav-link' href='$URL/Sobre/Terms.php'>Termos</a>
                                    <a class='nav-link' href='$URL/Sobre/Team.php'>Team</a>
                                    </nav>
                                </div>

                            <a class='nav-link collapsed' href='#' data-bs-toggle='collapse' data-bs-target='#collapseProblems' aria-expanded='false' aria-controls='collapseProblems'>
                                <div class='sb-nav-link-icon'><i></i></div> Problemas / Soluções<div class='sb-sidenav-collapse-arrow'><i class='fas fa-angle-down'></i></div></a>
                                <div class='collapse' id='collapseProblems' aria-labelledby='headingOne' data-bs-parent='#sidenavAccordion'>
                                    <nav class='sb-sidenav-menu-nested nav'>
                                    <a class='nav-link' href='$URL/Sobre/WindowsDefender.php'>WindowsDefender</a>
                                    <a class='nav-link' href='$URL/Sobre/Warsaw.php'>EXE Não abrindo</a>
                                    <a class='nav-link' href='$URL/Sobre/ZoomWindows.php'>ZoomWindows</a>
                                    <a class='nav-link' href='$URL/Sobre/ErroDLL.php'>ErroDLL</a>
                                    <a class='nav-link' href='$URL/Sobre/UsandoOBS.php'>UsandoOBS</a>
                                    </nav>
                                </div>
                            
                            <a class='nav-link collapsed' href='#' data-bs-toggle='collapse' data-bs-target='#collapseFuncs' aria-expanded='false' aria-controls='collapseFuncs'>
                                <div class='sb-nav-link-icon'><i></i></div> Funções <div class='sb-sidenav-collapse-arrow'><i class='fas fa-angle-down'></i></div></a>
                                <div class='collapse' id='collapseFuncs' aria-labelledby='headingOne' data-bs-parent='#sidenavAccordion'>
                                    <nav class='sb-sidenav-menu-nested nav'>
                                    <a class='nav-link' href='$URL/Sobre/Functions.php'>Descritivo</a>
                                    <a class='nav-link' href='$URL/Sobre/Videos.php'>Videos</a>
                                    </nav>
                                </div>
                            

                            
                           
                    </div>
                </nav>
            </div>
          </div>
          <!-- End Navbar -->















        <div class='content'>
          <div class='container-fluid'>
            '.$html.'
          </div>
        </div>

        <!-- Contact--> 
        <footer>
        <br><br><br><br><br>
        <section class='page-section' id='contact'>
            <div  style=' 
                          background-color:#000000;
                          background-image:url(https://primomarcos.com/assets/img/map-image.png);
                          background-size: cover;
                          padding-top:80px;
                          padding-bottom:100px; 
                          background-size 100% 100%;
                        '>
                          <br>
                          <br>
                <div class='text-center'>
                    <h2 class='section-heading text-uppercase text-white'>Entre em contato via e-mail</h2>
                    <br>
                </div>
                <div class='container'>
                    <form id='contactForm' data-sb-form-api-token='API_TOKEN' method='POST' action='https://primomarcos.com/mailer/email_contato.php'>
                        <div class='row align-items-stretch mb-5'>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <!-- Name input-->
                                    <input class='form-control' name='name' type='text' placeholder='Your Name *' data-sb-validations='required' />
                                    <div class='invalid-feedback' data-sb-feedback='name:required'>A name is required.</div>
                                </div>
                                <div class='form-group'>
                                  <!-- Email address input-->
                                    <input class='form-control' name='email' type='email' placeholder='Your Email *' data-sb-validations='required,email' />
                                    <div class='invalid-feedback' data-sb-feedback='email:required'>An email is required.</div>
                                    <div class='invalid-feedback' data-sb-feedback='email:email'>Email is not valid.</div>
                                </div>
                            </div>
                            <div class='col-md-6'>
                                <div class='form-group form-group-textarea mb-md-0'>
                                    <!-- Message input-->
                                    <textarea class='form-control' name='message' placeholder='Your Message *' data-sb-validations='required'></textarea>
                                    <div class='invalid-feedback' data-sb-feedback='message:required'>A message is required.</div>
                                </div>
                            </div>
                        </div>
                        <div class='text-center'><button class='btn btn-primary btn-xl text-uppercase' id='submitButton' type='submit'>Send Message</button></div>
                        

                
                
                <br><br><br>
                <div align=center><a><img src='https://contador.s12.com.br/img-cY6YW8b537BB4DBB-79.gif' border='0' alt='visitas'></a><script type='text/javascript' src='https://contador.s12.com.br/ad.js?id=cY6YW8b537BB4DBB'></script></div>
            <div class='container'><p class='m-0 text-center text-white'><br>Aviso Legal:</p></div>
            <div class='container'><p class='m-0 text-center text-white'>Este site não tem relação/associação a CipSoft GmbH ou qualquer outra empresa e o Primo Marcos pode ser contra os seus TOS/EULA. A responsabilidade de uso é totalmente pessoal.</p></div>

                    <div class='container-fluid px-4'>
                        <div class='d-flex align-items-center justify-content-between small'>
                            <div class='text-muted'>Copyright &copy; Primo Marcos 2021</div>
                            <div>
                                <a href='$URL/Sobre/Whatis.php'>About</a>
                                &middot;
                                <a href='$URL/Sobre/Terms.php'>Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                    
              
            </div>
        </div>


        <script id='float_dc' src='https://primomarcos.com/js/discord.js' data-href='https://discord.gg/SGgwjUarPu' async></script>   

        <!-- Messenger Plugin de bate-papo Code -->
        <div id='fb-root'></div>

        <!-- Your Plugin de bate-papo code -->
        <div id='fb-customer-chat' class='fb-customerchat'>
        </div>

        <script>
        var chatbox = document.getElementById('fb-customer-chat');
        chatbox.setAttribute('page_id', '104578331892013');
        chatbox.setAttribute('attribution', 'biz_inbox');

        window.fbAsyncInit = function() {
            FB.init({
            xfbml            : true,
            version          : 'v11.0'
            });
        };

        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = 'https://connect.facebook.net/pt_BR/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
        </script>
        <!-- Messenger Plugin de bate-papo Code -->


        </div>
        </section>

            



                </main>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js' crossorigin='anonymous'></script>
        <script src='js/scripts.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js' crossorigin='anonymous'></script>
        <script src='assets/demo/chart-area-demo.js'></script>
        <script src='assets/demo/chart-bar-demo.js'></script>
        <script src='https://cdn.jsdelivr.net/npm/simple-datatables@latest' crossorigin='anonymous'></script>
        <script src='js/datatables-simple-demo.js'></script>
        </body>
        </footer>

  </html>";
} 
?>