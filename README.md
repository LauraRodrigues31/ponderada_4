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