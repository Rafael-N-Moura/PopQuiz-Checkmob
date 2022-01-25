# PopQuiz

## Visão Geral

Explicando a estrutura do projeto, eu utilzei os preceitos da Clean Architecture para tentar construir um código mais légivel e fácil de manter. Para cada feature do app temos 3 layers:

* Domain
* Presentation
* Data

### Domain

A layer Domain é a central, independente das outras, é lá onde fica a lógica que descreve as tarefas relacionadas à feature. Dentro do Domain temos as entidades, o repositório e os casos de uso. Defini as entidades de acordo com o JSON apresentado na descrição do Desafio, então, nosso questionário tem um campo id, um campo título e uma lista de questões que por sua vez também têm esse campos, além de um campo para descrição e outro para a resposta. Para os casos de uso, que descreveriam as funcionalidades, pensei nos seguintes:

* Pegar o questionário através da requisição http
* Pegar um questionário que já foi respondido do banco de dados local
* Pegar o histórico de questionários respondidos
* Guardar o questionário no banco de dados local

O repositório é a parte do Domain que fará contato com a layer de dados, particularmente ele apresenta um "contrato" que deve ser obedecido pela implementação do repositório dentro da Data layer.

### Presentation

Essa layer é respónsavel pela interface que será mostrada ao usuário. Ela é dividida em uma pasta para as telas, uma para os widgets e uma para o gerenciador de estados escolhido, no caso o Bloc. O projeto pediu 3 telas, aqui temos duas que funcionam como as 3 pedidas. Na "quiz_history_page" é possível ter acesso ao histórico de questionários respondidos, tocando em algum deles ou clicando no botão da tela você é redirecionado para a "quiz_page". Dependendo do BlocState a tela assumirá uma das funções, vizualizar um questionário já respondido ou adicionar um novo. Falando sobre o Bloc os eventos são análogos aos casos de uso e os estados são os seguintes:

* Loading
* Error
* LoadedApiQuiz
* LoadedLocalQuiz
* LoadedHistory

### Data

A Data Layer é responsável por comunicar-se com o mundo externo, nesse caso receber os dados da requisição http ou do banco de dados local(utilizando o package Hive), e transformá-los nas entidades definidas no Domain. A divisão é feita em modelos, repositório e fontes de dado. Modelos são entidades que podem ser expostas ao mundo exterior, nesse caso os dados são recebidos em um arquivo JSON, então temos métodos fromJson nos modelos, mas no futuro esses dados poderiam ser recebidos de outra forma e como o Domain precisa ser independente de tudo isso, os modelos são usados. O repositório será usado para a comunicação com o Domain, a implementação dos métodos aqui precisa levar em conta o contrato que tinha sido estabelecido. Finalmente, "fontes de dado" é uma denomição autoexplicativa, aqui haverá uma interação direta com os packages http e Hive.
