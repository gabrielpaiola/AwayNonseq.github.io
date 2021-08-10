<?php
require_once('../layout.php');



        
$html = "<title>P.M Pacotes</title>";

$html .= " 

<br><br><br>

<!-- Portfolio Grid-->
<section class='page-section bg-light' id='portfolio'>
            <div class='container'>
                <div class='text-center'>
                    <h1 class='section-heading text-uppercase'><u>Pacotes</u></h1>
                    <h3 class='section-subheading text-muted'>Como adiquirir: Acesse seu painel de usuario (via botão abaixo) ou via login e utilize os botões para acesso aos links de pgto, após pgto. enviar via facebook ou discord o comprovante e seu usuário.</h3>
                    <a href='../user/user_login.php'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Painel do Usuário</button></a>
                    <p><br><br></p>
                </div>

                <div class='row'>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Plano Mensal #1</h1>
                            <h5 section-subheading text-muted>(individual)</h5>
                            <p class='Preço'>R$42,10</p>
                            <p class='Preço'>250 TC Global</p>
                            <p>Licença + 30 dias</p>
                        </div>
                    </div>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Renovação Mensal</h1>
                            <h5 section-subheading text-muted>(individual)</h5>
                            <p class='Preço'>R$10,50</p>
                            <p class='Preço'>100 TC Global</p>
                            <p> + 30 dias</p>
                        </div>
                    </div>
                </div>
            <br><br><br>
                <div class='row'>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Plano Trimestral #2</h1>
                            <h5 section-subheading text-muted>(individual)</h5>
                            <p class='Preço'>R$57,90</p>
                            <p class='Preço'>325 TC Global</p>
                            <p>Licença + 90 dias</p>
                        </div>
                    </div>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Renovação Trimestral</h1>
                            <h5 section-subheading text-muted>(individual)</h5>
                            <p class='Preço'>R$26,50</p>
                            <p class='Preço'>175 TC Global</p>
                            <p> + 90 dias</p>
                        </div>
                    </div>
                </div>
            <br><br><br>
                <div class='row'>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Time Mensal #3</h1>
                            <h5 section-subheading text-muted>(minimio 10 pessoas)</h5>
                            <h5 section-subheading text-muted>(valor individual)</h5>
                            <p class='Preço'>R$30,00</p>
                            <p class='Preço'>200 TC Global</p>
                            <p>Licença + 30 dias</p>
                        </div>
                     </div>
                    <div class='col-lg-6 col-sm-6 mb-5'>
                        <div class='card text-center'>
                            <h1>Renovação Mensal</h1>
                            <h5 section-subheading text-muted>~</h5>
                            <h5 section-subheading text-muted>(valor individual)</h5>
                            <p class='Preço'>R$10,50</p>
                            <p class='Preço'>100 TC Global</p>
                            <p> + 30 dias</p>
                        </div>
                    </div>
            </div> <br><br>

           
            <div class='row'>
                
                <div class='col-lg-4 col-sm-6 mb-2'> 
                    <h5 class='text-center' section-subheading text-muted><u><b>Atenção Sobre Vencimentos</u></b></h5>
                    <h5 class='text-center' section-subheading text-muted>Caso seu plano acabe, você tem 5 dias para realizar a renovação, caso contrario precisá pagar a Licença de novo.</h5>
                </div>

                <div class='col-lg-4 col-sm-6 mb-2'> 
                    <h5 class='text-center' section-subheading text-muted><u><b>Promoção por Indicação</u></b></h5>
                    <h5 class='text-center' section-subheading text-muted>Para cada indicação sua que contratar o serviço, serão adicionados 10 dias de cortesia (valido somente para planos individuais).
                    obs. necessário ter a conta ativa (após ativada uma vez, poderá ser adicionados os dias conforme indicações).
                    obs2. lembre de pedir para a pessoa que esta indicando, colocar seu nome na hora de registar.</h5>
                </div>

                <div class='col-lg-4 col-sm-6 mb-2'> 
                    <h5 class='text-center' section-subheading text-muted><u><b>Sobre aumento dos valores em TC Global</u></b></h5>
                    <h5 class='text-center' section-subheading text-muted>Aceitamos TC Global para facilitar o pagamento de um pessoal, porem o mesmo exige um trabalho e seu valor vem caindo diariamente, sentimos muito mas aumentamos 25 tc em cada pacote.</h5>
                </div>
                
            </div>


        </section>












        ";









        $html .= "
        </div></div></div></div></div>";
buildLayout($html);












?>