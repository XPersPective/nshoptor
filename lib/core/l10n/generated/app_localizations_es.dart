// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'NShoptor';

  @override
  String get slogan => 'Planifica en casa. Compra según lo previsto.';

  @override
  String get listsTitle => 'Listas';

  @override
  String get listsTabActive => 'Activas';

  @override
  String get listsTabCompleted => 'Completadas';

  @override
  String get listsTabArchived => 'Archivadas';

  @override
  String get newListButton => 'Nueva lista';

  @override
  String get listTitleHint => 'Título (opcional)';

  @override
  String get saveButton => 'Guardar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get editAction => 'Editar';

  @override
  String get listDeleted => 'Lista eliminada';

  @override
  String get invalidAmountError => 'Importe no válido';

  @override
  String get duplicateAction => 'Duplicar';

  @override
  String get archiveAction => 'Archivar';

  @override
  String get unarchiveAction => 'Desarchivar';

  @override
  String get deleteListConfirm =>
      '¿Eliminar esta lista? También se quitarán sus artículos previstos.';

  @override
  String get undoButton => 'Deshacer';

  @override
  String get searchListHint => 'Buscar listas';

  @override
  String get currencyLabel => 'Moneda';

  @override
  String get budgetLabel => 'Presupuesto (opcional)';

  @override
  String get noteLabel => 'Nota (opcional)';

  @override
  String get storeLabel => 'Tienda';

  @override
  String get keepAmountsAction => 'Mantener importes';

  @override
  String get resetAmountsAction => 'Restablecer importes';

  @override
  String get currencyChangeWarning =>
      'La moneda va a cambiar. ¿Qué hacemos con los importes existentes?';

  @override
  String get listsEmpty => 'Aún no hay listas. Crea tu primer plan de compras.';

  @override
  String get statusDraft => 'Borrador';

  @override
  String get statusPlanned => 'Prevista';

  @override
  String get statusShopping => 'Comprando';

  @override
  String get statusCompleted => 'Completada';

  @override
  String get statusArchived => 'Archivada';

  @override
  String autoListTitle(String date) {
    return 'Compra del $date';
  }

  @override
  String get itemFormTitle => 'Añadir artículo';

  @override
  String get itemNameLabel => 'Nombre del artículo';

  @override
  String get brandLabel => 'Marca / variante (opcional)';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get unitLabel => 'Unidad';

  @override
  String get pricingModeLabel => 'Entrada de precio';

  @override
  String get pricingModeUnitPrice => 'Precio unitario';

  @override
  String get pricingModeLineTotal => 'Precio total';

  @override
  String get plannedPriceLabel => 'Precio previsto';

  @override
  String lineTotalCalculated(String value) {
    return 'Total: $value';
  }

  @override
  String get requiredItemToggle => 'Artículo imprescindible';

  @override
  String get maxPriceLabel => 'Precio máximo aceptable (opcional)';

  @override
  String get itemNoteLabel => 'Nota (opcional)';

  @override
  String get categoryProduce => 'Frutas y verduras';

  @override
  String get categoryDairy => 'Lácteos';

  @override
  String get categoryMeat => 'Carne';

  @override
  String get categoryBakery => 'Panadería';

  @override
  String get categoryDrinks => 'Bebidas';

  @override
  String get categoryCleaning => 'Limpieza';

  @override
  String get categoryPersonalCare => 'Cuidado personal';

  @override
  String get categoryHome => 'Hogar';

  @override
  String get categoryOther => 'Otros';

  @override
  String get invalidQuantityError => 'Cantidad no válida';

  @override
  String get invalidPriceError => 'Precio no válido';

  @override
  String get invalidNameError => 'Escribe un nombre';

  @override
  String unitPriceCalculated(String value) {
    return 'Precio unitario: $value';
  }

  @override
  String get shoppingTitle => 'Modo compra';

  @override
  String get summaryPlannedTotal => 'Previsto';

  @override
  String get summaryInCart => 'En el carrito';

  @override
  String get summaryRemainingPlan => 'Resto del plan';

  @override
  String get summaryProjected => 'Caja estimada';

  @override
  String get summaryBudgetRemaining => 'Presupuesto restante';

  @override
  String get summaryBudgetOver => 'Presupuesto superado';

  @override
  String itemsProgress(String done, String total) {
    return '$done de $total artículos';
  }

  @override
  String get filterAll => 'Todos';

  @override
  String get filterToBuy => 'Por comprar';

  @override
  String get filterInCart => 'En el carrito';

  @override
  String get filterNotFound => 'No encontrado';

  @override
  String get filterRequired => 'Imprescindible';

  @override
  String get quickEntryTitle => 'Precio real';

  @override
  String get actualQuantityLabel => 'Cantidad real';

  @override
  String get actualPriceLabel => 'Precio real';

  @override
  String get discountLabel => 'Descuento (opcional)';

  @override
  String get alternativeNameLabel =>
      'Nombre del producto alternativo (opcional)';

  @override
  String get savePurchaseButton => 'Añadir al carrito';

  @override
  String get unplannedAddButton => 'Añadir artículo no previsto';

  @override
  String get statusPending => 'Sin coger';

  @override
  String get statusInCart => 'En el carrito';

  @override
  String get statusNotFound => 'No encontrado';

  @override
  String get statusGaveUp => 'Descartado';

  @override
  String get statusAlternative => 'Alternativa comprada';

  @override
  String get keepScreenAwake => 'Mantener pantalla encendida';

  @override
  String get finishShopping => 'Terminar la compra';

  @override
  String get completionWarning =>
      'Hay registros que faltan o no están verificados. Puedes terminar igualmente; el resultado lo indicará.';

  @override
  String get continueShoppingButton => 'Seguir comprando';

  @override
  String get resultTitle => 'Resultado';

  @override
  String get summarySection => 'Resumen';

  @override
  String get plannedTotalLabel => 'Total previsto';

  @override
  String get actualTotalLabel => 'Total real';

  @override
  String get varianceLabel => 'Diferencia';

  @override
  String get varianceNotComputable => 'No se puede calcular';

  @override
  String get budgetStatusLabel => 'Presupuesto';

  @override
  String get savingsLabel => 'Por debajo del plan';

  @override
  String get overspendLabel => 'Por encima del plan';

  @override
  String get unplannedTotalLabel => 'Total no previsto';

  @override
  String get unpurchasedLabel => 'Previsto pero no comprado';

  @override
  String get totalDiscountLabel => 'Descuentos totales';

  @override
  String get accuracyLabel => 'Precisión de la estimación';

  @override
  String get groupsSection => 'Artículos';

  @override
  String get groupPricier => 'Más caro de lo previsto';

  @override
  String get groupCheaper => 'Más barato de lo previsto';

  @override
  String get groupClose => 'Cerca de lo estimado';

  @override
  String get groupNotTaken => 'Previsto, no comprado';

  @override
  String get groupUnplanned => 'Comprado sin plan';

  @override
  String get groupQuantityChanged => 'Cantidad cambiada';

  @override
  String get groupUnverified => 'Sin verificar';

  @override
  String get plannedQtyLabel => 'Cantidad prevista';

  @override
  String get actualQtyLabel => 'Cantidad real';

  @override
  String get plannedUnitPriceLabel => 'Precio unitario previsto';

  @override
  String get actualUnitPriceLabel => 'Precio unitario real';

  @override
  String get lineVarianceLabel => 'Diferencia';

  @override
  String get discountEffectLabel => 'Efecto del descuento';

  @override
  String get notBoughtMark => 'no comprado';

  @override
  String get noPurchasesNote => 'No se registraron compras.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navLists => 'Listas';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get homeEmptyTitle => 'Planifica tu compra';

  @override
  String get homeEmptyBody =>
      'Crea tu primera lista y compara lo previsto con lo real.';

  @override
  String get homeActiveSection => 'Listas activas';

  @override
  String get homeCompletedSection => 'Completadas recientemente';

  @override
  String get homeMonthlySection => 'Este mes';

  @override
  String get monthPlannedLabel => 'Previsto';

  @override
  String get monthActualLabel => 'Real';

  @override
  String get monthVarianceLabel => 'Diferencia';

  @override
  String get continueShoppingLabel => 'Seguir comprando';

  @override
  String get historyEmpty =>
      'Aún no hay compras completadas. Tu historial y tus análisis aparecerán aquí.';

  @override
  String get aboutTabTitle => 'Acerca de NShoptor';

  @override
  String get aboutBody =>
      'NShoptor de Crazy Penguin. Planificador de compras que funciona sin conexión. Con licencia GPL-3.0.';

  @override
  String get startShoppingLabel => 'Empezar la compra';

  @override
  String get finishAndSeeResult => 'Terminar y ver el resultado';

  @override
  String get settingsTitle => 'Ajustes';

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
  String get themeDark => 'Oscuro';

  @override
  String get defaultCurrencyLabel => 'Moneda predeterminada';

  @override
  String get defaultUnitLabel => 'Unidad predeterminada';

  @override
  String get keepAwakeLabel => 'Mantener la pantalla encendida al comprar';

  @override
  String get backupSection => 'Copia de seguridad';

  @override
  String get exportBackupLabel => 'Exportar copia';

  @override
  String get importBackupLabel => 'Importar copia';

  @override
  String get mergeImportLabel => 'Combinar con los datos actuales';

  @override
  String get separateImportLabel => 'Importar como copia aparte';

  @override
  String get importCancelled => 'Importación cancelada.';

  @override
  String get backupExported => 'Copia exportada correctamente.';

  @override
  String get backupSizeWarning =>
      'Copia grande: el archivo puede ocupar mucho. ¿Incluir también las fotos?';

  @override
  String get deleteAllSection => 'Zona de peligro';

  @override
  String get deleteAllLabel => 'Eliminar todos los datos';

  @override
  String get deleteAllConfirm =>
      'Se eliminarán todas las listas, el historial, las fotos de tickets y los precios. Los archivos que exportaste se conservan. ¿Continuar?';

  @override
  String get deleteAllConfirm2 =>
      '¿Seguro del todo? Esta acción no se puede deshacer.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get confirmDelete => 'Eliminar definitivamente';

  @override
  String get dataDeleted => 'Se eliminaron todos los datos locales.';

  @override
  String get privacyInfoLabel => 'Privacidad';

  @override
  String get privacyInfoBody =>
      'Tus listas, precios, tickets y fotos se quedan en tu dispositivo. Las fotos y la voz nunca salen de él. Con la ayuda de IA activada, solo se envía texto (por ejemplo líneas del ticket o lo que dictaste) a nuestro servidor para procesarlo, sin guardarlo.';

  @override
  String get aboutSection => 'Acerca de';

  @override
  String get aboutPublisher => 'Editor: Crazy Penguin';

  @override
  String get aboutLicenses => 'Licencias (GPL-3.0)';

  @override
  String get voiceSettingsLabel => 'Entrada de voz';

  @override
  String get voiceStatusUnknown => 'Servicio: sin comprobar';

  @override
  String get permissionsLabel => 'Permisos';

  @override
  String get permissionsBody =>
      'La cámara, el micrófono y las notificaciones solo se piden cuando usas esas funciones.';

  @override
  String get unitsSection => 'Predeterminados';

  @override
  String get roundingNote =>
      'El dinero se redondea con una sola regla: las mitades se alejan de cero, una vez al convertir.';

  @override
  String get voiceInputTitle => 'Entrada de voz';

  @override
  String get voiceStartListening => 'Empezar a escuchar';

  @override
  String get voiceTranscriptLabel => 'Transcripción';

  @override
  String get parseAction => 'Analizar';

  @override
  String get receiptReviewTitle => 'Revisar ticket';

  @override
  String get receiptTotal => 'Total del ticket';

  @override
  String get receiptTotalUnknown => 'Total no detectado';

  @override
  String get receiptDiff => 'Diferencia';

  @override
  String get acceptLine => 'Aceptar línea';

  @override
  String get ignoreLine => 'Ignorar línea';

  @override
  String get receiptLineActions => 'Vincular a un artículo, dividir o ignorar';

  @override
  String get receiptCommit => 'Aceptar todo';

  @override
  String get receiptCommitted => 'Ticket aplicado.';

  @override
  String get priceHistoryTitle => 'Historial de precios';

  @override
  String get noObservations => 'Aún no hay precios registrados';

  @override
  String get templatesSection => 'Plantillas';

  @override
  String get templateHint =>
      'Crea un plan nuevo a partir de una compra anterior';

  @override
  String get scanReceiptAction => 'Escanear ticket';

  @override
  String get shelfLabelAction => 'Precio de la etiqueta';

  @override
  String get priceCandidatesTitle => 'Precios sugeridos';

  @override
  String get noPriceCandidates =>
      'No se encontró ningún precio; introdúcelo a mano.';

  @override
  String get voiceUnavailable =>
      'Reconocimiento de voz no disponible; introdúcelo a mano.';

  @override
  String get linkToItem => 'Vincular a un artículo';

  @override
  String get splitLine => 'Dividir en dos';

  @override
  String get mergeWithNext => 'Unir con la siguiente';

  @override
  String get ocrNoText => 'No se leyó texto; inténtalo de nuevo.';

  @override
  String get priceHistoryAction => 'Historial de precios';

  @override
  String get itemsEmptyTitle => 'Aún no hay artículos';

  @override
  String get itemsEmptyBody =>
      'Añade tu primer artículo: en la tienda introducirás aquí los precios reales.';

  @override
  String get addItemTooltip => 'Añadir artículo';

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
  String get unitKutu => 'caja';

  @override
  String get unitSise => 'botella';

  @override
  String get unitKavanoz => 'tarro';

  @override
  String get unitDemet => 'manojo';

  @override
  String get unitDuzine => 'docena';

  @override
  String get unitMetre => 'm';

  @override
  String get unitCustom => 'Personalizada';

  @override
  String get setReminderAction => 'Poner recordatorio';

  @override
  String get reminderPermissionDenied =>
      'Para los recordatorios hace falta permiso de notificaciones. Puedes activarlo en los ajustes del sistema.';

  @override
  String get reminderScheduled => 'Recordatorio programado.';

  @override
  String get reminderCancelled => 'Recordatorio eliminado.';

  @override
  String get reminderTitle => 'Recordatorio de compra';

  @override
  String reminderBody(Object title) {
    return 'Es hora de revisar tu lista: $title';
  }

  @override
  String get reminderPickDate => 'Elige una fecha';

  @override
  String get reminderPickTime => 'Elige una hora';

  @override
  String get itemDetailsSection => 'Detalles';

  @override
  String get priceOptionalHint =>
      'Opcional: el precio real lo pondrás en la tienda';

  @override
  String plannedTotalSummary(Object count, Object total) {
    return 'Previsto: $total · $count artículos';
  }

  @override
  String get proActiveLabel => 'Pro activo: ¡gracias!';

  @override
  String get proBuyLabel => 'NShoptor Pro';

  @override
  String get proBenefitsLine =>
      'Sin anuncios, más IA, copia de seguridad · desde un pequeño precio mensual';

  @override
  String get proBenefitNoAds => 'Sin anuncios';

  @override
  String get proBenefitBackup => 'Copia de seguridad (exportar/importar)';

  @override
  String aboutVersion(Object version) {
    return 'Versión $version';
  }

  @override
  String get navDiscover => 'Descubrir';

  @override
  String get shareAction => 'Compartir la app';

  @override
  String get rateAction => 'Valorar';

  @override
  String get aboutOpenRow => 'Acerca de y código abierto';

  @override
  String get voiceAddItemAction => 'Añadir por voz';

  @override
  String get formatLocaleLabel => 'Formato de números y moneda';

  @override
  String get formatLocaleSystem =>
      'Formato del dispositivo (dígitos latinos; de lo contrario, inglés)';

  @override
  String get formatLocaleTr => 'Turco (1.234,56)';

  @override
  String get formatLocaleEn => 'Inglés (1,234.56)';

  @override
  String get aiToggleTitle => 'Ayuda de IA';

  @override
  String get aiToggleSubtitle =>
      'Empareja tickets, lee etiquetas de precio y convierte frases en listas. Las fotos y la voz se quedan en el dispositivo; solo se procesa texto.';

  @override
  String aiQuotaReached(int used, int limit) {
    return 'Has usado las solicitudes de IA de este mes ($used/$limit). Mejora tu plan para tener más o sigue sin IA.';
  }

  @override
  String get aiOffline => 'Sin conexión: seguimos sin IA.';

  @override
  String get aiFailed => 'La IA no está disponible ahora: seguimos sin ella.';

  @override
  String get aiSourceLabel => 'IA';

  @override
  String get deviceSourceLabel => 'Dispositivo';

  @override
  String get quickListAction => 'Añadir desde una frase';

  @override
  String get quickListTitle => 'Lista rápida';

  @override
  String get quickListHint =>
      'p. ej. 1 kg de manzanas 3 €, 2 barras de pan, medio kilo de queso';

  @override
  String get quickListConvert => 'Convertir en lista';

  @override
  String quickListAdd(int count) {
    return 'Añadir $count artículos';
  }

  @override
  String get quickListEmpty =>
      'No se encontraron artículos. Sepáralos con comas.';

  @override
  String get receiptAiMatched =>
      'La IA emparejó el ticket con tu lista. Revisa los vínculos y confirma.';

  @override
  String get receiptNeedsCheck => 'Revisa este emparejamiento';

  @override
  String get receiptDiscountLine => 'Descuento';

  @override
  String get compareItem => 'Artículo';

  @override
  String get compareEstimated => 'Estimado';

  @override
  String get compareActual => 'Real';

  @override
  String get compareDiff => 'Diferencia';

  @override
  String get compareTotal => 'Total';

  @override
  String get compareBudget => 'Presupuesto';

  @override
  String get compareNotBought => 'no comprado';

  @override
  String get compareUnplanned => 'no previsto';

  @override
  String get pricierItems => 'Más caros';

  @override
  String get cheaperItems => 'Más baratos';

  @override
  String get compareAction => 'Comparar';

  @override
  String get detailsSection => 'Detalles';

  @override
  String get spendingTitle => 'Gastos';

  @override
  String get spendingAction => 'Gastos';

  @override
  String get spendingMonthTotal => 'Este mes';

  @override
  String get spendingWeekly => 'Gasto semanal';

  @override
  String get spendingMonthly => 'Gasto mensual';

  @override
  String get monthlyLimitTitle => 'Límite mensual';

  @override
  String get monthlyLimitHelp => '¿Cuánto quieres gastar en compras al mes?';

  @override
  String get monthlyLimitRemove => 'Quitar';

  @override
  String get monthlyLimitSet => 'Fijar';

  @override
  String get monthlyLimitChange => 'Cambiar';

  @override
  String get monthlyLimitNone =>
      'Fija un límite mensual para ver cuánto te queda.';

  @override
  String monthlyLimitOver(String amount) {
    return '$amount por encima del límite';
  }

  @override
  String monthlyLimitLeft(String amount) {
    return 'Te quedan $amount este mes';
  }

  @override
  String get plansTitle => 'Planes';

  @override
  String get plansHeadline => 'Compra mejor con IA';

  @override
  String get plansSubhead =>
      'Emparejado de tickets, etiquetas de precio y listas desde una frase. Cancela cuando quieras.';

  @override
  String get plansMonthly => 'Mensual';

  @override
  String get plansYearly => 'Anual';

  @override
  String get planFree => 'Gratis';

  @override
  String get planFreePrice => 'Gratis para siempre';

  @override
  String get planFreeAi => '15 solicitudes de IA al mes';

  @override
  String get planFreeAds =>
      'Pequeños anuncios de banner (ninguno los primeros 7 días)';

  @override
  String get planCoreFeatures => 'Listas, precios, tickets, gráficos de gasto';

  @override
  String get plansPerYear => '/ año';

  @override
  String get plansPerMonth => '/ mes';

  @override
  String get planTrial => '7 días gratis';

  @override
  String get planProAi => '200 solicitudes de IA al mes';

  @override
  String get planNoAds => 'Sin anuncios';

  @override
  String get planBackup => 'Exportar e importar copias';

  @override
  String get planMaxAi => '1000 solicitudes de IA al mes';

  @override
  String get planMaxFamily => 'Para grandes compras familiares';

  @override
  String get plansStoreUnavailable =>
      'No se puede acceder a la tienda ahora mismo.';

  @override
  String get retryAction => 'Reintentar';

  @override
  String get plansPurchaseFailed =>
      'La compra no se completó. Inténtalo de nuevo.';

  @override
  String get planLifetimeTitle => 'Sin anuncios para siempre';

  @override
  String get planLifetimeSubtitle =>
      'Pago único: sin anuncios y copia de seguridad; la IA sigue con el cupo gratuito';

  @override
  String get plansRestore => 'Restaurar compras';

  @override
  String get plansLegal =>
      'Las suscripciones se renuevan automáticamente hasta que las canceles. Cancela cuando quieras en Google Play › Pagos y suscripciones. Los precios incluyen los impuestos que muestra Google Play.';

  @override
  String get planCurrent => 'Actual';

  @override
  String get planStartTrial => 'Prueba gratis 7 días';

  @override
  String get planChoose => 'Elegir';

  @override
  String get plansAction => 'Planes: Pro y Max';

  @override
  String get assistantTitle => 'Asistente';

  @override
  String get assistantGreeting => '¡Hola! ¿Qué quieres hacer?';

  @override
  String get assistantNewList => 'Nueva lista';

  @override
  String get assistantVoiceList => 'Lista por voz';

  @override
  String get assistantTextList => 'Lista desde una frase';

  @override
  String get assistantScanReceipt => 'Escanear un ticket';

  @override
  String get assistantSpending => 'Mis gastos';

  @override
  String get assistantReceiptHint =>
      'Abre tu lista y toca el icono del ticket para escanearlo.';

  @override
  String get assistantToggleTitle => 'Mostrar asistente';

  @override
  String get assistantToggleSubtitle =>
      'El pequeño ayudante de abajo a la derecha';

  @override
  String get scanPriceLabel => 'Escanear etiqueta de precio';

  @override
  String get saveFailed =>
      'No se pudo guardar. Tus cambios siguen aquí. Inténtalo de nuevo.';

  @override
  String get deleteItemConfirm =>
      '¿Eliminar este artículo y sus compras registradas?';

  @override
  String get clearPurchaseConfirm =>
      '¿Desmarcar este artículo y eliminar sus compras registradas?';

  @override
  String get reportPdfAction => 'Guardar informe en PDF';

  @override
  String get reportNotInvoice =>
      'Resumen de la compra, no es una factura fiscal. Las tasas impositivas son desconocidas.';

  @override
  String get purchaseVisits => 'Visitas de compra';

  @override
  String get purchaseInterval => 'Días promedio entre compras';

  @override
  String get purchasedQuantity => 'Cantidad comprada';

  @override
  String get purchaseAnalyticsHint =>
      'Las compras no miden el consumo. Las monedas y las unidades se muestran por separado.';

  @override
  String get receiptReplaces =>
      'Las líneas del recibo vinculado reemplazan las compras existentes; las líneas no vinculadas se agregan.';

  @override
  String get voiceUnsupportedLanguage =>
      'Este idioma no está disponible para entrada por voz en este dispositivo. Puedes escribir en su lugar.';
}
