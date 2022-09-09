# Maraca Map

Maraca Map é um mapa virtual que oferece uma série de funções para auxiliar os usuários a descobrir novos lugares nos seus arredores. Feito em Dart com o framework [Flutter](https://flutter.dev) para android e iOS, como projeto final no [CEFET-RJ](http://www.cefet-rj.br/).

O aplicativo foi desenvolvido com o objetivo de guiar as pessoas pela região do Maracanã (Rio de Janeiro, Brasil), mostrando possiveis pontos de interesse, como restaurantes, escolas e pontos de transporte publico. Além disso, o aplicativo busca auxiliar deficientes físicos indicando rampas e pontos com obstáculos no caminho.

## Features

* **Explorar**: Tela com recomendações de lugares nos arredores do usuário, com fotos, avaliações e faixa de preço.
* **Tela dos lugares customizada**: Tela com várias informações de um lugar, como endereço, tempo até chegar a pé, horários de funcionamento, faixa de preço, telefone, fotos e avaliações dos usuários.
* **Filtros de tipos de lugares no mapa**: Os usuários podem escolher, ativar e desativar determinados tipos de lugares que aparecem no mapa, como escolas, hospitais e templos religiosos.
* **Filtro de acessibilidade**: Um filtro especial que mostra pontos com obstáculos na calçada, rampas de acesso e lugares sem calçada, faixa de pedestre e rampa.
* **Filtro de trânsito**: Filtro indicando engarrafamentos nas ruas.

## Instalação

Se você não é um desenvolvedor, instale a [última release do aplicativo](https://github.com/Benitex/Maraca-Map/releases).

Se você é um desenvolvedor, antes de compilar e executar o código, adicione suas próprias [API Keys](https://console.cloud.google.com/google/maps-apis/credentials) no arquivo `.env example`, depois, renomeie o arquivo para `.env`.
