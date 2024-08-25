# Union

Union é um aplicativo móvel desenvolvido como parte da [disciplina de Programação para Dispositivos Móveis](https://github.com/fgsantosti/ProgramacaoDispositivosMoveisFlutter/blob/main/Programa%C3%A7%C3%A3o_pra_Dispositivos_Moveis_Trabalho_Final_2024.ipynb), com o objetivo de facilitar o gerenciamento financeiro de grupos, como famílias ou amigos que compartilham despesas. Ele oferece funcionalidades para cadastro de renda, registro de gastos e visualização de relatórios financeiros, permitindo que os usuários mantenham um controle detalhado de suas finanças coletivas.

## Funcionalidades

### 1. Autenticação (Auth)

- **Login:** Permite que os usuários façam login com email e senha.
- **Registro:** Permite que novos usuários criem uma conta.
- **Recuperação de Senha:** Permite que os usuários redefinam sua senha.

### 2. Perfil (Profile)

- **Perfil do Usuário:** Permite que o usuário visualize e edite suas informações pessoais, incluindo nome, email, renda fixa.

### 3. Grupos (Group)

- **Lista de Grupos:** Exibe os grupos que o usuário criou ou participa, com opção de criar novo grupo.
- **Detalhes do Grupo:** Exibe detalhes de um grupo específico, incluindo nome, membros, e transações do grupo, com opções para adicionar membros e editar/excluir grupo.

### 4. Transações (Transactions)

- **Adicionar Transação:** Permite que o usuário registre uma nova transação, especificando tipo (Fixa/Variável), valor, data, descrição, e grupo.
- **Lista de Transações:** Exibe todas as transações do usuário ou de um grupo, com filtros para visualizar por tipo, valor, data, e grupo.

### 5. Relatórios Financeiros (Finance Reports)

- **Relatórios:** Exibe gráficos e relatórios financeiros, incluindo receitas e despesas pessoais e compartilhadas, com filtros para selecionar o período (mensal, anual).

## Tecnologias Utilizadas

- **Frontend:** Flutter
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
