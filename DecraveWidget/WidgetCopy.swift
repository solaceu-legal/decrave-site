import Foundation

/// Widget copy follows the language selected in the app. The widget cannot
/// import the app target's Strings type, so keep this small set here.
enum WidgetCopy {
    private static let appGroupID = "group.com.xhwang.SlipEasy"
    private static let languageKey = "appLanguageCode"

    static var languageCode: String {
        let selected = UserDefaults(suiteName: appGroupID)?.string(forKey: languageKey) ?? "en"
        if selected != "system" { return selected }
        let language = Locale.current.language.languageCode?.identifier ?? "en"
        if language == "zh" {
            let script = Locale.current.language.script?.identifier
            let region = Locale.current.region?.identifier
            return script == "Hant" || (script == nil && ["TW", "HK", "MO"].contains(region ?? ""))
                ? "zh-Hant" : "zh-Hans"
        }
        return language == "pt" ? "pt-BR" : language
    }

    // tap, today's move, craving hint, completed, action tag, widget description,
    // then the title/body pairs for the three rotating quests.
    private static let copies: [String: [String]] = [
        "en": ["Tap to open", "TODAY'S MOVE", "When a craving hits", "Done ✓", "ONE SMALL STEP", "Open SOS when you feel like smoking.", "Practice SOS", "Try a short exercise while things are calm.", "Notice a craving", "Use SOS once today and note what happened.", "Spot a trigger", "Notice what set it off, then choose what to do."],
        "zh-Hans": ["点按打开", "今天试试", "想抽时随时打开", "已完成 ✓", "先做一件小事", "想抽时，从主屏幕打开 SOS。", "练习一下 SOS", "趁现在平静，试一次简短练习。", "记录一次想抽", "今天用一次 SOS，记下当时的情况。", "留意诱因", "想想是什么让你想抽，再选一种应对方式。"],
        "zh-Hant": ["點按開啟", "今天試試", "想抽時隨時開啟", "已完成 ✓", "先做一件小事", "想抽時，從主畫面開啟 SOS。", "練習一下 SOS", "趁現在平靜，試一次簡短練習。", "記錄一次想抽", "今天用一次 SOS，記下當時的情況。", "留意誘因", "想想是什麼讓你想抽，再選一種應對方式。"],
        "de": ["Zum Öffnen tippen", "HEUTE", "Wenn du rauchen möchtest", "Erledigt ✓", "EIN KLEINER SCHRITT", "Öffne SOS direkt vom Home-Bildschirm.", "SOS in Ruhe ausprobieren", "Übe kurz, solange das Verlangen noch nicht da ist.", "Einen Moment festhalten", "Nutze SOS heute einmal und notiere, was passiert ist.", "Auslöser erkennen", "Was hat das Verlangen geweckt? Überlege, was dir hilft."],
        "fr": ["Toucher pour ouvrir", "À FAIRE AUJOURD’HUI", "Quand l’envie arrive", "Terminé ✓", "UN PETIT PAS", "Ouvre SOS depuis l’écran d’accueil quand l’envie arrive.", "Essayer SOS à tête reposée", "Teste un exercice court avant d’en avoir besoin.", "Noter une envie", "Utilise SOS une fois aujourd’hui et note ce qui s’est passé.", "Repérer un déclencheur", "Qu’est-ce qui a donné envie de fumer ? Choisis quoi faire ensuite."],
        "it": ["Tocca per aprire", "OGGI", "Quando arriva la voglia", "Fatto ✓", "UN PICCOLO PASSO", "Apri SOS dalla schermata Home quando arriva la voglia.", "Prova SOS con calma", "Fai un esercizio breve prima di averne bisogno.", "Annota una voglia", "Usa SOS una volta oggi e annota com’è andata.", "Riconosci una causa", "Che cosa ti ha fatto venire voglia di fumare? Scegli come reagire."],
        "es": ["Toca para abrir", "PARA HOY", "Cuando te entren ganas", "Hecho ✓", "UN PEQUEÑO PASO", "Abre SOS desde la pantalla de inicio cuando te entren ganas.", "Prueba SOS con calma", "Haz un ejercicio breve antes de necesitarlo.", "Anota un momento", "Usa SOS una vez hoy y anota qué pasó.", "Reconoce una situación", "Piensa qué te dio ganas de fumar y qué puedes hacer."],
        "pt-BR": ["Toque para abrir", "PARA HOJE", "Quando der vontade", "Feito ✓", "UM PASSO DE CADA VEZ", "Abra o SOS na tela inicial quando der vontade de fumar.", "Experimente o SOS", "Faça um exercício curto antes de precisar dele.", "Anote uma vontade", "Use o SOS uma vez hoje e registre como foi.", "Perceba o gatilho", "Veja o que deu vontade de fumar e escolha o que fazer."],
        "ja": ["タップして開く", "今日やってみること", "吸いたくなったら", "完了 ✓", "まずはひとつ", "吸いたくなったらホーム画面からSOSを開けます。", "落ち着いているときにSOS", "必要になる前に、短い練習をしてみましょう。", "吸いたくなった時を記録", "今日はSOSを一度使い、そのときのことを残しましょう。", "きっかけに気づく", "何がきっかけで吸いたくなったか、次にどうするか考えましょう。"],
        "ko": ["탭하여 열기", "오늘 해 볼 일", "담배 생각이 날 때", "완료 ✓", "작은 실천 하나", "담배 생각이 날 때 홈 화면에서 SOS를 열어 보세요.", "SOS 미리 연습하기", "마음이 편할 때 짧은 연습을 해 보세요.", "흡연 욕구 기록하기", "오늘 SOS를 한 번 쓰고 어떤 일이 있었는지 기록해요.", "계기 알아보기", "무엇 때문에 담배 생각이 났는지 살펴보고 대처법을 골라요."]
    ]

    private static func value(_ index: Int) -> String {
        (copies[languageCode] ?? copies["en"]!)[index]
    }

    static var tapToOpen: String { value(0) }
    static var today: String { value(1) }
    static var whenCravingHits: String { value(2) }
    static var completed: String { value(3) }
    static var oneStep: String { value(4) }
    static var description: String { value(5) }

    static func questTitle(kind: String) -> String {
        value(kind == "practice_tool" ? 6 : kind == "capture_craving" ? 8 : 10)
    }

    static func questBody(kind: String) -> String {
        value(kind == "practice_tool" ? 7 : kind == "capture_craving" ? 9 : 11)
    }

    static func triggerLabel(raw: String) -> String? {
        let order = ["coffee", "meal", "stress", "alcohol", "breakTime", "boredom", "other"]
        guard let index = order.firstIndex(of: raw) else { return nil }
        let names: [String: [String]] = [
            "en": ["Coffee", "After a meal", "Stress", "Alcohol", "Break", "Boredom", "Other"],
            "zh-Hans": ["咖啡", "饭后", "压力", "酒后", "休息时", "无聊", "其他"],
            "zh-Hant": ["咖啡", "飯後", "壓力", "酒後", "休息時", "無聊", "其他"],
            "de": ["Kaffee", "Nach dem Essen", "Stress", "Alkohol", "Pause", "Langeweile", "Sonstiges"],
            "fr": ["Café", "Après un repas", "Stress", "Alcool", "Pause", "Ennui", "Autre"],
            "it": ["Caffè", "Dopo un pasto", "Stress", "Alcol", "Pausa", "Noia", "Altro"],
            "es": ["Café", "Después de comer", "Estrés", "Alcohol", "Descanso", "Aburrimiento", "Otro"],
            "pt-BR": ["Café", "Depois de comer", "Estresse", "Álcool", "Pausa", "Tédio", "Outro"],
            "ja": ["コーヒー", "食後", "ストレス", "飲酒", "休憩", "退屈", "その他"],
            "ko": ["커피", "식사 후", "스트레스", "술자리", "휴식", "지루함", "기타"]
        ]
        return (names[languageCode] ?? names["en"]!)[index]
    }

    static func radar(weekday: String, hour: String, trigger: String?) -> String {
        let time: String = switch languageCode {
        case "zh-Hans": "常见时段：\(weekday) \(hour)左右"
        case "zh-Hant": "常見時段：\(weekday) \(hour)左右"
        case "de": "Oft \(weekday) gegen \(hour)"
        case "fr": "Souvent \(weekday) vers \(hour)"
        case "it": "Spesso \(weekday) verso le \(hour)"
        case "es": "Suele ser \(weekday) sobre las \(hour)"
        case "pt-BR": "Geralmente \(weekday) por volta de \(hour)"
        case "ja": "多い時間帯：\(weekday) \(hour)頃"
        case "ko": "자주 생각나는 때: \(weekday) \(hour)쯤"
        default: "Often \(weekday) around \(hour)"
        }
        return trigger.map { "\(time) · \($0)" } ?? time
    }
}
