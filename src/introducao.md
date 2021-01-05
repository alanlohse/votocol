
# Introdução

No ano de 2020, devido a pandemia mundial de COVID-19, foram adotadas medidas restritivas que impediam ou dificultavam as pessoas de ir a locais públicos e que poderiam criar aglomerações. Locais de votação causam aglomerações e devido a medidas de restrição adotadas em diferentes locais, muitas pessoas ficaram impedidas ou pelo menos com dificuldades para participar dos ritos democráticos. Há uma tendência para que seja adotado um sistema de votação online via smartfones e por isto se faz necessário a criação de um protocolo que torne possível realizar a votação sem precisar ir aos locais e que seja confiável, transparente, que garanta o anonimato e que possibilite a recontagem.

Existem sistemas de voto eletrônico atualmente, mas se são realmente seguros, não são capazes de inspirar confiança nos corações dos seus usuários. Os sistemas de votação por cédula de papel, apesar de serem considerados antigos, antiquados e de contagem lenta, são comumente considerados mais seguros do que os eletrônicos. Provavelmente, esta confiança venha da evidente capacidade de recontagem que as cédulas de papel oferecem, apesar de ainda ser possível a ocorrência de fraudes que geralmente são pequenas e localizadas e que não são capazes de produzir grandes alterações nos resultados.

Podemos tentar aqui encontrar as razões de um sistema de votação ser confiável. O que esperamos primeiramente de um sistema de votação é que cada voto individual seja contabilidado corretamente no final da apuração dos resultados. Esta é a premissa básica que um sistema deve obedecer. A partir desta premissa básica, podemos então chegar a três requisitos: primeiro, a capacidade de se contar com precisão o número de votos; segundo, capacidade de recontagem; terceiro, inviolabilidade do local onde ficam armazenados os votos.

Outro ponto importante é o anonimato, ninguém pode saber em quem cada eleitor votou, pois, como sabemos, se o voto não é secreto, o eleitor pode ter até sua integridade física ameaçada. Nas cédulas de papel, isto pode ser garantido facilmente apenas tendo cédulas padronizadas e sem nome. Porém, em alguns sistemas eletrônicos conhecidos a capacidade de recontagem pode ter ficado comprometida, não se sabe porque, talvez para que o anonimato fosse alcançado.

A transparência quer dizer que o sistema deve ser aberto e possa ser observado, desde que atendendo aos requisitos de anonimato e inviolabilidade, por qualquer eleitor. Em sistemas por cédula, a transparência é alcançada permitindo que pessoas possam acompanhar o processo de abertura das urnas e o fechamento, como também a contagem dos votos. Em sistemas eletrônicos, porém, uma vez que os votos se tornam pulsos elétricos e bits, se torna muito mais difícil saber o que ocorre dentro de servidores em uma sala de um órgão estatal eleitoral. Seria bom, nesse caso, que o sistema eletrônico permitisse que os eleitores acompanhassem o progresso da votação.

A capacidade de recontagem requer, primeiramente, a possibilidade de armazenamento individual dos votos. Os votos precisam ser armazenados em servidores de forma que ainda seja mantida a sua inviolabilidade e o anonimato. 

A inviolabilidade é a capacidade de manter os votos inalterados nos servidores. Para isto podem ser utilizados algoritmos de hash seguros que impeçam a modificação dos arquivos. A descentralização e a redundância podem ter papéis importantes, pois caso um dos servidores seja comprometido, os demais ainda estarão operacionais.

Todos estes princípios podem ser alcançados com a utilização da tecnologia de Blockchain aplicada ao sistema de votação. Nos próximos capítulos serão descritos tecnicamente como obter um sistema que atenda a cada um dos princípios enumerados acima.

## Terminologia
|||
| ------------- | ------------- |
| Eleitor, Usuário | Eleitor e usuário são pessoas que gozam do pleno direito a votar e que utilizarão os meios providos por este protocolo para realizar o seu direito. |
| Cliente, Aplicativo | É o aplicativo de smartfone que permitirá ao eleitor realizar o seu voto. |
| Block Chain | Tecnologia utilizada em criptomoedas que torna possível evitar, ou pelo menos torna extremamente difícil, que transações sejam modificadas. |
| Servidor | É um servidor onde fica armazenado o Block Chain de votos e que também calcula a Prova-de-Trabalho para cada bloco.  |
| Prova-de-Trabalho | É um hash especial calculado e que valida um bloco na cadeia de blocos de votos. |
| hash | É uma sequência de caracteres calculado utilizando-se de um algoritmo complexo à partir de parâmetros de entrada. |
| Chave privada | É uma das chaves que compõem o par de chaves que é utilizada na criptografia assimétrica para criptografar |
| Chave pública | Juntamente com a chave privada, compõe o par de chaves e é utilizada para descriptografar dados que foram criptografados pela chave privada. |
| Certificado | É uma estrutura que contém a chave pública, mas que torna possível identificar a entidade certificadora. |
| Par de Chaves | Um par de chaves é o conjunto de chave privada e a chave pública. |

<div class="page-break"></div>
