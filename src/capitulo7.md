
# Capítulo 7 – Práticas de Segurança

Este capítulo não se destina a tratar de mais algum item pertencente ao protocolo, mas a práticas de segurança que precisam ser adotadas juntamente com o protolo para que este alcance a sua finalidade. Apesar de toda a segurança e solidez que o protocolo nos provê, se servidores são hackeados, uma eleição pode er impactada. Portanto, os tópicos apresentados a seguir servirão de prevenção contra ataques que servidores possam vir a sofrer.

## 7.1 Mantenha tudo atualizado

Se algum software ou framework é utilizado, como por exemplo, servidores de http, deve-se mantê-los sempre atualizado e, se possível, nas últimas versões. Algumas versões trazem novas proteções contra ataques ou correções de vulnerabilidades existentes. Geralmente as versões são compostas por três números, a versao maior, versão menor e o número de patch. A versão maior geralmente aumenta quando há uma grande mudança no software. A versão menor cresce quando novas funcionalidades são adicionadas. E, por fim, o número do patch identifica que correções de bugs foram realizadas. Porém, se por acaso não for possível utilizar a última versão de determinado software ou framework por algum motivo justificável, pelo menos a última versão de manutenção deverá ser utilizada. Por exemplo, se estiver sendo utilizado o servidor Tomcat na versão 7.0.1 e não se pode utilizar a versão 8.x por algum motivo e somente pode-se utilizar a versão 7, utilize o último patch da versão 7.0.9.  

## 7.2 Sempre troque as senhas

Não se pode em hipótese alguma fornecer um serviço online se esquecendo de trocar todas as senhas padrão dos softwares utilizados. Este costuma ser uma das primeiras coisas que um hacker tenta para invadir determinado site. Também é importante que as senhas sejam fortes e que exista uma política de troca de senhas periódica e, claro, que poucas pessoas de confiança tenham acesso a estas senhas.

## 7.3 Evite injeção de script

Um dos ataques mais comuns é a injeção de script. Em campos de texto, principalmente, os hackers podem tentar inserir texto contendo código malicioso e se a aplicação não evitar isto de alguma forma podem ser causados muitos danos. Uma forma de se proteger deste tipo de ataque é filtrando o texto para remover tags ou caracteres perigosos fazendo "escape" destes.

Este tipo de ataque também pode ocorrer em campos de comentários ou algum texto que possa ser adicionado por usuários. Neste caso, o objetivo não é tomar o controle do site, mas roubar contas de outros usuários, mesmo que temporariamente. E pode ser prevenido da mesma maneira. Este é o motivo deste tipo de recurso ser proibido no aplicativo especificado neste protocolo.

## 7.4 Proteção contra DDOS

O ataque de negação de serviço ou DDOS é bastante comum, mas pode ser evitado. O ataque tenta tomar os recursos dos servidores para que fiquem inacessíveis pelos verdadeiros usuários. Algumas providências podem ser tomadas para evitar isto. Limitar o tamanho das requisições para que não seja enviado volume de dados muito grande. Bloquear requisições de um mesmo endereço de IP ou repetidas em um intervalo de tempo muito curto. Se por acaso isto for necessário, deve-se fazer a devida exceção. Adicionar timeout para que um cliente não "prenda" o servidor por muito tempo na mesma requisição.

## 7.5 Tudo em HTTPS

Utilizar HTTPS aumenta significativamente a segurança de um site ou serviço REST. Além de todo o tráfego de informações se tornar criptografado, ainda existe a vantagem de que pode ser verificada a identidade provedor do site ou serviço. Outra vantagem é que uma vez criptografado, não será possível critografar o conteúdo do site novamente sem ter a chave privada utilizada. Isto cria uma proteção contra tentativas de forjar o site utilizando proxies.
