
# Capítulo 3 – Aplicativo

O aplicativo é uma parte essencial deste sistema e merece melhor atenção. Ele é cliente dos três serviços e ainda dos nós de blockchain. Este capítulo se dedicará a especificar os requisitos necessários para que este aplicativo possua a segurança necessária a sua missão de prover a capacidade do eleitor votar.

## Requisitos de segurança

O aplicativo deverá verificar se o smartfone está conectado na internet através de um proxy e avisar ao usuário para que ele remova esta configuração antes de votar, caso seja realmente necessário o proxy para conectar a internet, o usuário poderá confirmar o uso do mesmo.

Não será permitido a utilização do aplicativo em dispositivos com acesso ao root (rooted). Caso o dispositivo estiver em root, deverá ser apresentada uma mensagem ao usuário notiicando-o deste problema.

O aplicativo deverá manter uma cópia do certificado para verificar todas as conexões que realizar para garantir que os certificados dos endereços conectados possuem ancestralidade do órgão eleitoral.

Não poderão ser adicionados ADs (adversiting) ao aplicativo.

Não existirá nenhuma adição de comentários nem nenhum texto que possa ser adicionado por usuários. A aplicativo utilizará apenas código que estiver no pacote instalado.

Os dados salvos no armazenamento interno do smartfone serão critpgrafados.

Para mais informações sobre segurança de aplicativos, consulte https://developer.android.com/training/articles/security-tips e https://developer.apple.com/documentation/security


