// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planeje em casa. Compre como planejou.';

  @override
  String get listsTitle => 'Listas';

  @override
  String get listsTabActive => 'Ativas';

  @override
  String get listsTabCompleted => 'Concluídas';

  @override
  String get listsTabArchived => 'Arquivadas';

  @override
  String get newListButton => 'Nova lista';

  @override
  String get listTitleHint => 'Título (opcional)';

  @override
  String get saveButton => 'Salvar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get editAction => 'Editar';

  @override
  String get listDeleted => 'Lista excluída';

  @override
  String get invalidAmountError => 'Valor inválido';

  @override
  String get duplicateAction => 'Duplicar';

  @override
  String get archiveAction => 'Arquivar';

  @override
  String get unarchiveAction => 'Desarquivar';

  @override
  String get deleteListConfirm =>
      'Excluir esta lista? Os itens planejados também serão removidos.';

  @override
  String get undoButton => 'Desfazer';

  @override
  String get searchListHint => 'Buscar listas';

  @override
  String get currencyLabel => 'Moeda';

  @override
  String get budgetLabel => 'Orçamento (opcional)';

  @override
  String get noteLabel => 'Nota (opcional)';

  @override
  String get storeLabel => 'Loja';

  @override
  String get keepAmountsAction => 'Manter valores';

  @override
  String get resetAmountsAction => 'Redefinir valores';

  @override
  String get currencyChangeWarning =>
      'A moeda vai mudar. O que fazer com os valores existentes?';

  @override
  String get listsEmpty =>
      'Ainda não há listas. Crie seu primeiro plano de compras.';

  @override
  String get statusDraft => 'Rascunho';

  @override
  String get statusPlanned => 'Planejada';

  @override
  String get statusShopping => 'Comprando';

  @override
  String get statusCompleted => 'Concluída';

  @override
  String get statusArchived => 'Arquivada';

  @override
  String autoListTitle(String date) {
    return 'Compras de $date';
  }

  @override
  String get itemFormTitle => 'Adicionar item';

  @override
  String get itemNameLabel => 'Nome do item';

  @override
  String get brandLabel => 'Marca / variante (opcional)';

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get quantityLabel => 'Quantidade';

  @override
  String get unitLabel => 'Unidade';

  @override
  String get pricingModeLabel => 'Entrada de preço';

  @override
  String get pricingModeUnitPrice => 'Preço unitário';

  @override
  String get pricingModeLineTotal => 'Preço total';

  @override
  String get plannedPriceLabel => 'Preço planejado';

  @override
  String lineTotalCalculated(String value) {
    return 'Total: $value';
  }

  @override
  String get requiredItemToggle => 'Item obrigatório';

  @override
  String get maxPriceLabel => 'Preço máximo aceitável (opcional)';

  @override
  String get itemNoteLabel => 'Nota (opcional)';

  @override
  String get categoryProduce => 'Frutas e verduras';

  @override
  String get categoryDairy => 'Laticínios';

  @override
  String get categoryMeat => 'Carnes';

  @override
  String get categoryBakery => 'Padaria';

  @override
  String get categoryDrinks => 'Bebidas';

  @override
  String get categoryCleaning => 'Limpeza';

  @override
  String get categoryPersonalCare => 'Higiene pessoal';

  @override
  String get categoryHome => 'Casa';

  @override
  String get categoryOther => 'Outros';

  @override
  String get invalidQuantityError => 'Quantidade inválida';

  @override
  String get invalidPriceError => 'Preço inválido';

  @override
  String get invalidNameError => 'Digite um nome';

  @override
  String unitPriceCalculated(String value) {
    return 'Preço unitário: $value';
  }

  @override
  String get shoppingTitle => 'Modo compras';

  @override
  String get summaryPlannedTotal => 'Planejado';

  @override
  String get summaryInCart => 'No carrinho';

  @override
  String get summaryRemainingPlan => 'Restante do plano';

  @override
  String get summaryProjected => 'Total estimado no caixa';

  @override
  String get summaryBudgetRemaining => 'Orçamento restante';

  @override
  String get summaryBudgetOver => 'Orçamento estourado';

  @override
  String itemsProgress(String done, String total) {
    return '$done de $total itens';
  }

  @override
  String get filterAll => 'Todos';

  @override
  String get filterToBuy => 'A comprar';

  @override
  String get filterInCart => 'No carrinho';

  @override
  String get filterNotFound => 'Não encontrado';

  @override
  String get filterRequired => 'Obrigatório';

  @override
  String get quickEntryTitle => 'Preço real';

  @override
  String get actualQuantityLabel => 'Quantidade real';

  @override
  String get actualPriceLabel => 'Preço real';

  @override
  String get discountLabel => 'Desconto (opcional)';

  @override
  String get alternativeNameLabel => 'Nome do produto alternativo (opcional)';

  @override
  String get savePurchaseButton => 'Pôr no carrinho';

  @override
  String get unplannedAddButton => 'Adicionar item não planejado';

  @override
  String get statusPending => 'Não pego';

  @override
  String get statusInCart => 'No carrinho';

  @override
  String get statusNotFound => 'Não encontrado';

  @override
  String get statusGaveUp => 'Desistiu';

  @override
  String get statusAlternative => 'Alternativa comprada';

  @override
  String get keepScreenAwake => 'Manter a tela ligada';

  @override
  String get finishShopping => 'Finalizar compras';

  @override
  String get completionWarning =>
      'Há registros faltando ou não verificados. Você pode finalizar mesmo assim; o resultado vai indicá-los.';

  @override
  String get continueShoppingButton => 'Continuar comprando';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get summarySection => 'Resumo';

  @override
  String get plannedTotalLabel => 'Total planejado';

  @override
  String get actualTotalLabel => 'Total real';

  @override
  String get varianceLabel => 'Diferença';

  @override
  String get varianceNotComputable => 'Não é possível calcular';

  @override
  String get budgetStatusLabel => 'Orçamento';

  @override
  String get savingsLabel => 'Abaixo do plano';

  @override
  String get overspendLabel => 'Acima do plano';

  @override
  String get unplannedTotalLabel => 'Total não planejado';

  @override
  String get unpurchasedLabel => 'Planejado, não comprado';

  @override
  String get totalDiscountLabel => 'Descontos totais';

  @override
  String get accuracyLabel => 'Precisão da estimativa';

  @override
  String get groupsSection => 'Itens';

  @override
  String get groupPricier => 'Mais caros que o planejado';

  @override
  String get groupCheaper => 'Mais baratos que o planejado';

  @override
  String get groupClose => 'Perto da estimativa';

  @override
  String get groupNotTaken => 'Planejados, não comprados';

  @override
  String get groupUnplanned => 'Comprados sem plano';

  @override
  String get groupQuantityChanged => 'Quantidade alterada';

  @override
  String get groupUnverified => 'Não verificados';

  @override
  String get plannedQtyLabel => 'Quantidade planejada';

  @override
  String get actualQtyLabel => 'Quantidade real';

  @override
  String get plannedUnitPriceLabel => 'Preço unitário planejado';

  @override
  String get actualUnitPriceLabel => 'Preço unitário real';

  @override
  String get lineVarianceLabel => 'Diferença';

  @override
  String get discountEffectLabel => 'Efeito do desconto';

  @override
  String get notBoughtMark => 'não comprado';

  @override
  String get noPurchasesNote => 'Nenhuma compra registrada.';

  @override
  String get navHome => 'Início';

  @override
  String get navLists => 'Listas';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get homeEmptyTitle => 'Planeje suas compras';

  @override
  String get homeEmptyBody =>
      'Crie sua primeira lista e compare o planejado com o real.';

  @override
  String get homeActiveSection => 'Listas ativas';

  @override
  String get homeCompletedSection => 'Concluídas recentemente';

  @override
  String get homeMonthlySection => 'Este mês';

  @override
  String get monthPlannedLabel => 'Planejado';

  @override
  String get monthActualLabel => 'Real';

  @override
  String get monthVarianceLabel => 'Diferença';

  @override
  String get continueShoppingLabel => 'Continuar comprando';

  @override
  String get historyEmpty =>
      'Ainda não há compras concluídas. Seu histórico e análises aparecerão aqui.';

  @override
  String get aboutTabTitle => 'Sobre o NShoptor';

  @override
  String get aboutBody =>
      'NShoptor, da Crazy Penguin. Planejador de compras que funciona offline. Licenciado sob GPL-3.0.';

  @override
  String get startShoppingLabel => 'Começar as compras';

  @override
  String get finishAndSeeResult => 'Finalizar e ver o resultado';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageTr => 'Turco';

  @override
  String get languageEn => 'Inglês';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get defaultCurrencyLabel => 'Moeda padrão';

  @override
  String get defaultUnitLabel => 'Unidade padrão';

  @override
  String get keepAwakeLabel => 'Manter a tela ligada durante as compras';

  @override
  String get backupSection => 'Backup';

  @override
  String get exportBackupLabel => 'Exportar backup';

  @override
  String get importBackupLabel => 'Importar backup';

  @override
  String get mergeImportLabel => 'Mesclar com os dados atuais';

  @override
  String get separateImportLabel => 'Importar como cópia separada';

  @override
  String get importCancelled => 'Importação cancelada.';

  @override
  String get backupExported => 'Backup exportado com sucesso.';

  @override
  String get deleteAllSection => 'Zona de risco';

  @override
  String get deleteAllLabel => 'Excluir todos os dados';

  @override
  String get deleteAllConfirm =>
      'Isso remove todas as listas, o histórico, as fotos de cupons e os preços. Arquivos que você exportou continuam salvos. Continuar?';

  @override
  String get deleteAllConfirm2 =>
      'Tem certeza absoluta? Esta ação não pode ser desfeita.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get confirmDelete => 'Excluir permanentemente';

  @override
  String get dataDeleted => 'Todos os dados locais foram excluídos.';

  @override
  String get privacyInfoLabel => 'Privacidade';

  @override
  String get privacyInfoBody =>
      'Suas listas, preços, cupons e fotos ficam salvos no seu aparelho. A voz nunca sai dele. Quando a ajuda de IA está ativada, fotos de cupons e de etiquetas de preço (reduzidas de tamanho) e texto, como itens ditados, são enviados ao nosso servidor apenas para serem lidos; eles são processados na hora e nunca armazenados.';

  @override
  String get aboutSection => 'Sobre';

  @override
  String get aboutPublisher => 'Editora: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenças (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Entrada por voz';

  @override
  String get voiceStatusUnknown => 'Serviço: não verificado';

  @override
  String get permissionsLabel => 'Permissões';

  @override
  String get permissionsBody =>
      'Câmera, microfone e notificações só são pedidos quando você usa esses recursos.';

  @override
  String get unitsSection => 'Padrões';

  @override
  String get roundingNote =>
      'Valores seguem uma única regra de arredondamento: metades se afastam do zero, uma vez na conversão.';

  @override
  String get voiceInputTitle => 'Entrada por voz';

  @override
  String get voiceStartListening => 'Começar a ouvir';

  @override
  String get voiceTranscriptLabel => 'Transcrição';

  @override
  String get parseAction => 'Interpretar';

  @override
  String get receiptReviewTitle => 'Revisar cupom';

  @override
  String get receiptTotal => 'Total do cupom';

  @override
  String get receiptTotalUnknown => 'Total não detectado';

  @override
  String get receiptDiff => 'Diferença';

  @override
  String get acceptLine => 'Aceitar linha';

  @override
  String get ignoreLine => 'Ignorar linha';

  @override
  String get receiptLineActions => 'Vincular a um item, dividir ou ignorar';

  @override
  String get receiptCommit => 'Aceitar tudo';

  @override
  String get receiptCommitted => 'Cupom aplicado.';

  @override
  String get priceHistoryTitle => 'Histórico de preços';

  @override
  String get noObservations => 'Ainda não há preços registrados';

  @override
  String get templatesSection => 'Modelos';

  @override
  String get templateHint =>
      'Crie um novo plano a partir de uma compra anterior';

  @override
  String get scanReceiptAction => 'Escanear cupom';

  @override
  String get fromReceiptListButton => 'A partir do recibo';

  @override
  String get shelfLabelAction => 'Preço da etiqueta';

  @override
  String get priceCandidatesTitle => 'Preços sugeridos';

  @override
  String get noPriceCandidates =>
      'Nenhum preço encontrado; digite manualmente.';

  @override
  String get voiceUnavailable =>
      'Reconhecimento de voz indisponível; digite manualmente.';

  @override
  String get linkToItem => 'Vincular a um item';

  @override
  String get splitLine => 'Dividir em duas';

  @override
  String get mergeWithNext => 'Juntar com a próxima';

  @override
  String get ocrNoText => 'Nenhum texto lido; tente de novo.';

  @override
  String get priceHistoryAction => 'Histórico de preços';

  @override
  String get itemsEmptyTitle => 'Ainda não há itens';

  @override
  String get itemsEmptyBody =>
      'Adicione seu primeiro item – na loja você vai registrar aqui os preços reais.';

  @override
  String get addItemTooltip => 'Adicionar item';

  @override
  String get unitAdet => 'un';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'pacote';

  @override
  String get unitKutu => 'caixa';

  @override
  String get unitSise => 'garrafa';

  @override
  String get unitKavanoz => 'pote';

  @override
  String get unitDemet => 'maço';

  @override
  String get unitDuzine => 'dúzia';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalizada';

  @override
  String get setReminderAction => 'Criar lembrete';

  @override
  String get reminderPermissionDenied =>
      'Os lembretes precisam da permissão de notificações. Você pode ativá-la nas configurações do sistema.';

  @override
  String get reminderScheduled => 'Lembrete criado.';

  @override
  String get reminderCancelled => 'Lembrete removido.';

  @override
  String get reminderTitle => 'Lembrete de compras';

  @override
  String reminderBody(Object title) {
    return 'Hora de conferir sua lista: $title';
  }

  @override
  String get reminderPickDate => 'Escolha uma data';

  @override
  String get reminderPickTime => 'Escolha um horário';

  @override
  String get itemDetailsSection => 'Detalhes';

  @override
  String get priceOptionalHint =>
      'Opcional – o preço real você registra na loja';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planejado: $total · $count itens';
  }

  @override
  String get proActiveLabel => 'Pro ativo – obrigado!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Sem anúncios · Exportar e importar backup · Anual';

  @override
  String get proBenefitNoAds => 'Sem anúncios';

  @override
  String get proBenefitBackup => 'Backup (exportar/importar)';

  @override
  String aboutVersion(Object version) {
    return 'Versão $version';
  }

  @override
  String get navDiscover => 'Descobrir';

  @override
  String get shareAction => 'Compartilhar o app';

  @override
  String get rateAction => 'Avaliar';

  @override
  String get aboutOpenRow => 'Sobre e código aberto';

  @override
  String get voiceAddItemAction => 'Adicionar por voz';

  @override
  String get formatLocaleLabel => 'Formato de números e moeda';

  @override
  String get formatLocaleSystem =>
      'Formato do dispositivo (dígitos latinos; caso contrário, inglês)';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglês (1,234.56)';

  @override
  String get aiToggleTitle => 'Ajuda de IA';

  @override
  String get aiToggleSubtitle =>
      'Lê cupons e etiquetas de preço a partir de fotos, associa cupons e transforma frases em listas. As fotos são enviadas apenas para serem lidas e nunca são armazenadas.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Você usou as solicitações de IA deste mês ($used/$limit). Faça upgrade para ter mais ou continue sem IA.';
  }

  @override
  String get aiOffline => 'Sem conexão – seguindo sem IA.';

  @override
  String get aiFailed => 'A IA está indisponível agora – seguindo sem ela.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Aparelho';

  @override
  String get quickListAction => 'Adicionar a partir de uma frase';

  @override
  String get quickListTitle => 'Lista rápida';

  @override
  String get quickListHint =>
      'ex.: 1 kg de maçã 10, 2 pães, meio quilo de queijo';

  @override
  String get quickListConvert => 'Transformar em lista';

  @override
  String quickListAdd(int count) {
    return 'Adicionar $count itens';
  }

  @override
  String get quickListEmpty =>
      'Nenhum item encontrado. Separe-os com vírgulas.';

  @override
  String get receiptAiMatched =>
      'A IA associou o cupom à sua lista. Confira os vínculos e confirme.';

  @override
  String get receiptNeedsCheck => 'Confira esta associação';

  @override
  String get receiptDiscountLine => 'Desconto';

  @override
  String get compareItem => 'Item';

  @override
  String get compareEstimated => 'Estimado';

  @override
  String get compareActual => 'Real';

  @override
  String get compareDiff => 'Diferença';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Orçamento';

  @override
  String get compareNotBought => 'não comprado';

  @override
  String get compareUnplanned => 'não planejado';

  @override
  String get pricierItems => 'Mais caros';

  @override
  String get cheaperItems => 'Mais baratos';

  @override
  String get compareAction => 'Comparar';

  @override
  String get detailsSection => 'Detalhes';

  @override
  String get spendingTitle => 'Gastos';

  @override
  String get spendingAction => 'Gastos';

  @override
  String get spendingMonthTotal => 'Este mês';

  @override
  String get spendingWeekly => 'Gasto semanal';

  @override
  String get spendingMonthly => 'Gasto mensal';

  @override
  String get monthlyLimitTitle => 'Limite mensal';

  @override
  String get monthlyLimitHelp => 'Quanto você quer gastar com compras por mês?';

  @override
  String get monthlyLimitRemove => 'Remover';

  @override
  String get monthlyLimitSet => 'Definir';

  @override
  String get monthlyLimitChange => 'Alterar';

  @override
  String get monthlyLimitNone =>
      'Defina um limite mensal para ver quanto ainda resta.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount acima do limite';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Restam $amount este mês';
  }

  @override
  String get plansTitle => 'Planos';

  @override
  String get plansHeadline => 'Compre melhor com IA';

  @override
  String get plansSubhead =>
      'Associação de cupons, etiquetas de preço e listas a partir de uma frase. Cancele quando quiser.';

  @override
  String get plansMonthly => 'Mensal';

  @override
  String get plansYearly => 'Anual';

  @override
  String get planFree => 'Grátis';

  @override
  String get planFreePrice => 'Grátis para sempre';

  @override
  String get planFreeAi => '10 solicitações de IA por mês';

  @override
  String get planFreeAds =>
      'Pequenos anúncios em banner (nenhum nos primeiros 7 dias)';

  @override
  String get planCoreFeatures => 'Listas, preços, cupons, gráficos de gastos';

  @override
  String get plansPerYear => '/ ano';

  @override
  String get plansPerMonth => '/ mês';

  @override
  String get planTrial => 'Teste gratuito';

  @override
  String get planProAi => '100 solicitações de IA por mês';

  @override
  String get planNoAds => 'Sem anúncios';

  @override
  String get planBackup => 'Exportar e importar backup';

  @override
  String get planMaxAi => '300 solicitações de IA por mês';

  @override
  String get planMaxFamily => 'Para grandes compras da família';

  @override
  String get plansStoreUnavailable => 'A loja não está acessível agora.';

  @override
  String get retryAction => 'Tentar de novo';

  @override
  String get plansPurchaseFailed =>
      'A compra não foi concluída. Tente novamente.';

  @override
  String get plansRestore => 'Restaurar compras';

  @override
  String get plansLegal =>
      'O Pro é renovado automaticamente a cada ano até o cancelamento e inclui 100 solicitações de IA por mês. O preço base é de 1 dólar americano por ano antes dos impostos aplicáveis; confira o preço local final e os impostos na loja antes de confirmar a compra. Gerencie ou cancele a assinatura no Google Play.';

  @override
  String get planCurrent => 'Atual';

  @override
  String get planStartTrial => 'Iniciar teste gratuito';

  @override
  String get planChoose => 'Escolher';

  @override
  String get plansAction => 'Planos: Pro';

  @override
  String get assistantTitle => 'Assistente';

  @override
  String get assistantGreeting => 'Olá! O que você quer fazer?';

  @override
  String get assistantNewList => 'Nova lista';

  @override
  String get assistantVoiceList => 'Lista por voz';

  @override
  String get assistantTextList => 'Lista a partir de uma frase';

  @override
  String get assistantScanReceipt => 'Escanear um cupom';

  @override
  String get assistantSpending => 'Meus gastos';

  @override
  String get assistantReceiptHint =>
      'Abra sua lista e toque no ícone do cupom para escaneá-lo.';

  @override
  String get assistantToggleTitle => 'Mostrar assistente';

  @override
  String get assistantToggleSubtitle =>
      'O pequeno ajudante no canto inferior direito';

  @override
  String get scanPriceLabel => 'Ler etiqueta de preço';

  @override
  String get saveFailed =>
      'Não foi possível salvar. Suas alterações ainda estão aqui. Por favor, tente novamente.';

  @override
  String get deleteItemConfirm =>
      'Excluir este item e suas compras registradas?';

  @override
  String get clearPurchaseConfirm =>
      'Desmarcar este item e remover suas compras registradas?';

  @override
  String get reportPdfAction => 'Salvar relatório em PDF';

  @override
  String get reportNotInvoice =>
      'Resumo das compras, não nota fiscal. As alíquotas de impostos são desconhecidas.';

  @override
  String get purchaseVisits => 'Visitas às compras';

  @override
  String get purchaseInterval => 'Dias médios entre as compras';

  @override
  String get purchasedQuantity => 'Quantidade comprada';

  @override
  String get purchaseAnalyticsHint =>
      'As compras não medem o consumo. Moedas e unidades são exibidas separadamente.';

  @override
  String get receiptReplaces =>
      'Os artigos sem preço são preenchidos. Os que já têm preço de mercado são adicionados como compras separadas.';

  @override
  String get receiptIncompleteHeader =>
      'Inclua a loja, a data, a hora e o número do recibo na próxima foto.';

  @override
  String get receiptIncompleteTail =>
      'Fotografe a secção seguinte com alguns artigos sobrepostos e o total final.';

  @override
  String get receiptContinuationRejected =>
      'Não foi possível juntar esta foto. Volte a fotografar com artigos sobrepostos do mesmo recibo.';

  @override
  String get receiptDraftSaved =>
      'Recibo guardado como rascunho. Pode continuar mais tarde.';

  @override
  String get receiptContinueAction => 'Continuar recibo';

  @override
  String get receiptDraftsTitle => 'Recibos por terminar';

  @override
  String get receiptDuplicate => 'Este recibo já foi adicionado.';

  @override
  String get receiptTotalMismatch =>
      'A soma dos artigos não corresponde ao total do recibo. Verifique se o recibo aparece por inteiro.';

  @override
  String get receiptSaveDraftAction => 'Guardar para mais tarde';

  @override
  String get receiptResolveLines =>
      'Aceite ou ignore cada item antes de guardar.';

  @override
  String get receiptPartialConfirm =>
      'Só os itens selecionados serão adicionados. Este recibo será marcado como importado. Continuar?';

  @override
  String get voiceUnsupportedLanguage =>
      'Este idioma não está disponível para entrada por voz neste dispositivo. Você pode digitar.';

  @override
  String get voiceStopListening => 'Parar de ouvir';

  @override
  String get keepAwakeFailed =>
      'Não foi possível manter a tela ligada. Tente novamente.';

  @override
  String get purchaseHistoryHint =>
      'Todas as compras concluídas. Devoluções reduzem os totais. As datas referem-se ao término das compras. Uma única visita não é suficiente para calcular um intervalo médio.';

  @override
  String get planLegacyRights =>
      'Assinaturas Pro e Max existentes mantêm sua cota mensal original de IA.';

  @override
  String get csvExportAction => 'Exportar CSV';

  @override
  String get reportSharePdf => 'Compartilhar como PDF';

  @override
  String get reportShareCsv => 'Compartilhar como CSV';

  @override
  String get reportPrintAction => 'Imprimir';

  @override
  String get backupSizeWarning =>
      'O JSON inclui registros, não arquivos de foto. Limite de importação: 16 MB.';

  @override
  String get backupImportFailed =>
      'Não foi possível importar este backup. Seus dados não foram alterados.';

  @override
  String get backupImported => 'Backup importado com sucesso.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists listas · $items itens · $entries compras';
  }

  @override
  String get voiceModelDownloading =>
      'O modelo de voz deste idioma está sendo baixado. Tente novamente em um minuto.';

  @override
  String get historyThisWeek => 'Esta semana';

  @override
  String get historyProductsSection => 'Produtos comprados';

  @override
  String get tipReceiptScan =>
      'Digitalize o recibo para comparar os preços com a sua lista';

  @override
  String get tipVoiceAdd =>
      'Diga um ou mais itens e confira-os antes de adicionar';

  @override
  String get tipShelfCamera =>
      'Leia o preço na etiqueta da prateleira com a câmera';

  @override
  String get tipPlan => 'Seu plano: veja detalhes, assine ou faça upgrade';

  @override
  String get guideAddBody =>
      'Toque em + para adicionar um item. Digite o preço planejado agora e o preço de mercado no caixa.';

  @override
  String get guideVoiceBody =>
      'Toque no microfone e diga os itens, por exemplo: \'1 kg de maçãs, 1 pão\'.';

  @override
  String get guideReceiptBody =>
      'Digitalize um recibo para comparar os preços com os itens da sua lista.';

  @override
  String get guidePlanBody =>
      'Toque no ícone do plano para ver seu plano, assinar ou fazer upgrade.';

  @override
  String get guideNext => 'OK';

  @override
  String get guideDone => 'Começar';

  @override
  String get paletteLabel => 'Tema de cores';

  @override
  String get paletteForest => 'Floresta';

  @override
  String get paletteOcean => 'Oceano';

  @override
  String get paletteSunset => 'Pôr do sol';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Preto puro no tema escuro';

  @override
  String get spendingOverview => 'Visão geral';

  @override
  String get spendingThisYear => 'Este ano';

  @override
  String get spendingYearly => 'Gasto anual';

  @override
  String get productSpending => 'Gasto por produto';

  @override
  String get spanWeek => 'Semana';

  @override
  String get spanMonth => 'Mês';

  @override
  String get spanYear => 'Ano';

  @override
  String get weeklyLimitTitle => 'Limite semanal';

  @override
  String get weeklyLimitHelp =>
      'Quanto você quer gastar com compras por semana?';

  @override
  String get weeklyLimitNone =>
      'Defina um limite semanal para ver quanto resta.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Restam $amount nesta semana';
  }

  @override
  String get shoppingLimitTitle => 'Limite por compra';

  @override
  String get shoppingLimitHelp => 'Novas listas começam com este orçamento.';

  @override
  String get shoppingLimitNone =>
      'Defina um orçamento padrão para cada nova compra.';

  @override
  String get monthlyReportAction => 'Relatório mensal';

  @override
  String get reportShoppingColumn => 'Compra';

  @override
  String get reportDateColumn => 'Data';

  @override
  String get planUnavailable => 'Indisponível na loja no momento';

  @override
  String get demoDataTitle => 'Dados de exemplo';

  @override
  String get demoDataLoad => 'Experimentar com dados de exemplo';

  @override
  String get demoDataLoadHelp =>
      'Adiciona 12 meses de compras de exemplo para ver o histórico, os gráficos e o histórico de preços.';

  @override
  String get demoDataRemove => 'Remover dados de exemplo';

  @override
  String get demoDataAdded => 'Dados de exemplo adicionados';

  @override
  String get demoDataRemoved => 'Dados de exemplo removidos';

  @override
  String get demoProductApple => 'Maçãs';

  @override
  String get demoProductBread => 'Pão';

  @override
  String get demoProductMilk => 'Leite';

  @override
  String get demoProductCheese => 'Queijo';

  @override
  String get demoProductTomato => 'Tomates';

  @override
  String get demoProductEggs => 'Ovos';

  @override
  String get demoProductCoffee => 'Café';

  @override
  String get demoProductDetergent => 'Detergente';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Ajuda e suporte';

  @override
  String get howToUseLabel => 'Como usar';

  @override
  String get guidePricesBody =>
      'O preço da loja marca o produto como comprado; 0 também conta. O preço de casa é opcional. Apague o preço da loja para remover a marca.';

  @override
  String get shoppingDateLabel => 'Data das compras';

  @override
  String get shoppingDateNone => 'Nenhuma data selecionada';

  @override
  String get clearShoppingDateAction => 'Limpar data';

  @override
  String get listSortLabel => 'Ordem da lista';

  @override
  String get listSortDate => 'Data das compras';

  @override
  String get listSortAz => 'Nome (A–Z)';

  @override
  String get listSortManual => 'Ordem manual';

  @override
  String get imageCameraAction => 'Tirar foto';

  @override
  String get imageGalleryAction => 'Escolher das fotos';

  @override
  String get imageCaptureFailed =>
      'Não foi possível abrir a câmera ou as fotos. Verifique a permissão de acesso e tente novamente.';

  @override
  String get imageRecognitionFailed =>
      'Não foi possível processar a foto. Tente outra foto.';

  @override
  String get receiptNoProducts =>
      'O texto foi lido, mas nenhum item do recibo foi encontrado. Inclua os itens e o total na foto.';

  @override
  String get keepAwakeOn => 'A tela permanece ligada';

  @override
  String get keepAwakeOff => 'A tela pode desligar';

  @override
  String get spanDay => 'Dia';

  @override
  String get spanCustom => 'Intervalo de datas';

  @override
  String get reportTotalSpent => 'Total gasto';

  @override
  String get reportAddedAt => 'Adicionado';

  @override
  String get reportReceiptNumber => 'Número do recibo';

  @override
  String get reportPreview => 'Pré-visualização';

  @override
  String get reportShareAction => 'Partilhar';

  @override
  String get previousPeriodAction => 'Período anterior';

  @override
  String get nextPeriodAction => 'Período seguinte';

  @override
  String get reportSaved => 'Relatório guardado.';

  @override
  String get reportZoom => 'Ampliar';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dias restantes',
      one: '$days dia restante',
    );
    return '$_temp0';
  }

  @override
  String planTrialHoursLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours horas restantes',
      one: '$hours hora restante',
    );
    return '$_temp0';
  }

  @override
  String get planTrialEndedTitle => 'O período de avaliação do Pro terminou';

  @override
  String get planTrialEndedBody =>
      'Pode continuar a usar listas, introdução manual e voz no dispositivo gratuitamente. O plano Gratuito inclui 10 pedidos de IA por mês civil. Escolha o Pro anual para ter 100 pedidos de IA por mês, sem anúncios e com cópias de segurança. Os seus dados atuais continuam consigo.';

  @override
  String get planContinueFree => 'Continuar gratuitamente';

  @override
  String get supportIdLabel => 'ID de suporte';

  @override
  String get supportEmailLabel => 'Suporte por e-mail';

  @override
  String get captureTipFirst =>
      'Comece bem pelo topo: o nome da loja e a data devem estar visíveis. Inclua o máximo de itens possível; o resto vai na próxima foto.';

  @override
  String get captureTipContinue =>
      'Mesmo recibo: inclua o último item da foto anterior.';

  @override
  String get captureTipNeverShow => 'Não mostrar novamente';

  @override
  String get captureTipOk => 'Entendi';

  @override
  String get captureTipsSetting => 'Mostrar dicas para fotografar o recibo';

  @override
  String get receiptReadingProgress => 'Reading the receipt…';

  @override
  String get receiptReadInBackground => 'Continue in background';

  @override
  String get receiptReadDoneTitle => 'Receipt read';

  @override
  String get receiptReadDoneBody => 'Tap to review and save it.';

  @override
  String get receiptReadMoreTitle => 'Photograph the rest of the receipt';

  @override
  String get receiptReadFailedTitle => 'The receipt could not be read';

  @override
  String get listReceiptsSection => 'Recibos';

  @override
  String get receiptStateComplete => 'Concluído';

  @override
  String get receiptStateIncomplete => 'Incompleto';

  @override
  String get receiptStateFailed => 'Falhou';

  @override
  String get receiptStoreUnknown => 'Loja não lida';

  @override
  String get receiptDeleteAction => 'Excluir recibo';

  @override
  String get receiptDeleteConfirm =>
      'Excluir este recibo e os itens que ele adicionou? Você poderá importá-lo novamente depois.';

  @override
  String get receiptDeleted => 'Recibo excluído.';

  @override
  String listReceiptsShowAll(int count) {
    return 'Mostrar todos ($count)';
  }

  @override
  String get listReceiptsShowLess => 'Mostrar menos';

  @override
  String receiptDateLabel(String date) {
    return 'Data do recibo: $date';
  }

  @override
  String get historyViewShopping => 'Por compra';

  @override
  String get historyViewStore => 'Por loja';

  @override
  String get historyViewProduct => 'Por produto';

  @override
  String get historyShareAll => 'Partilhar tudo';

  @override
  String get historyUnknownStore => 'Loja desconhecida';

  @override
  String get historyDailySpending => 'Gasto diário';

  @override
  String get historyResetPeriod => 'Voltar a esta semana';

  @override
  String get tourSkip => 'Pular';

  @override
  String get tourNewListBody =>
      'Crie uma lista de compras e adicione o que pretende comprar.';

  @override
  String get tourFromReceiptBody =>
      'Já fez as compras? Transforme um recibo em lista com os preços.';

  @override
  String get tourReceiptFlowBody =>
      'Comece pelo topo do recibo: capture primeiro a loja e a data e depois continue com as demais linhas.';

  @override
  String get tourTabsBody =>
      'Alterne entre listas ativas, concluídas e arquivadas. O botão no final muda a ordem.';

  @override
  String get tourDiscoverBody => 'Veja mais apps do mesmo desenvolvedor.';

  @override
  String get tourHelpBody =>
      'Toque aqui para rever este guia. Abra uma lista para ver os totais e os itens explicados.';

  @override
  String get tourTotalsBody =>
      'Os totais previsto, real e a diferença são atualizados enquanto você compra.';

  @override
  String get tourItemsBody => 'Seus itens. Mude a ordem ou pesquise-os aqui.';
}
