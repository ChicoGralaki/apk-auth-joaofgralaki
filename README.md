# Flutter Auth App

Aplicativo de autenticação desenvolvido com **Flutter** e **Firebase Authentication**, como projeto acadêmico para praticar desenvolvimento mobile e integração com serviços do Firebase.

O aplicativo permite criar contas, realizar login, recuperar senhas e gerenciar a sessão do usuário autenticado.

## Funcionalidades

- **Login:** autenticação com e-mail e senha.
- **Cadastro:** criação de novas contas com validação da confirmação de senha.
- **Recuperação de senha:** envio de e-mail para redefinição de senha.
- **Sessão autenticada:** identificação automática do usuário por meio do estado de autenticação do Firebase.
- **Tela inicial:** exibição do e-mail do usuário autenticado.
- **Logout:** encerramento da sessão.

## Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| Flutter | Desenvolvimento da interface mobile |
| Dart | Linguagem de programação |
| Firebase Core | Inicialização e integração com Firebase |
| Firebase Authentication | Gerenciamento de autenticação |
| Material Design | Componentes e identidade visual |

## Estrutura do projeto

```text
lib/
├── components/
│   ├── my_button.dart
│   ├── my_textfield.dart
│   └── social_button.dart
├── view/
│   ├── auth_page.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   └── register_page.dart
├── theme/
│   └── app_theme.dart
├── firebase_options.dart
└── main.dart
```

## Como executar

### 1. Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio ou VS Code
- Um emulador Android ou dispositivo físico.

### 2. Clonar o repositório

```bash
git clone https://github.com/ChicoGralaki/apk-auth-joaofgralaki.git
```

Entre na pasta do projeto:

```bash
cd apk-auth-joaofgralaki
```

### 3. Instalar as dependências

```bash
flutter pub get
```

### 4. Configuração do Firebase

O projeto utiliza o Firebase Authentication com o provedor de autenticação por e-mail e senha.

Para utilizar sua própria configuração do Firebase:

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Registre o aplicativo Android utilizando o identificador `com.example.apk_auth_joaofgralaki`.
3. Ative o provedor **Email/Password** em Authentication.
4. Configure a integração utilizando o FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Esse processo gera o arquivo `lib/firebase_options.dart` com as configurações do projeto Firebase selecionado.

### 5. Executar o aplicativo

Com um emulador ou dispositivo conectado:

```bash
flutter run
```

## Validação

O projeto foi analisado com o comando:

```bash
flutter analyze
```

Resultado: **No issues found!**

O funcionamento também foi verificado em emulador Android.

## Observações

- A autenticação implementada utiliza e-mail e senha por meio do Firebase Authentication.
- Os botões de Google e Apple estão presentes na interface como elementos visuais, mas ainda não possuem integração com autenticação social.
- A configuração para outras plataformas pode exigir etapas adicionais no Firebase.

---

**Desenvolvido por [Chico Gralaki](https://github.com/ChicoGralaki)**

Projeto acadêmico desenvolvido com Flutter e Firebase.