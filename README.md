# PopQuiz - Checkmob

* A versão em Português está logo abaixo.
## Overview

Explaining the project's structure, I used Clean Architecture precepts to try to build more readable and maintainable code. For each feature we have 3 layers:

* Domain
* Presentation
* Date

### Domain

The Domain layer is the central one, independent of the others, it's where the logic that describes the tasks related to the feature is. Inside the Domain we have the entities, the repository and the use cases. I defined the entities according to the JSON presented in the Challenge description, so our questionnaire has an id field, a title field and a list of questions that also have these fields, in addition to a field for description and another for the answer. For the use cases, which would describe the functionality, I thought of the following:

* Get the quiz via http request
* Get a quiz that has already been answered from the local database
* Get the history of answered quizzes
* Save the quiz in the local database

The repository is the part of the Domain that will make contact with the data layer, particularly it presents a "contract" that must be filled by the repository implementation within the Data layer.

### Presentation

This layer is responsible for the interface that will be shown to the user. It's divided into a folder for screens, one for widgets and one for the chosen state manager, in this case the Bloc. The project asked for 3 screens, here we have two that work like the 3 requested. In "quiz_history_page" it's possible to have access to the history of answered quizzes, tapping on any of them or clicking on the screen button you are redirected to "quiz_page". Depending on the BlocState, the screen will assume one of the functions, viewing an already answered quiz or adding a new one. Talking about Bloc the events are analogous to the use cases and the states are as follows:

* Loading
* Error
* LoadedApiQuiz
* LoadedLocalQuiz
* LoadedHistory

### Data

The Data Layer is responsible for communicating with the outside world, in this case receiving the data from the http request or from the local database (using Hive package), and transforming them into the entities defined in the Domain. The division is done in models, repository and data sources. Models are entities that can be exposed to the outside world, in this case the data is received in a JSON file, so we have fromJson methods in the models, but in the future this data could be received in another way and as the Domain needs to be independent of all that stuff, the models are used. The repository will be used to communicate with the Domain, the implementation of the methods here needs to take into account the contract that had been established. Finally, "data sources" is a self-explanatory term, here there will be a direct interaction with the http and Hive packages.

#

# PopQuiz - Checkmob

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
