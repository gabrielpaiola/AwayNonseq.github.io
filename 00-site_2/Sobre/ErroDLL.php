<?php
require_once('../layout.php');



        
$html = "<title>P.M ErroDLL</title>";

$html .= " 


<br><br><br>
        <section class='page-section' id='sobre'>
          <div class='container'>
              <div class='text-center'>
                <h1 class='section-heading text-uppercase'>Falta de DLL</h1>
                <h5 class='section-subheading text-muted'>Em alguns windows, por falta de updates / drivers / softwares podem faltars dlls, esse problema é facilmente corrigido.<br></h5>
              </div>
              <div class='text-center'>
                <h1 class='section-heading text-uppercase'><br><br>VCRUNTIME140.dll</h1>
                <a href='https://pt.dll-files.com/vcruntime140.dll.html?' target='_blank'>Site Referencia<br></a>
                <a><img src='../Imagens/DLL/VCRUNTIME140.png' alt='...' /></a>
                <h5 class='section-subheading text-muted'><br><br>-Basta instalar os seguintes exe para correção desta falta de DLL. ( caso seu windows seja 64 bits, necessário instalar ambas as versões).</h5>
                <a href='https://aka.ms/vs/16/release/VC_redist.x86.exe'><br>Microsoft Visual C++ 2019 x86 Redistributable</a>
                <a href='https://aka.ms/vs/16/release/VC_redist.x64.exe'><br>Microsoft Visual C++ 2019 x64 Redistributable</a>
          </div>
        </section>












        ";









        $html .= "
        </div></div></div></div></div>";
buildLayout($html);












?>