# Union

Union é um aplicativo móvel desenvolvido como parte da [disciplina de Programação para Dispositivos Móveis](https://github.com/fgsantosti/ProgramacaoDispositivosMoveisFlutter/blob/main/Programa%C3%A7%C3%A3o_pra_Dispositivos_Moveis_Trabalho_Final_2024.ipynb), com o objetivo de facilitar o gerenciamento financeiro de grupos, como famílias ou amigos que compartilham despesas. Ele oferece funcionalidades para cadastro de renda, registro de gastos e visualização de relatórios financeiros, permitindo que os usuários mantenham um controle detalhado de suas finanças coletivas.

## Vídeo de Apresentação

<div>
  <a href="https://youtu.be/tn2AQHMA2AY?si=Q6Fw5EZra6ERSk_X">
    <img src="https://i.ytimg.com/an_webp/tn2AQHMA2AY/mqdefault_6s.webp?du=3000&sqp=CPzz4bYG&rs=AOn4CLBhiTQo4FzoQvlOYsy8MjfXcctLLg" alt="Vídeo de Apresentação" height="300"/>
  </a>
</div>

## Arquitetura

Utiliza a arquitetura **MVVM** (Model-View-ViewModel), facilitada pela utilização do **BLoC** para gerenciamento de estados e separação de responsabilidades. Essa arquitetura permite um código mais modular e de fácil manutenção, alinhando as melhores práticas de desenvolvimento em Flutter.

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/0*dX_zDXT7FiBemzFs.png" alt="MVVM"  height="400"/>

## Funcionalidades

### 1. Autenticação (Auth)

- **Login:** Permite que os usuários façam login com email e senha.
- **Registro:** Permite que novos usuários criem uma conta.

### 2. Grupos (Group)

- **Lista de Grupos:** Exibe os grupos que o usuário criou ou participa, com opção de criar novo grupo.
- **Detalhes do Grupo:** Exibe detalhes de um grupo específico, incluindo nome, membros, e transações do grupo, com opções para adicionar membros e excluir grupo.

### 3. Transações (Transactions)

- **Adicionar Transação:** Permite que o usuário registre uma nova transação, especificando tipo (Fixa/Variável), valor, data, descrição, e grupo.
- **Lista de Transações:** Exibe todas as transações do usuário ou de um grupo, com filtros para visualizar por tipo.

### 4. Relatórios Financeiros (Finance Reports)

- **Relatórios:** Gráficos mostrando a diferença entre receita e gastos pessoais.

## Tecnologias Utilizadas

- **Frontend:** Flutter com MVVM e BLoC
- **Backend e Banco de Dados:** Firebase

## Instalação e Configuração

### Pré-requisitos

- Flutter instalado: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Conta no Firebase: [Firebase Console](https://console.firebase.google.com/)

### Passos para Configuração

1. Clone o repositório:

   ```bash
   git clone https://github.com/RochaGabriell/union.git
   cd union
   ```

2. Configure o Firebase no projeto:

   - Crie um novo projeto no Firebase.
   - Adicione os aplicativos iOS e Android ao projeto Firebase.
   - Baixe os arquivos `google-services.json` (para Android) e `GoogleService-Info.plist` (para iOS).
   - Coloque `google-services.json` na pasta `android/app`.
   - Coloque `GoogleService-Info.plist` na pasta `ios/Runner`.

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Execute o aplicativo:
   ```bash
   flutter run
   ```
