
# Capítulo 4 – O Blockchain

Blockchain é uma tecnologia bastante disseminada na atualidade e não necessita de muitas explanações. Devido a sua grande resistência a alterações é perfeito para o propósito em que foi aplicado neste protocolo. Este capítulo tratará três pontos, como será implementado o blockchain, como deverão funcionar os nós (servidores) e como será mantido o consenso entre os nós.

Como o próprio nome já deixa explícito, Blockchain é uma cadeia de blocos. Desta forma, neste capítulo padronizaremos como devem ser encadeados os blocos com a finalidade de proteger os votos. Existem várias maneiras possíveis de se fazer isto, desde blocos com apenas um registro até blocos com milhares de registros. Temos que decidir qual será o melhor modelo para votos levando em conta como será feito o consenso entre os nós e, incluindo, a prova-de-trabalho.

Antes de analisarmos isto, precisamos primeiro dimensionar a quantidade de votos que o blockchain teria que armazenar. Atualmente, a votação é dividida por zonas eleitorais que são uma subdivisão de municípios, um bairro, inclusive, pode ter mais de uma zona. Servidores de blockchain podem atender a um município inteiro, não precisando de uma divisão tão pequena quanto as atuais zonas eleitorais, porém, em cidades densamente povoadas como São Paulo, por exemplo, pode ser necessário a divisão em regiões menores para reduzir a carga sobre os servidores. Em uma cidade como essa, com aproximadamente 9 milhões de eleitores, teremos uma carga média aproximada de 250 votos por segundo. É uma carga muito alta e é recomendável que este colégio eleitoral seja dividido em algumas regiões. 

Admitindo-se que o número máximo recomendável de eleitores para cada blockchain seja de 1 milhão – estes serão os piores cenários, onde houver menos eleitores não haverá problemas – poderemos compreender as vantagens e desvantagens de se utilizar um modelo ou outro. Se optarmos por um voto por bloco, teremos um consumo maior de memória devido à adição do cabeçalho e ainda maior consumo de processamento devido à geração de uma prova-de-trabalho para cada um. Porém optando pelo modelo de muitos votos por bloco, teremos apenas um cabeçalho e uma prova de trabalho para muitos votos. Assim, o modelo de muitos votos por bloco tem mais vantagens. A quantidade de votos por bloco pode ser calculada baseado no tempo. Podemos adotar um tempo semelhante ao Bitcoin, 10 minutos, assim, teremos uma quantidade média de 16800 votos por bloco no caso de um blockchain recebendo votos de 1 milhão de eleitores. 

## Implementação do Blockchain

Cada bloco é composto por um cabeçalho e os votos. O cabeçalho é formado por um identificador único, pelo hash do cabeçalho do bloco anterior, pelo Merkle Root, um timestamp, o número da versão do protocolo e por um número chamado nonce. 

![Image](../src/block_header.png)
### Figura 6 – Estrutura do cabeçalho do bloco.

O identificador é um número único e sequencial que serve para que o bloco possa ser localizado. Adotaremos um número inteiro de 32 bits para representar este identificador. Os blocos serão gerados em paralelo pelos nós de forma que os identificadores serão os mesmos ajudando depois no consenso.

O hash do cabeçalho do bloco anterior é o segundo campo e é o que torna isto uma cadeia de blocos. Este campo será calculado pela geração da prova-de-trabalho do bloco anterior, mas para validação basta simplesmente calcular o hash SHA-512 dos campos do cabeçalho do anterior.

O campo seguinte é o Merkle Root. Este dado serve para reduzir o número de cálculos de hashs das cripto-cédulas calculando uma árvore de hashes chamada Merkle Tree. Esta árvore possuirá folhas que serão hashes diretos das cédulas, mas para cada par de cédulas, será calculado apenas um hash à partir dos hashes das duas cédulas concatenados. Veja a imagem abaixo.

![Image](../src/merkle_tree.png)
### Figura 7 – Merkle Tree.

Os hashes dos ramos vão reduzindo cada par de hashes das camadas abaixo a apenas um. Para o caso de não haver par para o último número, este será calculado com ele mesmo. As camadas vão sendo reduzidas até que só sobre um hash, este será o Merkle Root.

O timestamp será a data e hora atuais no formato AAAAMMDDHHmmss, onde AAAA é o ano com quatro dígitos, MM é um número com dois dígitos que identifica o mês, DD é o dia do mês com dois dígitos, HH é a hora no formato de 24 horas, mm são os minutos e ss os segundos.

O número da versão é formado por 4 bytes, sendo que o primeiro byte é o número maior da versão que muda quando houver uma alteração que quebraria a compatibilidade com as versões anteriores, o segundo é o número de sub-versão que é incrementado quando ocorre alguma alteração que não torne o protocolo incompatível com as versões anteriores, o terceiro são versões de correção e o último número é reservado e será sempre zero.

O campo nonce é um número que será incrementado durante o cálculo da prova-de-trabalho até encontrar o hash válido.

Uma vez definido como será o cabeçalho, é hora de especificar como será o corpo do bloco. A primeira informação será o hash do cabeçalho atual, seguido pela Merkle Tree e por último as cripto-cédulas.

O hash do cabeçalho atual, que também é a prova-de-trabalho, é calculado utilizando-se o algoritmo SHA-512 com os dois primeiros bytes sendo iguais aos dois números hexadecimais 0x56 e 0x8b, caso seja necessário aumentar a dificuldade, pode-se adicionar o terceiro byte sendo igual a 0x68. Estes números foram escolhidos devido ao fato de que, quando codificados para base 64, eles escrevem a palavra "Voto". Não é necessário uma prova de trabalho muito pesada de se calcular porque para manter o consenso será realizada uma validação em cada Nó.

A Merkle Tree é outra parte integrante do corpo após o hash do cabeçalho atual e não há necessidade de repetir a root, apenas as camadas que seguem após a root até chegar às folhas. E as cripto-cédulas seguem após a árvore.

Esta disposição não precisa ser seguida no armazenamento interno do banco de dados do nó, mas é uma convenção lógica e em caso de serialização fica-se padronizado desta forma.

## Os Nós do Blockchain

Cada nó do Blockchain pode ser um ou mais computadores. O ideal é que seja pelo menos formado por três, um computador de interface com a internet que expõe serviços para os eleitores votarem e para se comunicarem com os outros nós, uma máquina de processamento que calcula a prova-de-trabalho e outra máquina de banco de dados. 

Dos serviços que precisam ser expostos dois são para os eleitores e três são para comunicação entre os nós. Os serviços para eleitores são um para registro do voto e outro para que o eleitor possa verificar se o voto está contabilizado a qualquer momento. Os serviços dos nós são um de recebimento de notificação dos nó, outro para leitura do último bloco confirmado e um terceiro que só ficará acessível após o término do período de votação e que servirá para ler todo o blockchain.

O serviço de registro de voto deverá funcionar conforme descrito no [capítulo 5](#capítulo-5--votação) e a autenticação será realizada com base no token do aplicativo. Primeiramente, o token será validado com chave pública do órgão (da chave privada que gerou o token) e em seguida verificará se o usuário já havia registrado o voto. O servidor não manterá nenhum registro que possa ferir o sigilo do voto. Registros mantidos não poderão vincular a cripto-cédula ao token ou ao eleitor.

O segundo serviço para os usuários, o que serve para verificar o voto, de forma semelhante ao primeiro, utilizará a segurança do token e consultará a cripto-cédula registrada pelo número da transação recebido após o voto. O servidor não manterá nenhum registro dessa consulta que possa ferir ao princípio do sigilo do voto.

Para a comunicação entre os nós, temos como primeiro serviço a notificação de que o servidor completou a prova-de-trabalho para o último bloco. A comunicação entre os nós não necessita de autenticação, mas pode ser criada uma restrição para que somente possam ser acessados por IP's de uma lista, uma lista contendo os IP1's dos próprios nós.

O segundo serviço para comunicação entre os nós é o serviço de leitura do último bloco confirmado. Este serviço possuirá segurança semelhante ao primeiro.

O terceiro serviço será um serviço que ficará disponível somente após o término do período de votação e tem por objetivo possibilitar a leitura do blockchain completo. O serviço não retornará todo o blockchain de uma vez, mas cada bloco paseado no seu número. Este serviço será aberto e não possuirá restrições de acesso, apenas proteções para evitar ataques.

## Consenso

Devido aos nós trabalharem em paralelo recebendo e processando votos ininterruptamente até o final do período de votação, precisa-se garantir que todos estejam sincronizados entre sí, assim, é necessário que seja mantido o consenso entre eles. 

Conforme foi dito anteriormente, cada bloco conterá os votos recebidos durante 10 minutos de funcionamento e após este tempo acabar, este será fechado para novos votos e a prova-de-trabalho será calculada em um nó selecionado aleatoriamente com um algoritmo de números pseudo aleatórios seguro ou números aleatórios reais.

O sorteio funcionará da seguinte forma, o nó poderá votar em outro nó que não esteja penalizado aleatóriamente, mas não nele mesmo. E em seguida enviará este voto para os outros em forma de notificação.

O servidor que finalizar o cálculo da prova-de-trabalho disparará uma notificação através dos serviços explicados acima para os demais servidores para que os outros possam se sincronizar com este. Após receberem a notificação, os servidores baixarão o cabeçalho e a merkle tree do último bloco e farão uma validação dos cálculos e caso esteja correto, sincronizarão o bloco. Para reduzir o consumo de banda, o nó apenas tentará ajustar o bloco para que este fique com a mesma ordem dos votos e merkle root iguais. Se for encontrado algum voto que não foi contabilizado no bloco que já se encontra fechado, o voto será movido para o próximo, mas apenas votos que não tiverem sido movidos anteriormente, caso o voto esteja sendo movido pela segunda vez, todos os nós deverão ser notificados do voto faltante, o cálculo do bloco será invalidado.

Quando o cálculo de prova-de-trabalho de um nó é invalidado por faltarem votos ou por simplesmente estar errado, será realizado um novo sorteio para cálculo do bloco, porém o nó que realizou o cálculo errado não poderá participar deste sorteio e sofrerá uma penalidade. Esta penalidade valerá por uma rodada, ou seja, além de não poder ser sorteada para calcular a prova-de-trabalho que foi invalidada, não poderá calcular também do próximo bloco.

![Image](../src/Fluxo_consenso.png)
### Figura 8 – Ciclo do consenso.
