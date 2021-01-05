
# Capítulo 1 – O Voto

O voto é o objeto central deste processo e o objetivo deste protocolo é protegê-lo e confirmar a sua autenticidade. Assim, com isto em mente definiremos estruturas lógicas que possam nos garantir a proteção e a verificação de autenticidade necessárias.

De forma semelhante ao voto em papel, precisamos de uma estrutura que possibilite o armazenamento de todos os votos para os cargos em disputa em um pleito. Chamaremos esta estrutura de cédula eletrônica. Este deve ser armazenado de forma que seja possível ler com precisão para quem é cada voto. A estrutura da cédula deve ser capaz de armazenar múltiplos votos, um para cada cargo, de uma forma bem organizada e sem ambiguidades. Abaixo segue-se um XSD que apenas exemplifica uma estrutura possível de cédula eletrônica.

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<schema targetNamespace=”http://www.votocol.org/voto”
	  elementFormDefault="qualified"
        xmlns="http://www.w3.org/2001/XMLSchema"
	  xmlns:tns="http://www.votocol.org/e-cedula">

    <element name="e-cedula" type="tns:ECedulaType"></element>
    
    <complexType name="ECedulaType">
    	<sequence>
    		<element name="voto" type="tns:VotoType"
    			maxOccurs="unbounded" minOccurs="1">
    		</element>
    		<element name="timestamp" type="dateTime"></element>
    	</sequence>
    </complexType>

    <complexType name="VotoType">
    	<sequence>
    		<element name="codigo-cargo" type="int"></element>
    		<element name="codigo-candidato" type="int"></element>
    		<element name="nome-cargo" type="string"></element>
    		<element name="nome-candidato" type="string"></element>
    	</sequence>
    </complexType>
</schema>
```
### Figura 1 – Estrutura da cédula eletrônica

À partir do momento que temos um voto realizado, precisamos garantir que cada eleitor só possa votar uma única vez e que possa ser garantida a autenticidade deste voto. Para que isto seja possível, podemos utilizar um conceito bem conhecido, a criptografia assimétrica. O voto não será critografado, mas será gerado um hash para a cédula utilizando uma chave privada do eleitor. Podemos utilizar SHA512WithRSA como algorito de hash. SHA-512 é um hash de 512 bits e é quase impossível conseguir uma colisão mesmo com os computadores mais potentes do mundo.

E um terceiro dado que deve ser enviado juntamente com a cédula e o hash é o certificado do eleitor, que faz parte do par de chaves. Para garantir que o eleitor não possa ser identificado pelo certificado, este não deverá conter nenhum dado que torne possível identificar o eleitor.

Assim, criaremos uma última estrutura que será chamada de cripto-cédula que será composta pelo identificador único da transação, a cédula eletrônica, o hash, o certificado e um timestamp. A figura 2 demonstra graficamente como a estrutura é composta. Observando a figura 2, podemos observar que existe um campo chamado uuid e que é o identificador único da transação. Com este número o eleitor pode conferir se o seu voto está contabilizado.

![Image](../src/cripto-cedula.png)
### Figura 2 - Estrutura da cripto-cédula
