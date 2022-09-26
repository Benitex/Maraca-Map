# Maraca Map

Maraca Map é um mapa virtual que oferece uma série de funções para auxiliar os usuários a descobrir novos lugares nos seus arredores. Feito em Dart com o framework [Flutter](https://flutter.dev) para android e iOS, como projeto final no [CEFET-RJ](http://www.cefet-rj.br/).

O aplicativo foi desenvolvido com o objetivo de guiar as pessoas pela região do Maracanã (Rio de Janeiro, Brasil), mostrando possiveis pontos de interesse, como restaurantes, escolas e pontos de transporte publico. Além disso, o aplicativo busca auxiliar deficientes físicos indicando rampas e pontos com obstáculos no caminho.

## Screenshots

<img src="https://user-images.githubusercontent.com/64505839/192388377-f960d360-2bf6-46d5-af0d-cb6406bb4caf.jpeg" width="260"/> <img src="https://user-images.githubusercontent.com/64505839/192388389-54239c5c-061c-4bbd-ad3b-31ca8023474d.jpeg" width="260"/> <img src="https://user-images.githubusercontent.com/64505839/192388728-9311e6be-7879-472c-8911-565c14a03ba0.jpg" width="260"/>

## Features

* **Explorar**: Tela com recomendações de lugares nos arredores do usuário, com fotos, avaliações e faixa de preço.
* **Tela dos lugares customizada**: Tela com várias informações de um lugar, como endereço, tempo até chegar a pé, horários de funcionamento, faixa de preço, telefone, fotos e avaliações dos usuários.
* **Filtros de tipos de lugares no mapa**: Os usuários podem escolher, ativar e desativar determinados tipos de lugares que aparecem no mapa, como escolas, hospitais e templos religiosos.
* **Filtro de acessibilidade**: Um filtro especial que mostra pontos com obstáculos na calçada, rampas de acesso e lugares sem calçada, faixa de pedestre e rampa.
* **Filtro de trânsito**: Filtro indicando engarrafamentos nas ruas.

## Instalação

Se você não é um desenvolvedor, instale a [última release do aplicativo](https://github.com/Benitex/Maraca-Map/releases/tag/1.0.0).

Se você é um desenvolvedor, antes de compilar e executar o código, adicione suas próprias [API Keys](https://console.cloud.google.com/google/maps-apis/credentials) no arquivo `.env example`, depois, renomeie o arquivo para `.env`.

## Créditos

O projeto foi desenvolvido por [Benito Pepe](https://github.com/Benitex), [Enzo Murajiro](https://github.com/murajiro), [João Pedro Nogueira](https://github.com/jeynog) e [Lennon Fevereiro](https://github.com/Lennon2002).

Os ícones dos marcadores de acessibilidade são versões editadas de ícones no site [Flaticom](https://www.flaticon.com), todos os links para os ícones estão referenciados no arquivo [credits.md](https://github.com/Benitex/Maraca-Map/blob/main/assets/custom_markers/credits.md).
