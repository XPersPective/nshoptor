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
  String get backupSizeWarning =>
      'Backup grande: o arquivo pode ficar pesado. Incluir as fotos também?';

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
      'Suas listas, preços, cupons e fotos ficam no seu aparelho. Fotos e voz nunca saem dele. Com a ajuda de IA ativada, só texto (por exemplo linhas do cupom ou o que você ditou) é enviado ao nosso servidor para processamento, sem ser armazenado.';

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
      'Sem anúncios, mais IA, backup · a partir de um pequeno valor mensal';

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
  String get formatLocaleSystem => 'Sistema (segue o idioma)';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglês (1,234.56)';

  @override
  String get aiToggleTitle => 'Ajuda de IA';

  @override
  String get aiToggleSubtitle =>
      'Associa cupons, lê etiquetas de preço e transforma frases em listas. Fotos e voz ficam no aparelho; só o texto é processado.';

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
  String get planFreeAi => '15 solicitações de IA por mês';

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
  String get planTrial => '7 dias grátis';

  @override
  String get planProAi => '200 solicitações de IA por mês';

  @override
  String get planNoAds => 'Sem anúncios';

  @override
  String get planBackup => 'Exportar e importar backup';

  @override
  String get planMaxAi => '1000 solicitações de IA por mês';

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
  String get planLifetimeTitle => 'Sem anúncios para sempre';

  @override
  String get planLifetimeSubtitle =>
      'Pagamento único: sem anúncios e com backup; a IA fica na cota grátis';

  @override
  String get plansRestore => 'Restaurar compras';

  @override
  String get plansLegal =>
      'As assinaturas são renovadas automaticamente até o cancelamento. Cancele quando quiser em Google Play › Pagamentos e assinaturas. Os preços incluem os impostos mostrados pelo Google Play.';

  @override
  String get planCurrent => 'Atual';

  @override
  String get planStartTrial => 'Teste grátis por 7 dias';

  @override
  String get planChoose => 'Escolher';

  @override
  String get plansAction => 'Planos: Pro e Max';

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
}
