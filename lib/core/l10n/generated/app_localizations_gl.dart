// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planifica en casa. Compra como planeaches.';

  @override
  String get listsTitle => 'Listas';

  @override
  String get listsTabActive => 'Activas';

  @override
  String get listsTabCompleted => 'Completadas';

  @override
  String get listsTabArchived => 'Arquivadas';

  @override
  String get newListButton => 'Nova lista';

  @override
  String get listTitleHint => 'Título (opcional)';

  @override
  String get saveButton => 'Gardar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get editAction => 'Editar';

  @override
  String get listDeleted => 'Lista eliminada';

  @override
  String get invalidAmountError => 'Cantidade non válida';

  @override
  String get duplicateAction => 'Duplicar';

  @override
  String get archiveAction => 'Arquivar';

  @override
  String get unarchiveAction => 'Desarquivar';

  @override
  String get deleteListConfirm =>
      'Queres eliminar esta lista? Os seus elementos planificados tamén se eliminarán.';

  @override
  String get undoButton => 'Desfacer';

  @override
  String get searchListHint => 'Buscar listas';

  @override
  String get currencyLabel => 'Moeda';

  @override
  String get budgetLabel => 'Presuposto (opcional)';

  @override
  String get noteLabel => 'Nota (opcional)';

  @override
  String get storeLabel => 'Tenda';

  @override
  String get keepAmountsAction => 'Manter as cantidades';

  @override
  String get resetAmountsAction => 'Restablecer as cantidades';

  @override
  String get currencyChangeWarning =>
      'A moeda está a cambiar. Que debería ocorrer coas cantidades existentes?';

  @override
  String get listsEmpty =>
      'Aínda non hai listas. Crea o teu primeiro plan de compra.';

  @override
  String get statusDraft => 'Borrador';

  @override
  String get statusPlanned => 'Planificado';

  @override
  String get statusShopping => 'Comprando';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get statusArchived => 'Arquivado';

  @override
  String autoListTitle(String date) {
    return 'compras do $date';
  }

  @override
  String get itemFormTitle => 'Engadir elemento';

  @override
  String get itemNameLabel => 'Nome do elemento';

  @override
  String get brandLabel => 'Marca / variante (opcional)';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get quantityLabel => 'Cantidade';

  @override
  String get unitLabel => 'Unidade';

  @override
  String get pricingModeLabel => 'Modo de prezo';

  @override
  String get pricingModeUnitPrice => 'Prezo unitario';

  @override
  String get pricingModeLineTotal => 'Total da liña';

  @override
  String get plannedPriceLabel => 'Prezo planificado';

  @override
  String lineTotalCalculated(String value) {
    return 'Total da liña: $value';
  }

  @override
  String get requiredItemToggle => 'Elemento obrigatorio';

  @override
  String get maxPriceLabel => 'Prezo máximo aceptable (opcional)';

  @override
  String get itemNoteLabel => 'Nota (opcional)';

  @override
  String get categoryProduce => 'Froitas e verduras';

  @override
  String get categoryDairy => 'Lácteos';

  @override
  String get categoryMeat => 'Carne';

  @override
  String get categoryBakery => 'Panadería';

  @override
  String get categoryDrinks => 'Bebidas';

  @override
  String get categoryCleaning => 'Limpeza';

  @override
  String get categoryPersonalCare => 'Coidado persoal';

  @override
  String get categoryHome => 'Casa';

  @override
  String get categoryOther => 'Outros';

  @override
  String get invalidQuantityError => 'Cantidade non válida';

  @override
  String get invalidPriceError => 'Prezo non válido';

  @override
  String get invalidNameError => 'Introduce un nome';

  @override
  String unitPriceCalculated(String value) {
    return 'Prezo unitario: $value';
  }

  @override
  String get shoppingTitle => 'Modo de compra';

  @override
  String get summaryPlannedTotal => 'Planificado';

  @override
  String get summaryInCart => 'No carrito';

  @override
  String get summaryRemainingPlan => 'Plan restante';

  @override
  String get summaryProjected => 'Total estimado';

  @override
  String get summaryBudgetRemaining => 'Presuposto restante';

  @override
  String get summaryBudgetOver => 'Supera o presuposto';

  @override
  String itemsProgress(String done, String total) {
    return '$done de $total artigos';
  }

  @override
  String get filterAll => 'Todos';

  @override
  String get filterToBuy => 'Para comprar';

  @override
  String get filterInCart => 'No carrito';

  @override
  String get filterNotFound => 'Non atopado';

  @override
  String get filterRequired => 'Obrigatorio';

  @override
  String get quickEntryTitle => 'Prezo real';

  @override
  String get actualQuantityLabel => 'Cantidade real';

  @override
  String get actualPriceLabel => 'Prezo real';

  @override
  String get discountLabel => 'Descuento (opcional)';

  @override
  String get alternativeNameLabel => 'Nome alternativo do produto (opcional)';

  @override
  String get savePurchaseButton => 'Engadir ao carrito';

  @override
  String get unplannedAddButton => 'Engadir artigo non planificado';

  @override
  String get statusPending => 'Pendente';

  @override
  String get statusInCart => 'No carrito';

  @override
  String get statusNotFound => 'Non atopado';

  @override
  String get statusGaveUp => 'Desistido';

  @override
  String get statusAlternative => 'Alternativa comprada';

  @override
  String get keepScreenAwake => 'Manter a pantalla activa';

  @override
  String get finishShopping => 'Rematar a compra';

  @override
  String get completionWarning =>
      'Hai rexistros faltantes ou sen verificar. Podes rematar; o resultado indicará estes detalles.';

  @override
  String get continueShoppingButton => 'Seguir comprando';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get summarySection => 'Resumo';

  @override
  String get plannedTotalLabel => 'Total planificado';

  @override
  String get actualTotalLabel => 'Total real';

  @override
  String get varianceLabel => 'Diferenza';

  @override
  String get varianceNotComputable => 'Non se pode calcular';

  @override
  String get budgetStatusLabel => 'Presuposto';

  @override
  String get savingsLabel => 'Abaixo do plan';

  @override
  String get overspendLabel => 'Por encima do plan';

  @override
  String get unplannedTotalLabel => 'Total non planificado';

  @override
  String get unpurchasedLabel => 'Planificado pero non comprado';

  @override
  String get totalDiscountLabel => 'Descuentos totais';

  @override
  String get accuracyLabel => 'Precisión da estimación';

  @override
  String get groupsSection => 'Artigos';

  @override
  String get groupPricier => 'Máis caro do previsto';

  @override
  String get groupCheaper => 'Máis barato do previsto';

  @override
  String get groupClose => 'Acerca da estimación';

  @override
  String get groupNotTaken => 'Planificado, non comprado';

  @override
  String get groupUnplanned => 'Comprado sen plan';

  @override
  String get groupQuantityChanged => 'Cantidade cambiada';

  @override
  String get groupUnverified => 'Sen verificar';

  @override
  String get plannedQtyLabel => 'Cantidade planificada';

  @override
  String get actualQtyLabel => 'Cantidade real';

  @override
  String get plannedUnitPriceLabel => 'Prezo unitario planificado';

  @override
  String get actualUnitPriceLabel => 'Prezo unitario real';

  @override
  String get lineVarianceLabel => 'Diferenza na liña';

  @override
  String get discountEffectLabel => 'Efecto do desconto';

  @override
  String get notBoughtMark => 'non comprado';

  @override
  String get noPurchasesNote => 'Non se rexistraron compras.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navLists => 'Listas';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Axustes';

  @override
  String get homeEmptyTitle => 'Planifica a túa compra';

  @override
  String get homeEmptyBody =>
      'Crea a túa primeira lista e compara os custos previstos cos reais.';

  @override
  String get homeActiveSection => 'Listas activas';

  @override
  String get homeCompletedSection => 'Completadas recentemente';

  @override
  String get homeMonthlySection => 'Este mes';

  @override
  String get monthPlannedLabel => 'Previsto';

  @override
  String get monthActualLabel => 'Real';

  @override
  String get monthVarianceLabel => 'Diferenza';

  @override
  String get continueShoppingLabel => 'Continuar a compra';

  @override
  String get historyEmpty =>
      'Aínda non hai compras completadas. O teu historial e as estatísticas aparecerán aquí.';

  @override
  String get aboutTabTitle => 'Sobre NShoptor';

  @override
  String get aboutBody =>
      'NShoptor por Crazy Penguin. Planificador de compras con funcionamento sen conexión. Licenza GPL-3.0.';

  @override
  String get startShoppingLabel => 'Comezar a comprar';

  @override
  String get finishAndSeeResult => 'Rematar e ver resultado';

  @override
  String get settingsTitle => 'Axustes';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageTr => 'Turco';

  @override
  String get languageEn => 'Inglés';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get defaultCurrencyLabel => 'Moeda predeterminada';

  @override
  String get defaultUnitLabel => 'Unidade predeterminada';

  @override
  String get keepAwakeLabel => 'Manter a pantalla activa mentres se compra';

  @override
  String get backupSection => 'Copia de seguridade';

  @override
  String get exportBackupLabel => 'Exportar copia de seguridade';

  @override
  String get importBackupLabel => 'Importar copia de seguridade';

  @override
  String get mergeImportLabel => 'Fusionar cos datos actuais';

  @override
  String get separateImportLabel => 'Importar como unha copia separada';

  @override
  String get importCancelled => 'Importación cancelada.';

  @override
  String get backupExported => 'Copia de seguridade exportada correctamente.';

  @override
  String get deleteAllSection => 'Zona de perigo';

  @override
  String get deleteAllLabel => 'Eliminar todos os datos';

  @override
  String get deleteAllConfirm =>
      'Isto eliminará todas as listas, o historial, as fotos dos recibos e os prezos. Os ficheiros que ti exportaches permanecerán no teu dispositivo. Continuar?';

  @override
  String get deleteAllConfirm2 =>
      'Estás completamente seguro? Esta acción non se pode desfacer.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get confirmDelete => 'Eliminar permanentemente';

  @override
  String get dataDeleted => 'Elimináronse todos os datos locais.';

  @override
  String get privacyInfoLabel => 'Privacidade';

  @override
  String get privacyInfoBody =>
      'As túas listas, prezos, recibos e fotos gárdanse no teu dispositivo. A voz nunca sae del. Cando a axuda de IA está activada, as fotos de recibos e de etiquetas de prezo (reducidas de tamaño) e o texto, como os artigos ditados, envíanse ao noso servidor só para seren lidos; procésanse de inmediato e nunca se almacenan.';

  @override
  String get aboutSection => 'Sobre';

  @override
  String get aboutPublisher => 'Editor: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licenzas (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Entrada por voz';

  @override
  String get voiceStatusUnknown => 'Servizo: non comprobado';

  @override
  String get permissionsLabel => 'Permisos';

  @override
  String get permissionsBody =>
      'A cámara, o micrófono e as notificacións só se solicitan cando usas realmente esas funcións.';

  @override
  String get unitsSection => 'Predeterminados';

  @override
  String get roundingNote =>
      'O redondeo monetario segue unha regra: os semis redóndeanse afastándose de cero, aplicándose unha vez na conversión de diñeiro.';

  @override
  String get voiceInputTitle => 'Entrada por voz';

  @override
  String get voiceStartListening => 'Comezar a escoitar';

  @override
  String get voiceTranscriptLabel => 'Transcrición';

  @override
  String get parseAction => 'Analizar';

  @override
  String get receiptReviewTitle => 'Revisar recibo';

  @override
  String get receiptTotal => 'Total do recibo';

  @override
  String get receiptTotalUnknown => 'Total non detectado';

  @override
  String get receiptDiff => 'Diferenza';

  @override
  String get acceptLine => 'Aceptar liña';

  @override
  String get ignoreLine => 'Ignorar liña';

  @override
  String get receiptLineActions => 'Vincular ao produto, dividir ou ignorar';

  @override
  String get receiptCommit => 'Aceptar todo';

  @override
  String get receiptCommitted => 'Recibo aplicado.';

  @override
  String get priceHistoryTitle => 'Historial de prezos';

  @override
  String get noObservations => 'Aínda non hai observacións de prezos';

  @override
  String get templatesSection => 'Modelos';

  @override
  String get templateHint =>
      'Crear un novo plan a partir dunha compra anterior';

  @override
  String get scanReceiptAction => 'Escanear recibo';

  @override
  String get fromReceiptListButton => 'Desde un recibo';

  @override
  String get shelfLabelAction => 'Prezo da etiqueta do estante';

  @override
  String get priceCandidatesTitle => 'Candidatos a prezo';

  @override
  String get noPriceCandidates =>
      'Non se atopou ningún prezo; insíreo manualmente.';

  @override
  String get voiceUnavailable =>
      'Recoñecemento de voz non dispoñible; insíreo manualmente.';

  @override
  String get linkToItem => 'Vincular ao produto';

  @override
  String get splitLine => 'Dividir en dous';

  @override
  String get mergeWithNext => 'Combinar co seguinte';

  @override
  String get ocrNoText => 'Non se leu texto; téntao de novo.';

  @override
  String get priceHistoryAction => 'Historial de prezos';

  @override
  String get itemsEmptyTitle => 'Aínda non hai produtos';

  @override
  String get itemsEmptyBody =>
      'Engade o teu primeiro produto — aquí introducirás os prezos reais na tenda.';

  @override
  String get addItemTooltip => 'Engadir produto';

  @override
  String get unitAdet => 'ud';

  @override
  String get unitKilogram => 'kg';

  @override
  String get unitGram => 'g';

  @override
  String get unitLitre => 'L';

  @override
  String get unitMililitre => 'ml';

  @override
  String get unitPaket => 'paquete';

  @override
  String get unitKutu => 'caixa';

  @override
  String get unitSise => 'botella';

  @override
  String get unitKavanoz => 'frasco';

  @override
  String get unitDemet => 'mano';

  @override
  String get unitDuzine => 'ducia';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalizado';

  @override
  String get setReminderAction => 'Configurar recordatorio';

  @override
  String get reminderPermissionDenied =>
      'Precísase permiso para as notificacións para os recordatorios. Podes activalo nos axustes do sistema.';

  @override
  String get reminderScheduled => 'Recordatorio configurado.';

  @override
  String get reminderCancelled => 'Recordatorio eliminado.';

  @override
  String get reminderTitle => 'Recordatorio de compras';

  @override
  String reminderBody(Object title) {
    return 'É hora de revisar a túa lista: $title';
  }

  @override
  String get reminderPickDate => 'Escoller unha data';

  @override
  String get reminderPickTime => 'Escoller unha hora';

  @override
  String get itemDetailsSection => 'Detalles';

  @override
  String get priceOptionalHint =>
      'Opcional — introducirás o prezo real na tenda';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Planificado: $total · $count produtos';
  }

  @override
  String get proActiveLabel => 'Pro activo — grazas!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Sen anuncios · Exportación e importación de copias de seguridade · Anual';

  @override
  String get proBenefitNoAds => 'Experiencia sen anuncios';

  @override
  String get proBenefitBackup => 'Copia de seguridade (exportar/importar)';

  @override
  String aboutVersion(Object version) {
    return 'Versión $version';
  }

  @override
  String get navDiscover => 'Descubrir';

  @override
  String get shareAction => 'Compartir a app';

  @override
  String get rateAction => 'Valóranos';

  @override
  String get aboutOpenRow => 'Sobre e código aberto';

  @override
  String get voiceAddItemAction => 'Engadir por voz';

  @override
  String get formatLocaleLabel => 'Formato de número e moeda';

  @override
  String get formatLocaleSystem =>
      'Formato do dispositivo (dígitos latinos; de outro modo, inglés)';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglés (1,234.56)';

  @override
  String get aiToggleTitle => 'Axuda IA';

  @override
  String get aiToggleSubtitle =>
      'Le recibos e etiquetas de prezo a partir de fotos, relaciona recibos e converte frases en listas. As fotos envíanse só para seren lidas e nunca se almacenan.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Usaches as peticións IA deste mes ($used/$limit). Mellora o plan para ter máis, ou continúa sen IA.';
  }

  @override
  String get aiOffline => 'Sen conexión — continuando sen IA.';

  @override
  String get aiFailed =>
      'IA non está dispoñible neste momento — continuando sen ela.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Dispositivo';

  @override
  String get quickListAction => 'Engadir desde unha frase';

  @override
  String get quickListTitle => 'Lista rápida';

  @override
  String get quickListHint =>
      'ex: 1 kg mazás 20, 2 pães, medio quilo de queixo';

  @override
  String get quickListConvert => 'Converter nunha lista';

  @override
  String quickListAdd(int count) {
    return 'Engadir $count elementos';
  }

  @override
  String get quickListEmpty =>
      'Non se atoparon elementos. Tenta listalos separados por comas.';

  @override
  String get receiptAiMatched =>
      'A IA emparellou o recibo coa túa lista. Revisa os enlaces e confirma.';

  @override
  String get receiptNeedsCheck => 'Comproba esta coincidencia';

  @override
  String get receiptDiscountLine => 'Descuento';

  @override
  String get compareItem => 'Elemento';

  @override
  String get compareEstimated => 'Estimado';

  @override
  String get compareActual => 'Real';

  @override
  String get compareDiff => 'Diferenza';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Orzamento';

  @override
  String get compareNotBought => 'non comprado';

  @override
  String get compareUnplanned => 'non planeado';

  @override
  String get pricierItems => 'Custan máis';

  @override
  String get cheaperItems => 'Custan menos';

  @override
  String get compareAction => 'Comparar';

  @override
  String get detailsSection => 'Detalles';

  @override
  String get spendingTitle => 'Gasto';

  @override
  String get spendingAction => 'Gasto';

  @override
  String get spendingMonthTotal => 'Este mes';

  @override
  String get spendingWeekly => 'Gasto semanal';

  @override
  String get spendingMonthly => 'Gasto mensual';

  @override
  String get monthlyLimitTitle => 'Límite mensual';

  @override
  String get monthlyLimitHelp => 'Canto queres gastar en compras ao mes?';

  @override
  String get monthlyLimitRemove => 'Eliminar';

  @override
  String get monthlyLimitSet => 'Establecer';

  @override
  String get monthlyLimitChange => 'Cambiar';

  @override
  String get monthlyLimitNone =>
      'Establece un límite mensual para ver canto che queda.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount por encima do límite';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return '$amount restante este mes';
  }

  @override
  String get plansTitle => 'Planos';

  @override
  String get plansHeadline => 'Compra mellor con IA';

  @override
  String get plansSubhead =>
      'Emparellamento de recibos, etiquetas de prezos e listas desde unha frase. Cancela cando queiras.';

  @override
  String get plansMonthly => 'Mensual';

  @override
  String get plansYearly => 'Anual';

  @override
  String get planFree => 'Gratuído';

  @override
  String get planFreePrice => 'Gratis para sempre';

  @override
  String get planFreeAi => '10 peticións IA ao mes';

  @override
  String get planFreeAds =>
      'Anuncios pequenos en forma de banner (ningún nos primeiros 7 días)';

  @override
  String get planCoreFeatures => 'Listas, prezos, recibos, gráficos de gasto';

  @override
  String get plansPerYear => '/ ano';

  @override
  String get plansPerMonth => '/ mes';

  @override
  String get planTrial => 'Proba gratuíta';

  @override
  String get planProAi => '100 peticións IA ao mes';

  @override
  String get planNoAds => 'Sen anuncios';

  @override
  String get planBackup => 'Exportación e importación de copias de seguridade';

  @override
  String get planMaxAi => '300 solicitudes IA ao mes';

  @override
  String get planMaxFamily => 'Para compras familiares numerosas';

  @override
  String get plansStoreUnavailable => 'A tenda non está accesible no momento.';

  @override
  String get retryAction => 'Reintentar';

  @override
  String get plansPurchaseFailed =>
      'A compra non se completou. Por favor, téntao de novo.';

  @override
  String get plansRestore => 'Restaurar compras';

  @override
  String get plansLegal =>
      'Pro renóvase automaticamente cada ano ata a súa cancelación e inclúe 100 solicitudes de IA ao mes. O prezo base é de 1 dólar estadounidense ao ano antes dos impostos aplicables; comproba o prezo local final e os impostos na tenda antes de confirmar a compra. Xestiona ou cancela a subscrición en Google Play.';

  @override
  String get planCurrent => 'Actual';

  @override
  String get planStartTrial => 'Iniciar proba gratuíta';

  @override
  String get planChoose => 'Escoller';

  @override
  String get plansAction => 'Planos: Pro';

  @override
  String get assistantTitle => 'Asistente';

  @override
  String get assistantGreeting => 'Ola! Que che gustaría facer?';

  @override
  String get assistantNewList => 'Nova lista';

  @override
  String get assistantVoiceList => 'Lista por voz';

  @override
  String get assistantTextList => 'Lista desde unha frase';

  @override
  String get assistantScanReceipt => 'Escanear un recibo';

  @override
  String get assistantSpending => 'Os meus gastos';

  @override
  String get assistantReceiptHint =>
      'Abre a túa lista e toca o icono do recibo para escanealo.';

  @override
  String get assistantToggleTitle => 'Mostrar asistente';

  @override
  String get assistantToggleSubtitle =>
      'O pequeno axudante na esquina inferior dereita';

  @override
  String get scanPriceLabel => 'Escanear etiqueta de prezo';

  @override
  String get saveFailed =>
      'Non se puido gardar. Os teus cambios aínda están aquí. Téntao de novo.';

  @override
  String get deleteItemConfirm =>
      'Eliminar este artigo e as súas compras rexistradas?';

  @override
  String get clearPurchaseConfirm =>
      'Desmarcar este artigo e eliminar as súas compras rexistradas?';

  @override
  String get reportPdfAction => 'Gardar informe en PDF';

  @override
  String get reportNotInvoice =>
      'Resumo da compra, non é unha factura fiscal. As taxas fiscais son descoñecidas.';

  @override
  String get purchaseVisits => 'Visitas de compra';

  @override
  String get purchaseInterval => 'Días medios entre compras';

  @override
  String get purchasedQuantity => 'Cantidade comprada';

  @override
  String get purchaseAnalyticsHint =>
      'As compras non miden o consumo. As moedas e unidades móstranse por separado.';

  @override
  String get receiptReplaces =>
      'Complétanse os artigos sen prezo. Os que xa teñen prezo de mercado engádense como compras separadas.';

  @override
  String get receiptIncompleteHeader =>
      'Inclúe a tenda, a data, a hora e o número do recibo na seguinte foto.';

  @override
  String get receiptIncompleteTail =>
      'Fotografa a seguinte sección con algúns artigos solapados e o total final.';

  @override
  String get receiptContinuationRejected =>
      'Non se puido unir esta foto ao recibo. Fai outra con artigos solapados do mesmo recibo.';

  @override
  String get receiptDraftSaved =>
      'Recibo gardado como borrador. Podes continuar máis tarde.';

  @override
  String get receiptContinueAction => 'Continuar recibo';

  @override
  String get receiptDraftsTitle => 'Recibos sen rematar';

  @override
  String get receiptDuplicate => 'Este recibo xa se engadiu.';

  @override
  String get receiptTotalMismatch =>
      'Os artigos non coinciden co total do recibo. Comproba que se vexa o recibo enteiro.';

  @override
  String get receiptSaveDraftAction => 'Gardar para máis tarde';

  @override
  String get receiptResolveLines =>
      'Acepta ou ignora cada artigo antes de gardar.';

  @override
  String get receiptPartialConfirm =>
      'Só se engadirán os artigos seleccionados. Este recibo marcarase como importado. Queres continuar?';

  @override
  String get voiceUnsupportedLanguage =>
      'Este idioma non está dispoñible para a entrada por voz neste dispositivo. Podes escribir en seu lugar.';

  @override
  String get voiceStopListening => 'Deixa de escoitar';

  @override
  String get keepAwakeFailed =>
      'Non foi posible manter a pantalla activa. Téntao de novo.';

  @override
  String get purchaseHistoryHint =>
      'Todas as compras completadas. As devolucións reducen os totais. As datas refírense á finalización das compras. Unha soa visita non é suficiente para calcular un intervalo medio.';

  @override
  String get planLegacyRights =>
      'As subscricións Pro e Max existentes manteñen a súa asignación mensual orixinal de IA.';

  @override
  String get csvExportAction => 'Exportar CSV';

  @override
  String get reportSharePdf => 'Compartir como PDF';

  @override
  String get reportShareCsv => 'Compartir como CSV';

  @override
  String get reportPrintAction => 'Imprimir';

  @override
  String get backupSizeWarning =>
      'O JSON inclúe rexistros, non ficheiros de fotos. Límite de importación: 16 MB.';

  @override
  String get backupImportFailed =>
      'Non se puido importar esta copia de seguridade. Os teus datos non cambiaron.';

  @override
  String get backupImported => 'Copia de seguridade importada correctamente.';

  @override
  String backupPreviewCounts(Object entries, Object items, Object lists) {
    return '$lists listas · $items artigos · $entries compras';
  }

  @override
  String get voiceModelDownloading =>
      'Estase a descargar o modelo de voz deste idioma. Téntao de novo nun minuto.';

  @override
  String get historyThisWeek => 'Esta semana';

  @override
  String get historyProductsSection => 'Produtos mercados';

  @override
  String get tipReceiptScan =>
      'Dixitaliza o recibo para cotexar os prezos coa túa lista';

  @override
  String get tipVoiceAdd =>
      'Di un ou varios artigos e revísaos antes de engadilos';

  @override
  String get tipShelfCamera =>
      'Le o prezo da etiqueta da estantería coa cámara';

  @override
  String get tipPlan => 'O teu plan: ver detalles, subscribirte ou mellorar';

  @override
  String get guideAddBody =>
      'Toca + para engadir un artigo. Escribe agora o prezo previsto e o prezo de mercado na caixa.';

  @override
  String get guideVoiceBody =>
      'Toca o micrófono e di os artigos, por exemplo: \'1 quilo de mazás, 1 pan\'.';

  @override
  String get guideReceiptBody =>
      'Dixitaliza un recibo para cotexar os seus prezos cos artigos da lista.';

  @override
  String get guidePlanBody =>
      'Toca a icona do plan para ver o plan, subscribirte ou mellorar.';

  @override
  String get guideNext => 'Vale';

  @override
  String get guideDone => 'Comezar';

  @override
  String get paletteLabel => 'Tema de cor';

  @override
  String get paletteForest => 'Bosque';

  @override
  String get paletteOcean => 'Océano';

  @override
  String get paletteSunset => 'Solpor';

  @override
  String get paletteLavender => 'Lavanda';

  @override
  String get darkBlackLabel => 'Negro puro no tema escuro';

  @override
  String get spendingOverview => 'Resumo';

  @override
  String get spendingThisYear => 'Este ano';

  @override
  String get spendingYearly => 'Gasto anual';

  @override
  String get productSpending => 'Gasto por produto';

  @override
  String get spanWeek => 'Semana';

  @override
  String get spanMonth => 'Mes';

  @override
  String get spanYear => 'Ano';

  @override
  String get weeklyLimitTitle => 'Límite semanal';

  @override
  String get weeklyLimitHelp => 'Canto queres gastar na compra cada semana?';

  @override
  String get weeklyLimitNone =>
      'Define un límite semanal para ver canto queda.';

  @override
  String weeklyLimitLeft(String amount) {
    return 'Quedan $amount esta semana';
  }

  @override
  String get shoppingLimitTitle => 'Límite por compra';

  @override
  String get shoppingLimitHelp => 'As listas novas comezan con este orzamento.';

  @override
  String get shoppingLimitNone =>
      'Define un orzamento predeterminado para cada compra nova.';

  @override
  String get monthlyReportAction => 'Informe mensual';

  @override
  String get reportShoppingColumn => 'Compra';

  @override
  String get reportDateColumn => 'Data';

  @override
  String get planUnavailable => 'Agora non está dispoñible na tenda';

  @override
  String get demoDataTitle => 'Datos de exemplo';

  @override
  String get demoDataLoad => 'Probar con datos de exemplo';

  @override
  String get demoDataLoadHelp =>
      'Engade 12 meses de compras de exemplo para ver o historial, os gráficos e o historial de prezos.';

  @override
  String get demoDataRemove => 'Eliminar datos de exemplo';

  @override
  String get demoDataAdded => 'Engadíronse os datos de exemplo';

  @override
  String get demoDataRemoved => 'Elimináronse os datos de exemplo';

  @override
  String get demoProductApple => 'Mazás';

  @override
  String get demoProductBread => 'Pan';

  @override
  String get demoProductMilk => 'Leite';

  @override
  String get demoProductCheese => 'Queixo';

  @override
  String get demoProductTomato => 'Tomates';

  @override
  String get demoProductEggs => 'Ovos';

  @override
  String get demoProductCoffee => 'Café';

  @override
  String get demoProductDetergent => 'Deterxente';

  @override
  String get sendAction => 'Send';

  @override
  String get previousMonthAction => 'Previous month';

  @override
  String get nextMonthAction => 'Next month';

  @override
  String get helpSection => 'Axuda e asistencia';

  @override
  String get howToUseLabel => 'Como se usa';

  @override
  String get guidePricesBody =>
      'O prezo da tenda marca o produto como comprado; 0 tamén conta. O prezo da casa é opcional. Borra o prezo da tenda para quitar a marca.';

  @override
  String get shoppingDateLabel => 'Data da compra';

  @override
  String get shoppingDateNone => 'Non se escolleu ningunha data';

  @override
  String get clearShoppingDateAction => 'Quitar data';

  @override
  String get listSortLabel => 'Orde da lista';

  @override
  String get listSortDate => 'Data da compra';

  @override
  String get listSortAz => 'Nome (A–Z)';

  @override
  String get listSortManual => 'Orde manual';

  @override
  String get imageCameraAction => 'Facer unha foto';

  @override
  String get imageGalleryAction => 'Escoller das fotos';

  @override
  String get imageCaptureFailed =>
      'Non se puido abrir a cámara ou as fotos. Comproba o permiso de acceso e téntao de novo.';

  @override
  String get imageRecognitionFailed =>
      'Non se puido procesar a foto. Proba con outra foto.';

  @override
  String get receiptNoProducts =>
      'Leuse o texto, pero non se atoparon artigos do recibo. Inclúe os artigos e o total na foto.';

  @override
  String get keepAwakeOn => 'A pantalla permanece acendida';

  @override
  String get keepAwakeOff => 'A pantalla pode apagarse';

  @override
  String get spanDay => 'Día';

  @override
  String get spanCustom => 'Intervalo de datas';

  @override
  String get reportTotalSpent => 'Total gastado';

  @override
  String get reportAddedAt => 'Engadido';

  @override
  String get reportReceiptNumber => 'Número de recibo';

  @override
  String get reportPreview => 'Vista previa';

  @override
  String get reportShareAction => 'Compartir';

  @override
  String get previousPeriodAction => 'Período anterior';

  @override
  String get nextPeriodAction => 'Período seguinte';

  @override
  String get reportSaved => 'Informe gardado.';

  @override
  String get reportZoom => 'Ampliar';

  @override
  String planTrialDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days días restantes',
      one: '$days día restante',
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
  String get planTrialEndedTitle => 'Rematou a túa proba de Pro';

  @override
  String get planTrialEndedBody =>
      'Podes seguir usando listas, entrada manual e voz no dispositivo de balde. O plan gratuíto inclúe 10 solicitudes de IA por mes natural. Escolle Pro anual para ter 100 solicitudes de IA ao mes, sen anuncios e con copias de seguridade. Os teus datos seguirán contigo.';

  @override
  String get planContinueFree => 'Continuar gratis';

  @override
  String get supportIdLabel => 'ID de asistencia';

  @override
  String get supportEmailLabel => 'Asistencia por correo electrónico';

  @override
  String get captureTipFirst =>
      'Start at the very top: the store name and date must be visible. Fit as many items as you can; the rest goes in the next photo.';

  @override
  String get captureTipContinue =>
      'Same receipt: include the last item of the previous photo.';

  @override
  String get captureTipNeverShow => 'Don\'t show again';

  @override
  String get captureTipOk => 'Got it';

  @override
  String get captureTipsSetting => 'Show receipt capture tips';
}
