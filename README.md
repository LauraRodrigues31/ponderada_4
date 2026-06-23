# ponderada_4

## 🔨 Processo de Desenvolvimento

### Passo 1 — Reorganização em Clean Architecture

Reorganizei o `lib/` seguindo Clean Architecture, separando o projeto em quatro camadas: `screens/` (apresentação), `models/` (domínio), `services/` (regras de negócio) e `repositories/` (acesso a dados). Movi `HomeScreen` e `SobreScreen` do `main.dart` para seus próprios arquivos em `screens/`, e atualizei o `main.dart` para importá-las. Criei também telas vazias (`NovaColeta`, `Historico`, `Detalhe`) e placeholders comentados para as camadas de dados, deixando a estrutura pronta para implementação incremental sem quebrar nenhuma funcionalidade existente.

### Passo 2 — Tela Nova Coleta (formulário)

Implementei a tela Nova Coleta como StatefulWidget pois ela precisa manter o estado dos campos durante o preenchimento. Segui a separação de camadas: a Screen funciona como Handler, responsável apenas pela UI e interação do usuário, sem lógica de negócio. Adicionei validação de formulário com GlobalKey<FormState>. Os botões de câmera e GPS são placeholders por enquanto — serão integrados nos próximos passos.

### Passo 3 — Câmera (primeiro hardware)

Integrei o image_picker para captura de fotos pela câmera nativa. Criei CameraService em services/ seguindo Clean Architecture: a Screen (Handler) apenas reage ao toque e chama o Service, que é o único lugar que conhece o image_picker. A tela exibe preview da foto capturada ou um placeholder visual quando nenhuma foto foi tirada ainda.

### Passo 4 — GPS (segundo hardware)

Integrei o geolocator para captura de coordenadas GPS. Criei LocationService em services/ seguindo o mesmo padrão do CameraService: a Screen apenas reage ao toque e delega ao Service. Implementei tratamento de erro para os casos de permissão negada e GPS desligado — primeiro ponto do app onde erros reais de hardware precisaram ser tratados explicitamente.

### Passo 5 — Model Coleta e SQLite

Defini o Model Coleta na camada Domain com serialização toMap/fromMap para o SQLite. Implementei ColetaRepository como único ponto de acesso ao banco — nenhuma outra camada conhece o sqflite. ColetaService orquestra a operação entre Screen e Repository. O fluxo completo agora é: Screen → Service → Repository → SQLite.

### Passo 6 — Telas Histórico e Detalhe

Implementei as telas de listagem e detalhe consumindo ColetaService já existente — não foi necessário modificar nenhuma camada de Service ou Repository, apenas criar as Screens. Isso demonstra a arquitetura funcionando: as camadas inferiores são estáveis e as Screens apenas consomem. DetalheScreen recebe o objeto Coleta via construtor sem buscar o banco novamente.

### Passo 7 — API externa Open-Meteo

Integrei a API Open-Meteo para buscar clima automaticamente após captura do GPS. WeatherService acessa a API diretamente sem Repository abaixo — decisão arquitetural consciente pois não há persistência de dados climáticos. Criei o model Clima com getter de descrição humanizada do weatherCode. A falha na API não bloqueia o fluxo do usuário.

### Passo 8 — Firebase e persistência de clima

Implementei sync com Firestore e Storage seguindo offline-first: SQLite sempre primeiro, Firebase em background sem bloquear o usuário. FirebaseService é isolado em services/ — nem a Screen nem o Repository conhecem Firebase diretamente. Aproveitei a migração do model para adicionar persistência de temperatura e condição climática junto com cada coleta. Migração do SQLite implementada com onUpgrade para não quebrar dados existentes.

### Passo 9 — Notificações locais

Implementei notificação local disparada pelo ColetaService após confirmação de sync com Firebase. A escolha por notificação local (não push) é intencional: o gatilho é interno ao app. NotificationService é inicializado no main.dart antes do runApp. A Screen não conhece o sistema de notificações — o feedback ao usuário é responsabilidade da camada de Service.

### Passo 10 — Compartilhamento

Implementei compartilhamento via share_plus que aciona o menu nativo do sistema operacional. Criei ShareService em services/ para manter consistência arquitetural — a Screen não acessa o share_plus diretamente. O compartilhamento inclui foto quando disponível via shareXFiles, ou apenas texto quando não há foto.

### Passo 11 — Tratamento de erros e polish

Revisei todas as telas e services para tratar falhas de forma explícita e amigável. Cada ponto de falha tem comportamento definido: câmera cancelada não gera erro, GPS indisponível mostra mensagem específica, falha no SQLite mostra tela de erro com retry, foto inexistente no disco tem fallback visual. Adicionei timeouts no Firebase (10s) e Open-Meteo (5s) para evitar esperas indefinidas. Botão de salvar desabilitado durante operação para evitar duplo envio.

> **⚠️ Configuração necessária para Firebase funcionar:**
> Crie um projeto no [Firebase Console](https://console.firebase.google.com/), adicione um app Android com o package name do projeto, baixe o arquivo `google-services.json` gerado e coloque em `android/app/google-services.json`. Para iOS, baixe o `GoogleService-Info.plist` e adicione em `ios/Runner/`. Sem esses arquivos o app continua funcionando normalmente em modo offline-first — o sync com Firebase simplesmente não ocorre.