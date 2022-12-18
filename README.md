# Maraca Map

Maraca Map é um mapa virtual que oferece uma série de funções para auxiliar os usuários a descobrir novos lugares nos seus arredores. Feito em Dart com o framework [Flutter](https://flutter.dev) para android e iOS, como projeto final no [CEFET-RJ](http://www.cefet-rj.br/).

O aplicativo foi desenvolvido com o objetivo de guiar as pessoas pela região do Maracanã (Rio de Janeiro, Brasil), mostrando possiveis pontos de interesse, como restaurantes, escolas e pontos de transporte público. Além disso, o aplicativo busca auxiliar deficientes indicando rampas e pontos com obstáculos no caminho.

## Features

* **Explorar**: Tela com recomendações de lugares nos arredores do usuário, com fotos, avaliações e faixa de preço.
* **Tela dos lugares customizada**: Tela com várias informações de um lugar, como endereço, tempo até chegar a pé, horários de funcionamento, faixa de preço, telefone, fotos e avaliações dos usuários.
* **Listas customizadas**: É possível criar e adicionar lugares à listas customizadas, como lugares favoritos ou que o usuário gostaria de visitar no futuro.
* **Filtros de tipos de lugares no mapa**: Os usuários podem escolher, ativar e desativar determinados tipos de lugares que aparecem no mapa, como escolas, hospitais e templos religiosos.
* **Filtro de acessibilidade**: Um filtro especial que mostra pontos com obstáculos na calçada, rampas de acesso e lugares sem calçada, faixa de pedestre e rampa. Essa função só está disponível na região do Maracanã.
* **Filtro de trânsito**: Filtro indicando engarrafamentos nas ruas.

## Screenshots

<img src="https://user-images.githubusercontent.com/64505839/208317867-ab2e39a7-2b49-44ef-a158-b530dc81a3be.jpg" width="260"/> <img src="https://user-images.githubusercontent.com/64505839/208317876-fdb31680-5296-4929-b5c5-cd60282abcfb.jpg" width="260"/> <img src="https://user-images.githubusercontent.com/64505839/208317871-6ca859ef-e1da-4130-a762-8b9c90c582e3.jpg" width="260"/>

## Instalação

Se você não é um desenvolvedor, acesse a página da [última release do aplicativo](https://github.com/Benitex/Maraca-Map/releases/tag/1.1.0) e siga as instruções de instalação.

Se você é um desenvolvedor, baixe o framework [Flutter na versão 3.7.0 da branch master](https://github.com/flutter/flutter/tree/0c7d84aa789e649cb05b0f5f890c04e482f43737). Depois, clone esse repositório no computador, adicione suas próprias [API Keys](https://console.cloud.google.com/google/maps-apis/credentials) no arquivo `.env example` e renomeie o arquivo para `.env`.

## Créditos

O projeto foi desenvolvido por [Benito Pepe](https://github.com/Benitex), [Enzo Murajiro](https://github.com/murajiro), [João Pedro Nogueira](https://github.com/jeynog) e [Lennon Fevereiro](https://github.com/Lennon2002).

Os ícones dos marcadores de acessibilidade são versões editadas de ícones no site [Flaticom](https://www.flaticon.com), todos os links para os ícones estão referenciados no arquivo [credits.md](https://github.com/Benitex/Maraca-Map/blob/main/assets/custom_markers/credits.md).
