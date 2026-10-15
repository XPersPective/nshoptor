"""Yeni ARB anahtarlarini elle yazilmis cevirilerle tum dillere ekler (ag yok).

  python tool/i18n/add_keys_local.py

Mevcut anahtara dokunmaz; eksik dil ceviriyse hata verir.
"""
import json
import pathlib

ARB = pathlib.Path(__file__).resolve().parents[2] / 'lib/core/l10n'

KEYS = {
    'voiceModelDownloading': {
        'en': 'Downloading the voice model for this language. Try again in a minute.',
        'tr': 'Bu dil için ses modeli indiriliyor. Bir dakika sonra tekrar dene.',
        'af': 'Die stemmodel vir hierdie taal word afgelaai. Probeer oor ’n minuut weer.',
        'ar': 'جارٍ تنزيل نموذج الصوت لهذه اللغة. حاول مرة أخرى بعد دقيقة.',
        'az': 'Bu dil üçün səs modeli yüklənir. Bir dəqiqədən sonra yenidən cəhd edin.',
        'be': 'Галасавая мадэль для гэтай мовы спампоўваецца. Паспрабуйце праз хвіліну.',
        'bg': 'Гласовият модел за този език се изтегля. Опитайте отново след минута.',
        'bn': 'এই ভাষার ভয়েস মডেল ডাউনলোড হচ্ছে। এক মিনিট পরে আবার চেষ্টা করুন।',
        'bs': 'Glasovni model za ovaj jezik se preuzima. Pokušajte ponovo za minutu.',
        'ca': 'S’està baixant el model de veu per a aquesta llengua. Torna-ho a provar d’aquí a un minut.',
        'cs': 'Hlasový model pro tento jazyk se stahuje. Zkuste to znovu za minutu.',
        'da': 'Stemmemodellen til dette sprog downloades. Prøv igen om et minut.',
        'de': 'Das Sprachmodell für diese Sprache wird heruntergeladen. Versuche es in einer Minute erneut.',
        'el': 'Γίνεται λήψη του φωνητικού μοντέλου για αυτή τη γλώσσα. Δοκιμάστε ξανά σε ένα λεπτό.',
        'es': 'Se está descargando el modelo de voz de este idioma. Vuelve a intentarlo en un minuto.',
        'et': 'Selle keele häälmudelit laaditakse alla. Proovi minuti pärast uuesti.',
        'eu': 'Hizkuntza honen ahots-eredua deskargatzen ari da. Saiatu berriro minutu batean.',
        'fa': 'مدل صوتی این زبان در حال دانلود است. یک دقیقه دیگر دوباره امتحان کنید.',
        'fi': 'Tämän kielen puhemallia ladataan. Yritä uudelleen minuutin kuluttua.',
        'fil': 'Dina-download ang voice model para sa wikang ito. Subukang muli pagkalipas ng isang minuto.',
        'fr': 'Le modèle vocal de cette langue est en cours de téléchargement. Réessayez dans une minute.',
        'gl': 'Estase a descargar o modelo de voz deste idioma. Téntao de novo nun minuto.',
        'gu': 'આ ભાષા માટે વૉઇસ મોડેલ ડાઉનલોડ થઈ રહ્યું છે. એક મિનિટ પછી ફરી પ્રયાસ કરો.',
        'he': 'מודל הקול לשפה זו בהורדה. נסו שוב בעוד דקה.',
        'hi': 'इस भाषा का वॉइस मॉडल डाउनलोड हो रहा है। एक मिनट बाद फिर कोशिश करें।',
        'hr': 'Glasovni model za ovaj jezik se preuzima. Pokušajte ponovno za minutu.',
        'hu': 'A nyelv hangmodellje letöltés alatt áll. Próbáld újra egy perc múlva.',
        'hy': 'Այս լեզվի ձայնային մոդելը ներբեռնվում է։ Փորձեք կրկին մեկ րոպեից։',
        'id': 'Model suara untuk bahasa ini sedang diunduh. Coba lagi dalam satu menit.',
        'is': 'Verið er að sækja raddlíkanið fyrir þetta tungumál. Reyndu aftur eftir mínútu.',
        'it': 'Download del modello vocale per questa lingua in corso. Riprova tra un minuto.',
        'ja': 'この言語の音声モデルをダウンロードしています。1 分後にもう一度お試しください。',
        'ka': 'ამ ენის ხმოვანი მოდელი იტვირთება. სცადეთ ერთ წუთში.',
        'kk': 'Бұл тілдің дауыс моделі жүктелуде. Бір минуттан кейін қайталап көріңіз.',
        'kn': 'ಈ ಭಾಷೆಯ ಧ್ವನಿ ಮಾದರಿ ಡೌನ್‌ಲೋಡ್ ಆಗುತ್ತಿದೆ. ಒಂದು ನಿಮಿಷದ ನಂತರ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.',
        'ko': '이 언어의 음성 모델을 다운로드하는 중입니다. 1분 후에 다시 시도하세요.',
        'ky': 'Бул тилдин үн модели жүктөлүүдө. Бир мүнөттөн кийин кайра аракет кылыңыз.',
        'lo': 'ກຳລັງດາວໂຫຼດໂມເດວສຽງສຳລັບພາສານີ້. ລອງໃໝ່ອີກຄັ້ງໃນໜຶ່ງນາທີ.',
        'lt': 'Šios kalbos balso modelis atsisiunčiamas. Bandykite dar kartą po minutės.',
        'lv': 'Šīs valodas balss modelis tiek lejupielādēts. Mēģiniet vēlreiz pēc minūtes.',
        'mk': 'Гласовниот модел за овој јазик се презема. Обидете се повторно за една минута.',
        'ml': 'ഈ ഭാഷയുടെ വോയ്‌സ് മോഡൽ ഡൗൺലോഡ് ചെയ്യുന്നു. ഒരു മിനിറ്റിന് ശേഷം വീണ്ടും ശ്രമിക്കുക.',
        'mn': 'Энэ хэлний дуу хоолойн загварыг татаж байна. Нэг минутын дараа дахин оролдоно уу.',
        'mr': 'या भाषेचे व्हॉइस मॉडेल डाउनलोड होत आहे. एका मिनिटानंतर पुन्हा प्रयत्न करा.',
        'ms': 'Model suara untuk bahasa ini sedang dimuat turun. Cuba lagi dalam seminit.',
        'my': 'ဤဘာသာစကားအတွက် အသံမော်ဒယ်ကို ဒေါင်းလုဒ်လုပ်နေသည်။ တစ်မိနစ်အကြာတွင် ထပ်ကြိုးစားပါ။',
        'ne': 'यस भाषाको भ्वाइस मोडेल डाउनलोड हुँदैछ। एक मिनेटपछि फेरि प्रयास गर्नुहोस्।',
        'nl': 'Het spraakmodel voor deze taal wordt gedownload. Probeer het over een minuut opnieuw.',
        'pa': 'ਇਸ ਭਾਸ਼ਾ ਲਈ ਵੌਇਸ ਮਾਡਲ ਡਾਊਨਲੋਡ ਹੋ ਰਿਹਾ ਹੈ। ਇੱਕ ਮਿੰਟ ਬਾਅਦ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।',
        'pl': 'Trwa pobieranie modelu głosowego dla tego języka. Spróbuj ponownie za minutę.',
        'ps': 'د دې ژبې غږیز ماډل ښکته کېږي. یوه دقیقه وروسته بیا هڅه وکړئ.',
        'pt': 'O modelo de voz deste idioma está sendo baixado. Tente novamente em um minuto.',
        'ro': 'Se descarcă modelul vocal pentru această limbă. Încearcă din nou peste un minut.',
        'ru': 'Загружается голосовая модель для этого языка. Повторите попытку через минуту.',
        'si': 'මෙම භාෂාව සඳහා හඬ ආකෘතිය බාගත වෙමින් පවතී. මිනිත්තුවකින් නැවත උත්සාහ කරන්න.',
        'sk': 'Hlasový model pre tento jazyk sa sťahuje. Skúste to znova o minútu.',
        'sl': 'Glasovni model za ta jezik se prenaša. Poskusite znova čez minuto.',
        'sq': 'Modeli zanor për këtë gjuhë po shkarkohet. Provo përsëri pas një minute.',
        'sr': 'Гласовни модел за овај језик се преузима. Покушајте поново за минут.',
        'sv': 'Röstmodellen för det här språket laddas ned. Försök igen om en minut.',
        'sw': 'Muundo wa sauti wa lugha hii unapakuliwa. Jaribu tena baada ya dakika moja.',
        'ta': 'இந்த மொழிக்கான குரல் மாதிரி பதிவிறக்கப்படுகிறது. ஒரு நிமிடம் கழித்து மீண்டும் முயலவும்.',
        'te': 'ఈ భాష కోసం వాయిస్ మోడల్ డౌన్‌లోడ్ అవుతోంది. ఒక నిమిషం తర్వాత మళ్లీ ప్రయత్నించండి.',
        'th': 'กำลังดาวน์โหลดโมเดลเสียงสำหรับภาษานี้ ลองอีกครั้งในอีกหนึ่งนาที',
        'tl': 'Dina-download ang voice model para sa wikang ito. Subukang muli pagkalipas ng isang minuto.',
        'uk': 'Завантажується голосова модель для цієї мови. Спробуйте ще раз за хвилину.',
        'ur': 'اس زبان کا وائس ماڈل ڈاؤن لوڈ ہو رہا ہے۔ ایک منٹ بعد دوبارہ کوشش کریں۔',
        'uz': 'Bu til uchun ovoz modeli yuklab olinmoqda. Bir daqiqadan so‘ng qayta urinib ko‘ring.',
        'vi': 'Đang tải mô hình giọng nói cho ngôn ngữ này. Hãy thử lại sau một phút.',
        'zh': '正在下载该语言的语音模型，请一分钟后重试。',
        'zu': 'Imodeli yezwi yalolu limi iyalandwa. Zama futhi ngemuva komzuzu owodwa.',
    },
    'historyThisWeek': {'en': 'This week', 'tr': 'Bu hafta', 'af': 'Hierdie week', 'ar': 'هذا الأسبوع', 'az': 'Bu həftə', 'be': 'Гэты тыдзень', 'bg': 'Тази седмица', 'bn': 'এই সপ্তাহ', 'bs': 'Ova sedmica', 'ca': 'Aquesta setmana', 'cs': 'Tento týden', 'da': 'Denne uge', 'de': 'Diese Woche', 'el': 'Αυτή την εβδομάδα', 'es': 'Esta semana', 'et': 'See nädal', 'eu': 'Aste hau', 'fa': 'این هفته', 'fi': 'Tämä viikko', 'fil': 'Ngayong linggo', 'fr': 'Cette semaine', 'gl': 'Esta semana', 'gu': 'આ અઠવાડિયું', 'he': 'השבוע', 'hi': 'इस सप्ताह', 'hr': 'Ovaj tjedan', 'hu': 'Ez a hét', 'hy': 'Այս շաբաթ', 'id': 'Minggu ini', 'is': 'Þessi vika', 'it': 'Questa settimana', 'ja': '今週', 'ka': 'ეს კვირა', 'kk': 'Осы апта', 'kn': 'ಈ ವಾರ', 'ko': '이번 주', 'ky': 'Ушул жума', 'lo': 'ອາທິດນີ້', 'lt': 'Ši savaitė', 'lv': 'Šī nedēļa', 'mk': 'Оваа недела', 'ml': 'ഈ ആഴ്ച', 'mn': 'Энэ долоо хоног', 'mr': 'हा आठवडा', 'ms': 'Minggu ini', 'my': 'ဤအပတ်', 'ne': 'यो हप्ता', 'nl': 'Deze week', 'pa': 'ਇਸ ਹਫ਼ਤੇ', 'pl': 'Ten tydzień', 'ps': 'دا اونۍ', 'pt': 'Esta semana', 'ro': 'Săptămâna aceasta', 'ru': 'Эта неделя', 'si': 'මෙම සතිය', 'sk': 'Tento týždeň', 'sl': 'Ta teden', 'sq': 'Këtë javë', 'sr': 'Ова недеља', 'sv': 'Den här veckan', 'sw': 'Wiki hii', 'ta': 'இந்த வாரம்', 'te': 'ఈ వారం', 'th': 'สัปดาห์นี้', 'tl': 'Ngayong linggo', 'uk': 'Цей тиждень', 'ur': 'اس ہفتے', 'uz': 'Shu hafta', 'vi': 'Tuần này', 'zh': '本周', 'zu': 'Leli sonto'},
    'historyProductsSection': {'en': 'Products bought', 'tr': 'Alınan ürünler', 'af': 'Gekoopte produkte', 'ar': 'المنتجات المشتراة', 'az': 'Alınan məhsullar', 'be': 'Купленыя тавары', 'bg': 'Купени продукти', 'bn': 'কেনা পণ্য', 'bs': 'Kupljeni proizvodi', 'ca': 'Productes comprats', 'cs': 'Koupené produkty', 'da': 'Købte varer', 'de': 'Gekaufte Produkte', 'el': 'Προϊόντα που αγοράστηκαν', 'es': 'Productos comprados', 'et': 'Ostetud tooted', 'eu': 'Erositako produktuak', 'fa': 'محصولات خریداری\u200cشده', 'fi': 'Ostetut tuotteet', 'fil': 'Mga biniling produkto', 'fr': 'Produits achetés', 'gl': 'Produtos mercados', 'gu': 'ખરીદેલા ઉત્પાદનો', 'he': 'מוצרים שנקנו', 'hi': 'खरीदे गए उत्पाद', 'hr': 'Kupljeni proizvodi', 'hu': 'Vásárolt termékek', 'hy': 'Գնված ապրանքներ', 'id': 'Produk yang dibeli', 'is': 'Keyptar vörur', 'it': 'Prodotti acquistati', 'ja': '購入した商品', 'ka': 'ნაყიდი პროდუქტები', 'kk': 'Сатып алынған тауарлар', 'kn': 'ಖರೀದಿಸಿದ ಉತ್ಪನ್ನಗಳು', 'ko': '구매한 상품', 'ky': 'Сатып алынган товарлар', 'lo': 'ສິນຄ້າທີ່ຊື້', 'lt': 'Pirkti produktai', 'lv': 'Nopirktie produkti', 'mk': 'Купени производи', 'ml': 'വാങ്ങിയ ഉൽപ്പന്നങ്ങൾ', 'mn': 'Худалдан авсан бараа', 'mr': 'खरेदी केलेली उत्पादने', 'ms': 'Produk yang dibeli', 'my': 'ဝယ်ယူခဲ့သော ပစ္စည်းများ', 'ne': 'किनिएका उत्पादनहरू', 'nl': 'Gekochte producten', 'pa': 'ਖਰੀਦੇ ਉਤਪਾਦ', 'pl': 'Kupione produkty', 'ps': 'پېرل شوي توکي', 'pt': 'Produtos comprados', 'ro': 'Produse cumpărate', 'ru': 'Купленные товары', 'si': 'මිලදී ගත් නිෂ්පාදන', 'sk': 'Kúpené produkty', 'sl': 'Kupljeni izdelki', 'sq': 'Produktet e blera', 'sr': 'Купљени производи', 'sv': 'Köpta varor', 'sw': 'Bidhaa zilizonunuliwa', 'ta': 'வாங்கிய பொருட்கள்', 'te': 'కొనుగోలు చేసిన ఉత్పత్తులు', 'th': 'สินค้าที่ซื้อ', 'tl': 'Mga biniling produkto', 'uk': 'Куплені товари', 'ur': 'خریدی گئی مصنوعات', 'uz': 'Sotib olingan mahsulotlar', 'vi': 'Sản phẩm đã mua', 'zh': '已购商品', 'zu': 'Imikhiqizo ethengiwe'},
}


def main():
    codes = sorted(p.stem[4:] for p in ARB.glob('app_*.arb'))
    for key, values in KEYS.items():
        missing = [c for c in codes if c not in values]
        if missing:
            raise SystemExit(f'{key}: missing {missing}')
        for code in codes:
            f = ARB / f'app_{code}.arb'
            d = json.loads(f.read_text(encoding='utf8'))
            if key in d:
                continue
            d[key] = values[code]
            f.write_text(json.dumps(d, ensure_ascii=False, indent=2) + '\n', encoding='utf8')


if __name__ == '__main__':
    main()
