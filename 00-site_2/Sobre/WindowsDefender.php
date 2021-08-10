<?php
require_once('../layout.php');



        
$html = "<title>P.M Windows Defender</title>";

$html .= " 



<br><br><br>
        <section class='page-section' id='sobre'>
          <div class='container'>
              <div class='text-center'>
                <h1 class='section-heading text-uppercase'>Windows Defender</h1>
                <h5 class='section-subheading text-muted'>Para utilizar o macro no windows 10, seguir esses passos, caso contrario o windows defender pode deletar alguns scripts (exe) e acabar atrapalhando no funcionamento<br></h5>
              </div>
              <div class='text-center'>
                <h5 class='section-subheading text-muted'><br><br><br><br>-Abra o menu iniciar e pesquise por 'Proteção Contra Virus e Ameaças'</h5>
                <img class='img-fluid d-block mx-auto' src='../Imagens/Defender/1.png' alt='...' />
                <h5 class='section-subheading text-muted'><br><br><br><br>-Acesse <u>'Configurações de proteção contra virus e ameaças'</u> clicando no <u>'Gerenciar configurações'</u></h5>
                <img class='img-fluid d-block mx-auto' src='../Imagens/Defender/2.png' alt='...' />
                <h5 class='section-subheading text-muted'><br><br><br><br>-Caso seja necessário, desabilite o windows Defender conforme foto abaixo para fazer o Download do Launcher.</h5>
                <img class='img-fluid d-block mx-auto' src='../Imagens/Defender/3.png' alt='...' />  
                <h5 class='section-subheading text-muted'><br><br><br><br>-Depois de fazer o download do Launcher, coloque o mesmo numa pasta na área de trabalho (sugestão 'Primo_Launcher').<br>
                  -Com a pasta criada, acesse a área de <u>'Exclusões'</u> no windows defender e acesse clicando em <u>'Adicionar ou remover exclusões'.</u></h5>            
                <img class='img-fluid d-block mx-auto' src='../Imagens/Defender/4.png' alt='...' />
                <h5 class='section-subheading text-muted'><br><br><br><br>-Clique em <u>'Adicionar uma exclusão' > Pasta</u> e por fim selecione a pasta criada anteriormente ('Primo_Launcher' caso tenha seguido a sugestão).</h5>                
                <img class='img-fluid d-block mx-auto' src='../Imagens/Defender/6.png' alt='...' />
                <h5 class='section-subheading text-muted'><br><br><br><br>-Se você desabilitou o windows defender no inicio, pode habilita-lo de novo agora.</h5>                
              </div>
              <div class='text-center'>
              <h1 class='section-heading text-uppercase'><br><br><br><br>Problema com software <u>Warsaw</u></h1>
              <h5 class='section-subheading text-muted'>O software Warsaw vem junto com os apps de proteção de banco, o mesmo bloqueia qualquer arquivo .exe desconhecido.<br></h5>
            </div>
              <div class='text-center'>
                <h5 class='section-subheading text-muted'>-Vá no menu iniciar do Windows, procure por “Adicionar ou remover programas”, ao entrar na opção, procure na lista dos programas instalados no seu PC um programa com o nome Warsaw. 
                  Se houver, desinstale do seu PC, ou ele bloqueará a abertura do Macro.<br><br></h5>
              </div>
          </div>
        </section>











        ";









        $html .= "
        </div></div></div></div></div>";
buildLayout($html);












?>