
# Capítulo 6 – Os Três Serviços

Para implementação deste protocolo serão necessários pelo menos três serviços REST. Um serviço para geração de token paa utilização do aplicativo pelo usuário, um serviço de geração de chaves e um serviço de descoberta dos servidores Blockchain. 

## Serviço de geração de token

Este é o serviço que gera o token que permite ao usuário acessar o serviço de geração de chaves. Este deve ser o serviço onde a segurança deverá ser mais reforçada. Observe a figura abaixo para ter uma visão geral do funcionamento.

![Image](../src/fluxo_gera_token.png)
### Figura 7 - Fluxo da geração do token

O serviço deve rodar em protocolo HTTPS e stateless, ou seja, não manterá sessão HTTP. Todos os parâmetros recebidos durante as requisições deverão ser velidados para prevenir inserção de caracteres maliciosos que poderiam resultar em injeção de script.

Primeiramente, o aplicativo verificará se já existe token armazenado no próprio aparelho do usuário. Caso o usuário já possua um token será feita a verificação de access pattern. Esta verificação é realizada analisando-se o IP do usuário comparando com IP's de acessos anteriores e também o IMEI do aparelho será enviado e comparado com o hash previamente armazenado (será explicado mais a frente). Se for o mesmo access pattern, será apenas feita a renovação do token apenas se o mesmo estiver vencido. Mas caso tenha mudado, será realizado o login com usuário e senha. Caso não possua, o acesso ao serviço se iniciará com um login com usuário e senha. Neste momento será gerado um token temporário de curta duração que servirá para que o usuário conclua este processo.

Uma vez logado no sistema com o token temporário, serão verificadas informações do usuário e será enviada uma mensagem SMS para o smartfone com um código aleatório que deverá ser informado em um formulário. Concluidos estes passos, será gravado no registro do usuário um hash (Bcrypt) que será calculado com o número de identificação do dispositivo (IMEI) concatenado a uma sequencia de caracteres fixa, o "salt". Este hash será verificado todo login para confirmar se o usuário o token está sendo utilizado por outro celular. Também será adicionado no registro do usuário os 2 primeiros dígitos do endereço de IP do usuário a uma tabela com relacionamento 1 para N com a tabela do usuário para manter o registro do access pattern.

Após estes passos, será gerado um novo token para o aplicativo com longa duração (algo em torno de 2 semanas). O token será conforme o padrão JWT e assinado com o algoritmo RS512 utilizando chave privada e possuirá um claim que será um identificador único e aleatório que será utilizado para localizar o usuário.

## Serviço de geração de chaves

Este serviço será encarregado de implementar o fluxo da geração do par de chaves junto com o aplicativo e mais será mantido pelo órgão eleitoral. 

Será um serviço REST rodando em um protocolo HTTPS e deverá ser stateless, ou seja, não deverá manter sessão HTTP e em apenas uma requisição do tipo POST realizará todo o processo. O aplicativo enviará todos os dados necessários em uma estrutura JSON. No final do processo será realizado o download do arquivo contendo o certificado e a chave privada.

Por medida de segurança, o JSON contendo os parâmetros para geração enviado pelo usuário deverá ter todos os campos validados para prevenção de algum tipo de tentativa de ataque. Poderão ser utilizados limites no tamanho conteúdo (cabeçalho Content-Length) de requisições POST também com a finalidade de previnir ataques.

## Serviço de Descoberta de Nós

Este serviço será encarregado de fornecer uma lista com os endeços dos nós(servidores) de Blockchain disponíveis para a zona do usuário. Os servidores devem ter sido registrados antes deste momento junto ao órgão eleitoral.

Este serviço será REST rodando em protocolo HTTPS e não requerirá nenhuma autenticação e em apenas um método GET retornará um JSON contendo uma estrutura que tenha o endereço dos servidores e opcionalmente uma descrição.
