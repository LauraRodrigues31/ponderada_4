# ponderada_4

## 🔨 Processo de Desenvolvimento

### Passo 1 — Reorganização em Clean Architecture

Reorganizei o `lib/` seguindo Clean Architecture, separando o projeto em quatro camadas: `screens/` (apresentação), `models/` (domínio), `services/` (regras de negócio) e `repositories/` (acesso a dados). Movi `HomeScreen` e `SobreScreen` do `main.dart` para seus próprios arquivos em `screens/`, e atualizei o `main.dart` para importá-las. Criei também telas vazias (`NovaColeta`, `Historico`, `Detalhe`) e placeholders comentados para as camadas de dados, deixando a estrutura pronta para implementação incremental sem quebrar nenhuma funcionalidade existente.

### Passo 2 — Tela Nova Coleta (formulário)

Implementei a tela Nova Coleta como StatefulWidget pois ela precisa manter o estado dos campos durante o preenchimento. Segui a separação de camadas: a Screen funciona como Handler, responsável apenas pela UI e interação do usuário, sem lógica de negócio. Adicionei validação de formulário com GlobalKey<FormState>. Os botões de câmera e GPS são placeholders por enquanto — serão integrados nos próximos passos.

### Passo 3 — Câmera (primeiro hardware)

Integrei o image_picker para captura de fotos pela câmera nativa. Criei CameraService em services/ seguindo Clean Architecture: a Screen (Handler) apenas reage ao toque e chama o Service, que é o único lugar que conhece o image_picker. A tela exibe preview da foto capturada ou um placeholder visual quando nenhuma foto foi tirada ainda.