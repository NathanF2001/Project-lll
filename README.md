# MyClass

MyClass é um aplicativo desenvolvido e planejado em conjunto às disciplina de Engenharia de Software, Introdução ao Armazenamento e Análise de dados, Desenvolvimento de Sistemas de Informação e Projeto Interdisciplinar lll.

# Tecnologias 

  - Flutter (Frontend)
  - Firebase (Banco de dados)
  - Dart e Python (Backend)
  - Scikit-Learn (_Machine Learning_, Modelo de classificação)
 
# Introdução ao Aplicativo

  O MyClass tenta simular interações e atividades de sala de aula. Nele há duas visões: as pessoas que criam a sala de aula e as pessoas que entram nela. As que criam sala de aula vão ser capazes de criar tópicos de assuntos, atividades relacionadas e além de poderem gerenciar métodos de interações entre os usuários que irão entrar em sua sala de aula. As pessoas que entrarem nas salas de aulas serão capazes de observar todos os conteúdos disponibilizados pelo dono da turma, além de poderem interagir tanto com toda a turma quanto com algum grupo específico por meio da plataforma de _chat_.
  
 # Introdução sobre o modelo e escopo Machine Learning
  Por meio do _dataset_ disponibilizado pelo INEP do ENADE 2019 foi desenvolvido o modelo apresentado no projeto. As entradas e saídas do aplicativo foram consequência do trabalho da análise e treinamento do modelo dos dados de acordo com as características socioeconômicas dos alunos - via Questionário do Aluno - e, partindo da hipótese de que variáveis sociais e econômicas influenciam no desempenho dos estudantes, fazer análise preditiva classificatória.
  
 # Configuração de Ambiente
  Para o funcionamento correto do aplicativo é necessário seguir as recomendações:
 
 ## Configuração do Firebase
  - É necessário criar um projeto no Firebase para integrar dentro do projeto, todo passo pode ser encontrado no link abaixo:
    - Android : https://firebase.google.com/docs/android/setup
    - IOS: https://firebase.google.com/docs/ios/setup
  - Para utilização do Google Auth é necessário adicionar SHA-1 em seu projeto Firebase, mais informações:
    - Android: https://firebase.google.com/docs/auth/android/google-signin
    - IOS: https://firebase.google.com/docs/auth/ios/google-signin
    
 ## Execução do Colab
  - Para comunicar o modelo de classifação com aplicativo foi utilizado o próprio Colab como serviço temporário através da biblioteca Flask.
  - Execute notebook Server Machine Learning e ele gerará um link do serviço temporário.
  - Após logar na sua conta haverá um botão no canto superior direito que servirá para colocar o link temporário para _webservice_. Se não colocá-lo o modelo de classificação e o algoritmo de criação de grupos não funcionarão.

# Termos finais
  O objetivo do aplicativo foi criar um ambiente de sala de aula e assim foi feito. Sua implementação foi resultado da definição de escopo de acordo com as disciplinas em um tempo hábil de 10 semanas.
