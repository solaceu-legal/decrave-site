//
//  Strings.swift
//  Decrave
//
//  Centralized user-facing copy. Each language is written for its own
//  reading rhythm rather than assembled from English fragments.
//

import Foundation

enum Strings {

    static func localized(_ english: String, _ translations: [AppLanguage: String]) -> String {
        translations[AppLanguage.current.effective] ?? english
    }

    enum Money {
        static var packPrice: String { localized("Price per pack", [
            .simplifiedChinese: "每包价格", .traditionalChinese: "每包價格", .german: "Preis pro Packung", .french: "Prix du paquet", .italian: "Prezzo del pacchetto", .spanish: "Precio por paquete", .portuguese: "Preço do maço", .japanese: "1箱の価格", .korean: "한 갑 가격"
        ]) }
        static var currency: String { localized("Currency", [
            .simplifiedChinese: "币种", .traditionalChinese: "幣別", .german: "Währung", .french: "Devise", .italian: "Valuta", .spanish: "Moneda", .portuguese: "Moeda", .japanese: "通貨", .korean: "통화"
        ]) }
        static var chooseCurrency: String { localized("Choose currency", [
            .simplifiedChinese: "选择币种", .traditionalChinese: "選擇幣別", .german: "Währung wählen", .french: "Choisir une devise", .italian: "Scegli la valuta", .spanish: "Elegir moneda", .portuguese: "Escolher moeda", .japanese: "通貨を選ぶ", .korean: "통화 선택"
        ]) }
        static var explanation: String { localized("Enter what you actually pay for a pack. Each craving you get through counts as one cigarette in this estimate (20 per pack). Updating the price recalculates past estimates. After changing currency, enter the local price; there is no automatic conversion.", [
            .simplifiedChinese: "填入你实际购买一包烟的价格。估算时，每次记录为撑过的想抽时刻按少抽 1 支计算，每包按 20 支计算。修改价格会重新计算以往的估算金额；切换币种后，请重新填入当地价格。",
            .traditionalChinese: "填入你實際購買一包菸的價格。估算時，每次記錄為撐過的想抽時刻按少抽 1 支計算，每包按 20 支計算。修改價格會重新計算過去的估算金額；切換幣別後，請重新填入當地價格。",
            .german: "Trag deinen tatsächlichen Packungspreis ein. Jede überstandene und erfasste Lust zählt hier als eine nicht gerauchte Zigarette (20 pro Packung). Ein neuer Preis berechnet frühere Schätzungen neu. Nach einem Währungswechsel gib den Preis vor Ort neu ein.",
            .french: "Indique le prix que tu paies vraiment. Chaque envie surmontée et notée compte ici pour une cigarette non fumée (20 par paquet). Un nouveau prix recalcule les estimations passées. Après un changement de devise, saisis le prix local.",
            .italian: "Inserisci il prezzo che paghi davvero. Ogni voglia superata e registrata vale una sigaretta non fumata nella stima (20 per pacchetto). Un nuovo prezzo ricalcola le stime precedenti. Se cambi valuta, inserisci il prezzo locale.",
            .spanish: "Indica lo que pagas por un paquete. Cada impulso superado y registrado cuenta como un cigarrillo no fumado en esta estimación (20 por paquete). Un precio nuevo recalcula las estimaciones anteriores. Si cambias de moneda, escribe el precio local.",
            .portuguese: "Informe quanto você paga por um maço. Cada vontade superada e registrada conta como um cigarro não fumado nesta estimativa (20 por maço). Um novo preço recalcula as estimativas anteriores. Se trocar a moeda, informe o preço local.",
            .japanese: "実際に払う1箱の価格を入力してください。記録した「吸わずに乗り切った」回数を1回につき1本、1箱20本として概算します。価格を変えると過去の推定額も再計算されます。通貨を変えたら、現地の価格を入力してください。",
            .korean: "실제로 담배 한 갑에 내는 금액을 입력하세요. 기록한 참아낸 순간을 한 번에 한 개비씩, 한 갑 20개비로 계산한 추정치입니다. 가격을 바꾸면 지난 추정 금액도 다시 계산돼요. 통화를 바꾸면 현지 가격을 새로 입력해 주세요."
        ]) }
        static var save: String { localized("Save", [.simplifiedChinese: "保存", .traditionalChinese: "儲存", .german: "Speichern", .french: "Enregistrer", .italian: "Salva", .spanish: "Guardar", .portuguese: "Salvar", .japanese: "保存", .korean: "저장"]) }
        static var cancel: String { localized("Cancel", [.simplifiedChinese: "取消", .traditionalChinese: "取消", .german: "Abbrechen", .french: "Annuler", .italian: "Annulla", .spanish: "Cancelar", .portuguese: "Cancelar", .japanese: "キャンセル", .korean: "취소"]) }
    }

    enum Onboarding {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }

        static var introTitle: String { t("Still smoking? Start here.", [
            .simplifiedChinese: "还在抽烟？现在就能开始。", .traditionalChinese: "還在抽菸？現在就能開始。",
            .german: "Du rauchst noch? Fang trotzdem an.", .french: "Tu fumes encore ? Commence ici.",
            .italian: "Fumi ancora? Puoi iniziare da qui.", .spanish: "¿Sigues fumando? Empieza aquí.",
            .portuguese: "Ainda fuma? Comece por aqui.", .japanese: "まだ吸っていても、始められます。", .korean: "아직 담배를 피우나요? 지금 시작해도 돼요."
        ]) }
        static var introSubtitle: String { t("Let's take the next craving one moment at a time.", [
            .simplifiedChinese: "下一次想抽时，我们一步一步来。", .traditionalChinese: "下次想抽時，我們一步一步來。",
            .german: "Beim nächsten Verlangen gehen wir Schritt für Schritt vor.", .french: "À la prochaine envie, on avance un moment à la fois.",
            .italian: "Alla prossima voglia, affrontiamo un momento alla volta.", .spanish: "Cuando vuelva el impulso, vamos paso a paso.",
            .portuguese: "Quando a vontade vier, vamos um passo de cada vez.", .japanese: "次に吸いたくなったら、その瞬間から一緒に。", .korean: "다음에 피우고 싶어지면 그 순간부터 하나씩 해 봐요."
        ]) }
        static var introContinue: String { t("Continue", [.simplifiedChinese: "继续", .traditionalChinese: "繼續", .german: "Weiter", .french: "Continuer", .italian: "Continua", .spanish: "Continuar", .portuguese: "Continuar", .japanese: "次へ", .korean: "계속"]) }

        static var statusQuestion: String { t("Where are you with smoking?", [
            .simplifiedChinese: "你现在的情况是？", .traditionalChinese: "你目前的情況是？", .german: "Wie sieht es bei dir gerade aus?",
            .french: "Où en es-tu avec la cigarette ?", .italian: "A che punto sei con il fumo?", .spanish: "¿En qué punto estás con el tabaco?",
            .portuguese: "Como está sua relação com o cigarro?", .japanese: "今の状況を教えてください", .korean: "지금 어떤 상황인가요?"
        ]) }
        static var statusA: String { t("I've quit and want to stay quit", [
            .simplifiedChinese: "已经戒了，想继续保持", .traditionalChinese: "已經戒了，想繼續保持", .german: "Ich habe aufgehört und möchte dabei bleiben",
            .french: "J’ai arrêté et je veux tenir bon", .italian: "Ho smesso e voglio continuare così", .spanish: "Ya lo dejé y quiero mantenerme",
            .portuguese: "Já parei e quero continuar assim", .japanese: "すでにやめていて、このまま続けたい", .korean: "이미 끊었고 계속 유지하고 싶어요"
        ]) }
        static var statusB: String { t("I smoke and want to quit", [
            .simplifiedChinese: "还在抽，想戒掉", .traditionalChinese: "還在抽，想戒掉", .german: "Ich rauche noch und möchte aufhören",
            .french: "Je fume encore et je veux arrêter", .italian: "Fumo ancora e voglio smettere", .spanish: "Sigo fumando y quiero dejarlo",
            .portuguese: "Ainda fumo e quero parar", .japanese: "まだ吸っているけれど、やめたい", .korean: "아직 피우지만 끊고 싶어요"
        ]) }
        static var statusC: String { t("I smoke and don't want to pick a quit date yet", [
            .simplifiedChinese: "还在抽，暂时不想定戒烟日期", .traditionalChinese: "還在抽，暫時不想訂戒菸日期", .german: "Ich rauche noch und möchte noch keinen Stopp-Tag festlegen",
            .french: "Je fume encore, sans vouloir fixer de date pour l’instant", .italian: "Fumo ancora e non voglio fissare una data adesso", .spanish: "Sigo fumando y aún no quiero poner una fecha",
            .portuguese: "Ainda fumo e não quero marcar uma data agora", .japanese: "まだ吸っていて、やめる日は決めていない", .korean: "아직 피우고 있고 금연 날짜는 나중에 정하고 싶어요"
        ]) }

        static var cigsQuestion: String { t("About how many cigarettes do you smoke a day?", [
            .simplifiedChinese: "一天大约抽几支？", .traditionalChinese: "一天大約抽幾支？", .german: "Wie viele Zigaretten rauchst du ungefähr am Tag?",
            .french: "Tu fumes environ combien de cigarettes par jour ?", .italian: "Quante sigarette fumi più o meno al giorno?", .spanish: "¿Cuántos cigarrillos fumas al día, más o menos?",
            .portuguese: "Mais ou menos quantos cigarros você fuma por dia?", .japanese: "1日に何本くらい吸いますか？", .korean: "하루에 담배를 대략 몇 개비 피우나요?"
        ]) }
        static var cigsDone: String { t("Done", [.simplifiedChinese: "完成", .traditionalChinese: "完成", .german: "Fertig", .french: "Terminé", .italian: "Fatto", .spanish: "Listo", .portuguese: "Pronto", .japanese: "完了", .korean: "완료"]) }

        static var priceQuestion: String { t("How much does a pack cost?", [
            .simplifiedChinese: "一包烟大约多少钱？", .traditionalChinese: "一包菸大約多少錢？", .german: "Was kostet eine Packung?",
            .french: "Combien coûte un paquet ?", .italian: "Quanto costa un pacchetto?", .spanish: "¿Cuánto cuesta un paquete?",
            .portuguese: "Quanto custa um maço?", .japanese: "たばこ1箱はいくらですか？", .korean: "담배 한 갑은 얼마인가요?"
        ]) }
        static var priceCaption: String { t("We'll use this to estimate what you save when you don't smoke.", [
            .simplifiedChinese: "用它估算每次没抽烟省下的钱。", .traditionalChinese: "用它估算每次沒抽菸省下的錢。",
            .german: "Damit schätzen wir, wie viel du sparst, wenn du nicht rauchst.", .french: "On s’en servira pour estimer tes économies quand tu ne fumes pas.",
            .italian: "Ci serve per stimare quanto risparmi ogni volta che non fumi.", .spanish: "Lo usaremos para calcular cuánto ahorras cuando no fumas.",
            .portuguese: "Vamos usar esse valor para estimar quanto você economiza quando não fuma.", .japanese: "吸わずに過ごせた分の節約額を計算する目安にします。", .korean: "담배를 피우지 않았을 때 아낀 돈을 계산하는 데 사용해요."
        ]) }
        static var priceDone: String { t("Continue", [.simplifiedChinese: "继续", .traditionalChinese: "繼續", .german: "Weiter", .french: "Continuer", .italian: "Continua", .spanish: "Continuar", .portuguese: "Continuar", .japanese: "次へ", .korean: "계속"]) }

        static var analyticsTitle: String { t("Help make Decrave better?", [
            .simplifiedChinese: "帮我们改进 Decrave？", .traditionalChinese: "幫我們改善 Decrave？", .german: "Hilfst du uns, Decrave zu verbessern?",
            .french: "Tu veux nous aider à améliorer Decrave ?", .italian: "Ci aiuti a migliorare Decrave?", .spanish: "¿Nos ayudas a mejorar Decrave?",
            .portuguese: "Quer ajudar a melhorar o Decrave?", .japanese: "Decraveの改善にご協力いただけますか？", .korean: "Decrave를 개선하는 데 도움을 주시겠어요?"
        ]) }
        static var analyticsBody: String { t("If you agree, TelemetryDeck receives how you use the app and a privacy-preserving device identifier. It never receives your craving logs, name, email, IP address, or advertising ID. Change this anytime in Settings.", [
            .simplifiedChinese: "如果同意，TelemetryDeck 会收到功能使用情况和保护隐私的设备标识。想抽记录、姓名、邮箱、IP 地址和广告 ID 不会发送。你可以随时在设置中更改。",
            .traditionalChinese: "如果同意，TelemetryDeck 會收到功能使用情況和保護私隱的裝置識別碼。想抽記錄、姓名、電郵、IP 位址和廣告 ID 不會傳送。你隨時可以在設定中更改。",
            .german: "Mit deiner Zustimmung erhält TelemetryDeck Nutzungsdaten und eine datenschutzfreundliche Gerätekennung. Deine Einträge, dein Name, deine E-Mail-Adresse, IP-Adresse und Werbe-ID werden nicht übertragen. Du kannst das jederzeit in den Einstellungen ändern.",
            .french: "Si tu acceptes, TelemetryDeck reçoit des données d’utilisation et un identifiant d’appareil respectueux de ta vie privée. Tes notes, ton nom, ton adresse e-mail, ton adresse IP et ton identifiant publicitaire ne sont jamais transmis. Tu peux changer d’avis dans les réglages.",
            .italian: "Se accetti, TelemetryDeck riceve dati sull’uso dell’app e un identificativo del dispositivo rispettoso della privacy. Non riceve mai le tue note, il nome, l’email, l’indirizzo IP o l’ID pubblicitario. Puoi cambiare idea nelle impostazioni.",
            .spanish: "Si aceptas, TelemetryDeck recibe datos de uso y un identificador del dispositivo que protege tu privacidad. Nunca recibe tus registros, nombre, correo, dirección IP ni ID de publicidad. Puedes cambiarlo cuando quieras en Ajustes.",
            .portuguese: "Se você aceitar, a TelemetryDeck recebe dados de uso e um identificador do dispositivo que preserva sua privacidade. Seus registros, nome, e-mail, endereço IP e ID de publicidade não são enviados. Você pode mudar isso quando quiser em Ajustes.",
            .japanese: "同意した場合、機能の利用状況とプライバシーに配慮した端末識別子がTelemetryDeckに送られます。欲求の記録、氏名、メールアドレス、IPアドレス、広告IDは送信されません。設定からいつでも変更できます。",
            .korean: "동의하면 앱 사용 정보와 개인정보 보호형 기기 식별자가 TelemetryDeck에 전달됩니다. 욕구 기록, 이름, 이메일, IP 주소, 광고 ID는 보내지지 않아요. 설정에서 언제든 바꿀 수 있습니다."
        ]) }
        static var analyticsAllow: String { t("Share usage data", [.simplifiedChinese: "同意分享使用数据", .traditionalChinese: "同意分享使用資料", .german: "Nutzungsdaten teilen", .french: "Partager les données d’utilisation", .italian: "Condividi i dati d’uso", .spanish: "Compartir datos de uso", .portuguese: "Compartilhar dados de uso", .japanese: "利用データを共有する", .korean: "사용 정보 공유"]) }
        static var analyticsDecline: String { t("Not now", [.simplifiedChinese: "暂时不要", .traditionalChinese: "暫時不要", .german: "Jetzt nicht", .french: "Pas maintenant", .italian: "Non ora", .spanish: "Ahora no", .portuguese: "Agora não", .japanese: "今はしない", .korean: "지금은 안 할게요"]) }
    }

    enum Home {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }

        static var cravingsBeaten: String { t("cravings beaten", [
            .simplifiedChinese: "撑过的想抽时刻", .traditionalChinese: "撐過的想抽時刻", .german: "überstandene Momente",
            .french: "envies surmontées", .italian: "voglie superate", .spanish: "impulsos superados",
            .portuguese: "desejos superados", .japanese: "乗り越えた欲求", .korean: "넘긴 욕구"
        ]) }
        static var last7Days: String { t("Cravings beaten — last 7 days", [
            .simplifiedChinese: "过去 7 天撑过的时刻", .traditionalChinese: "過去 7 天撐過的時刻", .german: "Überstandene Momente — letzte 7 Tage",
            .french: "Envies surmontées — 7 derniers jours", .italian: "Voglie superate — ultimi 7 giorni", .spanish: "Impulsos superados — últimos 7 días",
            .portuguese: "Desejos superados — últimos 7 dias", .japanese: "過去7日間に乗り越えた欲求", .korean: "최근 7일간 넘긴 욕구"
        ]) }

        static var moneySavedCaption: String { t("estimated savings · never resets", [
            .simplifiedChinese: "估算省下 · 永不清零", .traditionalChinese: "估算省下 · 永不歸零", .german: "geschätzt gespart · bleibt erhalten",
            .french: "économies estimées · sans remise à zéro", .italian: "risparmio stimato · non si azzera", .spanish: "ahorro estimado · no se reinicia",
            .portuguese: "economia estimada · não zera", .japanese: "節約額の目安 · リセットなし", .korean: "예상 절약액 · 초기화 없음"
        ]) }
        static var momentumLabel: String { t("Momentum", [
            .simplifiedChinese: "动力", .traditionalChinese: "動力", .german: "Schwung", .french: "Élan", .italian: "Slancio",
            .spanish: "Impulso", .portuguese: "Ritmo", .japanese: "勢い", .korean: "모멘텀"
        ]) }
        static func cigsAvoided(_ n: Int) -> String {
            let count = n.formatted(.number.locale(AppLanguage.current.locale))
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "少抽 \(count) 支"
            case .traditionalChinese: return "少抽 \(count) 支"
            case .german: return "\(count) Zigaretten vermieden"
            case .french: return "\(count) cigarettes évitées"
            case .italian: return "\(count) sigarette evitate"
            case .spanish: return "\(count) cigarrillos evitados"
            case .portuguese: return "\(count) cigarros evitados"
            case .japanese: return "\(count)本吸わずに済んだ"
            case .korean: return "피우지 않은 담배 \(count)개"
            default: return "\(count) cigarettes avoided"
            }
        }
        static func timeReclaimed(_ text: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "找回 " + text
            case .traditionalChinese: return "找回 " + text
            case .german: return text + " zurückgewonnen"
            case .french: return text + " récupérées"
            case .italian: return text + " recuperati"
            case .spanish: return text + " recuperados"
            case .portuguese: return text + " recuperados"
            case .japanese: return "取り戻した時間 " + text
            case .korean: return "되찾은 시간 " + text
            default: return text + " reclaimed"
            }
        }
        static func reclaimedDuration(totalMinutes: Int) -> String {
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60
            let h = hours.formatted(.number.locale(AppLanguage.current.locale))
            let m = minutes.formatted(.number.locale(AppLanguage.current.locale))
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return hours > 0 ? "\(h) 小时 \(m) 分钟" : "\(m) 分钟"
            case .traditionalChinese: return hours > 0 ? "\(h) 小時 \(m) 分鐘" : "\(m) 分鐘"
            case .german: return hours > 0 ? "\(h) Std. \(m) Min." : "\(m) Min."
            case .french: return hours > 0 ? "\(h) h \(m) min" : "\(m) min"
            case .italian: return hours > 0 ? "\(h) h \(m) min" : "\(m) min"
            case .spanish: return hours > 0 ? "\(h) h \(m) min" : "\(m) min"
            case .portuguese: return hours > 0 ? "\(h) h \(m) min" : "\(m) min"
            case .japanese: return hours > 0 ? "\(h)時間\(m)分" : "\(m)分"
            case .korean: return hours > 0 ? "\(h)시간 \(m)분" : "\(m)분"
            default: return hours > 0 ? "\(h)h \(m)m" : "\(m)m"
            }
        }

        static var bodyRecoveryTitle: String { t("Body recovery", [
            .simplifiedChinese: "身体恢复", .traditionalChinese: "身體恢復", .german: "Körper erholt sich", .french: "Récupération du corps",
            .italian: "Recupero del corpo", .spanish: "Recuperación del cuerpo", .portuguese: "Recuperação do corpo", .japanese: "体の回復", .korean: "몸의 회복"
        ]) }
        static var recoveryReached: String { t("Reached", [
            .simplifiedChinese: "已到达", .traditionalChinese: "已到達", .german: "Erreicht", .french: "Étape atteinte", .italian: "Traguardo raggiunto", .spanish: "Etapa alcanzada", .portuguese: "Etapa alcançada", .japanese: "到達済み", .korean: "도달했어요"
        ]) }
        static func recoveryMilestoneLabel(duration: TimeInterval) -> String {
            let english: String
            switch duration {
            case 1200: english = "20 MIN"
            case 43200: english = "12 HRS"
            case 1209600: english = "2 WEEKS"
            case 2592000: english = "1 MONTH"
            case 23328000: english = "9 MONTHS"
            default: english = "1 YEAR"
            }
            return t(english, [
                .simplifiedChinese: [1200: "20 分钟", 43200: "12 小时", 1209600: "2 周", 2592000: "1 个月", 23328000: "9 个月"][Int(duration)] ?? "1 年",
                .traditionalChinese: [1200: "20 分鐘", 43200: "12 小時", 1209600: "2 週", 2592000: "1 個月", 23328000: "9 個月"][Int(duration)] ?? "1 年",
                .german: [1200: "20 MIN", 43200: "12 STD", 1209600: "2 WOCHEN", 2592000: "1 MONAT", 23328000: "9 MONATE"][Int(duration)] ?? "1 JAHR",
                .french: [1200: "20 MIN", 43200: "12 H", 1209600: "2 SEM", 2592000: "1 MOIS", 23328000: "9 MOIS"][Int(duration)] ?? "1 AN",
                .italian: [1200: "20 MIN", 43200: "12 ORE", 1209600: "2 SETT", 2592000: "1 MESE", 23328000: "9 MESI"][Int(duration)] ?? "1 ANNO",
                .spanish: [1200: "20 MIN", 43200: "12 H", 1209600: "2 SEM", 2592000: "1 MES", 23328000: "9 MESES"][Int(duration)] ?? "1 AÑO",
                .portuguese: [1200: "20 MIN", 43200: "12 H", 1209600: "2 SEM", 2592000: "1 MÊS", 23328000: "9 MESES"][Int(duration)] ?? "1 ANO",
                .japanese: [1200: "20分", 43200: "12時間", 1209600: "2週間", 2592000: "1か月", 23328000: "9か月"][Int(duration)] ?? "1年",
                .korean: [1200: "20분", 43200: "12시간", 1209600: "2주", 2592000: "1개월", 23328000: "9개월"][Int(duration)] ?? "1년"
            ])
        }
        static func recoveryMilestoneTitle(duration: TimeInterval) -> String {
            let english: String
            switch duration {
            case 1200: english = "Heart rate and blood pressure start to drop"
            case 43200: english = "Carbon monoxide in your blood drops"
            case 1209600: english = "Circulation starts improving"
            case 2592000: english = "Lung function starts improving"
            case 23328000: english = "Coughing and shortness of breath decrease"
            default: english = "Heart health keeps improving"
            }
            return t(english, [
                .simplifiedChinese: [1200: "心率和血压开始下降", 43200: "血液中的一氧化碳水平下降", 1209600: "血液循环开始改善", 2592000: "肺功能开始改善", 23328000: "咳嗽和气短减轻"][Int(duration)] ?? "心脏健康持续改善",
                .traditionalChinese: [1200: "心率和血壓開始下降", 43200: "血液中的一氧化碳濃度下降", 1209600: "血液循環開始改善", 2592000: "肺功能開始改善", 23328000: "咳嗽和氣短減輕"][Int(duration)] ?? "心臟健康持續改善",
                .german: [1200: "Herzfrequenz und Blutdruck beginnen zu sinken", 43200: "Kohlenmonoxid im Blut nimmt ab", 1209600: "Die Durchblutung beginnt sich zu verbessern", 2592000: "Die Lungenfunktion verbessert sich", 23328000: "Husten und Atemnot nehmen ab"][Int(duration)] ?? "Die Herzgesundheit verbessert sich weiter",
                .french: [1200: "Le rythme cardiaque et la tension commencent à baisser", 43200: "Le monoxyde de carbone dans le sang diminue", 1209600: "La circulation commence à s’améliorer", 2592000: "La fonction pulmonaire commence à s’améliorer", 23328000: "La toux et l’essoufflement diminuent"][Int(duration)] ?? "La santé du cœur continue de s’améliorer",
                .italian: [1200: "Frequenza cardiaca e pressione iniziano a scendere", 43200: "Il monossido di carbonio nel sangue diminuisce", 1209600: "La circolazione inizia a migliorare", 2592000: "La funzione polmonare inizia a migliorare", 23328000: "Diminuiscono tosse e fiato corto"][Int(duration)] ?? "La salute del cuore continua a migliorare",
                .spanish: [1200: "Bajan el ritmo cardíaco y la presión", 43200: "Disminuye el monóxido de carbono en sangre", 1209600: "La circulación empieza a mejorar", 2592000: "La función pulmonar empieza a mejorar", 23328000: "Disminuyen la tos y la falta de aire"][Int(duration)] ?? "La salud del corazón sigue mejorando",
                .portuguese: [1200: "A frequência cardíaca e a pressão começam a cair", 43200: "O monóxido de carbono no sangue diminui", 1209600: "A circulação começa a melhorar", 2592000: "A função pulmonar começa a melhorar", 23328000: "A tosse e a falta de ar diminuem"][Int(duration)] ?? "A saúde do coração continua melhorando",
                .japanese: [1200: "心拍数と血圧が下がり始めます", 43200: "血中の一酸化炭素が減り始めます", 1209600: "血流が改善し始めます", 2592000: "肺機能が改善し始めます", 23328000: "咳や息切れが減ります"][Int(duration)] ?? "心臓の健康はさらに改善していきます",
                .korean: [1200: "심박수와 혈압이 내려가기 시작해요", 43200: "혈중 일산화탄소 수치가 내려가요", 1209600: "혈액순환이 좋아지기 시작해요", 2592000: "폐 기능이 좋아지기 시작해요", 23328000: "기침과 숨참이 줄어들어요"][Int(duration)] ?? "심장 건강이 계속 나아져요"
            ])
        }
        static var sinceLastCigarette: String { t("Since your last cigarette", [
            .simplifiedChinese: "距离上次抽烟", .traditionalChinese: "距離上次抽煙", .german: "Seit der letzten Zigarette", .french: "Depuis ta dernière cigarette",
            .italian: "Dall’ultima sigaretta", .spanish: "Desde tu último cigarrillo", .portuguese: "Desde o último cigarro", .japanese: "最後に吸ってから", .korean: "마지막 담배 이후"
        ]) }
        static var noCigaretteLoggedYet: String { t("Starts once you log your first craving", [
            .simplifiedChinese: "记录第一次想抽的时刻后开始", .traditionalChinese: "記錄第一次想抽的時刻後開始", .german: "Beginnt mit deinem ersten Eintrag",
            .french: "Commence après ta première envie notée", .italian: "Inizia quando registri la prima voglia", .spanish: "Empieza cuando registres tu primer impulso",
            .portuguese: "Começa quando você registrar seu primeiro desejo", .japanese: "最初の欲求を記録すると始まります", .korean: "첫 욕구를 기록하면 시작돼요"
        ]) }

        static var triggerRadarEyebrow: String { t("Trigger Radar", [
            .simplifiedChinese: "诱因雷达", .traditionalChinese: "誘因雷達", .german: "Trigger-Radar", .french: "Radar des déclencheurs",
            .italian: "Trigger Radar", .spanish: "Radar de desencadenantes", .portuguese: "Radar de gatilhos", .japanese: "トリガーレーダー", .korean: "트리거 레이더"
        ]) }
        static var proBadge: String { "PRO" }
        static var triggerRadarPlaceholder: String { t("Log a few more cravings and Trigger Radar will start predicting your next window.", [
            .simplifiedChinese: "再记录几次想抽的时刻，诱因雷达就能预测下一个时段。", .traditionalChinese: "再記錄幾次想抽的時刻，誘因雷達就能預測下一個時段。",
            .german: "Protokolliere noch ein paar Momente, dann sagt der Trigger-Radar dein nächstes Zeitfenster voraus.", .french: "Note encore quelques envies pour prévoir ton prochain créneau.",
            .italian: "Registra qualche altra voglia per prevedere la prossima finestra.", .spanish: "Registra algunos impulsos más para predecir tu próxima franja.",
            .portuguese: "Registre mais alguns desejos para prever seu próximo horário.", .japanese: "もう少し記録すると次の時間帯を予測できます。", .korean: "몇 번 더 기록하면 다음 시간대를 예측할 수 있어요."
        ]) }
        static func triggerRadarPreview(weekday: String, hour: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "下一个可能时段：\(weekday) \(hour) 左右。"
            case .traditionalChinese: return "下一個可能時段：\(weekday) \(hour) 左右。"
            case .german: return "Nächstes wahrscheinliches Zeitfenster: \(weekday) gegen \(hour)."
            case .french: return "Prochain créneau probable : \(weekday) vers \(hour)."
            case .italian: return "Prossima finestra probabile: \(weekday) verso le \(hour)."
            case .spanish: return "Próxima franja probable: \(weekday) sobre las \(hour)."
            case .portuguese: return "Próximo horário provável: \(weekday) por volta de \(hour)."
            case .japanese: return "次に起こりそうな時間帯：\(weekday)の\(hour)頃。"
            case .korean: return "다음으로 예상되는 시간대: \(weekday) \(hour)쯤"
            default: return "Next likely window: \(weekday) around \(hour)."
            }
        }
        static func triggerRadarPreview(weekday: String, hour: String, trigger: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "下一个可能时段：\(weekday) \(hour) 左右——\(trigger) 往往会触发它。"
            case .traditionalChinese: return "下一個可能時段：\(weekday) \(hour) 左右——\(trigger) 往往會觸發它。"
            case .german: return "Nächstes wahrscheinliches Zeitfenster: \(weekday) gegen \(hour) — möglicher Auslöser: \(trigger)."
            case .french: return "Prochain créneau probable : \(weekday) vers \(hour) — \(trigger) le déclenche souvent."
            case .italian: return "Prossima finestra probabile: \(weekday) verso le \(hour) — spesso parte da \(trigger)."
            case .spanish: return "Próxima franja probable: \(weekday) sobre las \(hour); \(trigger) suele activarla."
            case .portuguese: return "Próximo horário provável: \(weekday) por volta de \(hour); \(trigger) costuma ativá-lo."
            case .japanese: return "次に起こりそうな時間帯：\(weekday)の\(hour)頃。きっかけは\(trigger)です。"
            case .korean: return "다음 예상 시간대: \(weekday) \(hour)쯤 — \(trigger)가 자주 계기가 돼요."
            default: return "Next likely window: \(weekday) around \(hour) — \(trigger) tends to trigger it."
            }
        }
        // Split title/subtitle pair used by the Home card's redesigned
        // layout (see TriggerRadarPreviewCard) — the two triggerRadarPreview
        // functions above stay as-is since WeeklyReportView's detail section
        // still builds its one-line sentence from them.
        static func triggerRadarWindowLabel(weekday: String, hour: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "\(weekday) \(hour) 左右"
            case .traditionalChinese: return "\(weekday) \(hour) 左右"
            case .german: return "\(weekday) gegen \(hour)"
            case .french: return "\(weekday) vers \(hour)"
            case .italian: return "\(weekday) verso le \(hour)"
            case .spanish: return "\(weekday) sobre las \(hour)"
            case .portuguese: return "\(weekday) por volta de \(hour)"
            case .japanese: return "\(weekday)の\(hour)頃"
            case .korean: return "\(weekday) \(hour)쯤"
            default: return "\(weekday) around \(hour)"
            }
        }
        static func triggerRadarTriggerNote(trigger: String, occurrences: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "\(trigger) 往往会触发它——基于已记录的 \(occurrences) 次。"
            case .traditionalChinese: return "\(trigger) 往往會觸發它——根據已記錄的 \(occurrences) 次。"
            case .german: return "Häufiger Auslöser: \(trigger) — \(occurrences) Mal erfasst."
            case .french: return "\(trigger) le déclenche souvent — sur \(occurrences) envies notées."
            case .italian: return "\(trigger) lo attiva spesso — in base a \(occurrences) registrazioni."
            case .spanish: return "\(trigger) suele activarlo — según \(occurrences) registros."
            case .portuguese: return "\(trigger) costuma ativá-lo — com base em \(occurrences) registros."
            case .japanese: return "\(trigger)がきっかけになりやすいです（記録\(occurrences)回）。"
            case .korean: return "\(trigger)가 자주 계기가 돼요 — \(occurrences)번 기록 기준"
            default: return "\(trigger) tends to trigger it — based on \(occurrences) logged cravings."
            }
        }
        static func triggerRadarOccurrenceNote(occurrences: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "目前基于已记录的 \(occurrences) 次想抽时刻。"
            case .traditionalChinese: return "目前根據已記錄的 \(occurrences) 次想抽時刻。"
            case .german: return "Basiert bisher auf \(occurrences) protokollierten Momenten."
            case .french: return "Basé sur \(occurrences) envies notées jusqu’ici."
            case .italian: return "In base alle \(occurrences) voglie registrate finora."
            case .spanish: return "Según los \(occurrences) impulsos registrados hasta ahora."
            case .portuguese: return "Com base nos \(occurrences) desejos registrados até agora."
            case .japanese: return "これまでに記録した欲求は\(occurrences)回です。"
            case .korean: return "지금까지 \(occurrences)번 기록한 욕구를 바탕으로 해요."
            default: return "Based on \(occurrences) logged cravings so far."
            }
        }
        static var triggerRadarPreviewCTA: String { t("Preview radar", [
            .simplifiedChinese: "预览雷达", .traditionalChinese: "預覽雷達", .german: "Radar ansehen", .french: "Voir le radar",
            .italian: "Vedi radar", .spanish: "Ver radar", .portuguese: "Ver radar", .japanese: "レーダーを見る", .korean: "레이더 보기"
        ]) }

        static var questEyebrow: String { t("Try this today", [
            .simplifiedChinese: "今天试试", .traditionalChinese: "今天試試", .german: "Heute ausprobieren", .french: "À essayer aujourd’hui",
            .italian: "Da provare oggi", .spanish: "Para probar hoy", .portuguese: "Para tentar hoje", .japanese: "今日やってみること", .korean: "오늘 해 볼 일"
        ]) }
        static var questPracticeTitle: String { t("Practice SOS", [
            .simplifiedChinese: "练习一下 SOS", .traditionalChinese: "練習一下 SOS", .german: "SOS in Ruhe ausprobieren", .french: "Essayer SOS à tête reposée",
            .italian: "Prova SOS con calma", .spanish: "Prueba SOS con calma", .portuguese: "Experimente o SOS", .japanese: "落ち着いているときにSOS", .korean: "SOS 미리 연습하기"
        ]) }
        static var questPracticeBody: String { t("Try a short exercise while things are calm.", [
            .simplifiedChinese: "趁现在平静，试一次简短练习。", .traditionalChinese: "趁現在平靜，試一次簡短練習。",
            .german: "Übe kurz, solange das Verlangen noch nicht da ist.", .french: "Teste un exercice court avant d’en avoir besoin.",
            .italian: "Fai un esercizio breve prima di averne bisogno.", .spanish: "Haz un ejercicio breve antes de necesitarlo.",
            .portuguese: "Faça um exercício curto antes de precisar dele.", .japanese: "必要になる前に、短い練習をしてみましょう。", .korean: "마음이 편할 때 짧은 연습을 해 보세요."
        ]) }
        static var questCaptureTitle: String { t("Notice a craving", [
            .simplifiedChinese: "记录一次想抽", .traditionalChinese: "記錄一次想抽", .german: "Einen Moment festhalten", .french: "Noter une envie",
            .italian: "Annota una voglia", .spanish: "Anota un momento", .portuguese: "Anote uma vontade", .japanese: "吸いたくなった時を記録", .korean: "흡연 욕구 기록하기"
        ]) }
        static var questCaptureBody: String { t("Use SOS once today and note what happened.", [
            .simplifiedChinese: "今天用一次 SOS，记下当时的情况。", .traditionalChinese: "今天用一次 SOS，記下當時的情況。",
            .german: "Nutze SOS heute einmal und notiere, was passiert ist.", .french: "Utilise SOS une fois aujourd’hui et note ce qui s’est passé.",
            .italian: "Usa SOS una volta oggi e annota com’è andata.", .spanish: "Usa SOS una vez hoy y anota qué pasó.",
            .portuguese: "Use o SOS uma vez hoje e registre como foi.", .japanese: "今日はSOSを一度使い、そのときのことを残しましょう。", .korean: "오늘 SOS를 한 번 쓰고 어떤 일이 있었는지 기록해요."
        ]) }
        static var questTriggerTitle: String { t("Spot a trigger", [
            .simplifiedChinese: "留意诱因", .traditionalChinese: "留意誘因", .german: "Auslöser erkennen", .french: "Repérer un déclencheur",
            .italian: "Riconosci una causa", .spanish: "Reconoce una situación", .portuguese: "Perceba o gatilho", .japanese: "きっかけに気づく", .korean: "계기 알아보기"
        ]) }
        static func questTriggerBody(trigger: String?) -> String {
            if let trigger {
                switch AppLanguage.current.effective {
                case .simplifiedChinese: return "你常在「\(trigger)」时想抽。下次可以怎么应对？"
                case .traditionalChinese: return "你常在「\(trigger)」時想抽。下次可以怎麼應對？"
                case .german: return "Auslöser: „\(trigger)“. Was könntest du beim nächsten Mal tun?"
                case .french: return "Situation à surveiller : « \(trigger) ». Que faire la prochaine fois ?"
                case .italian: return "Situazione da tenere d’occhio: «\(trigger)». Cosa puoi fare la prossima volta?"
                case .spanish: return "Situación a tener en cuenta: «\(trigger)». ¿Qué podrías hacer la próxima vez?"
                case .portuguese: return "Situação para observar: «\(trigger)». O que fazer da próxima vez?"
                case .japanese: return "「\(trigger)」のときに吸いたくなることが多いようです。次はどうしますか？"
                case .korean: return "‘\(trigger)’ 때 담배 생각이 자주 나요. 다음에는 어떻게 해 볼까요?"
                default: return "You often feel like smoking around \(trigger.lowercased()). What could you try next time?"
                }
            }
            return Strings.localized("Name what set off one craving today, then choose a response.", [
                .simplifiedChinese: "今天说出一次想抽的诱因，再选择应对方式。", .traditionalChinese: "今天說出一次想抽的誘因，再選擇應對方式。",
                .german: "Benenne heute einen Auslöser und wähle dann eine Antwort.", .french: "Nomme aujourd’hui un déclencheur, puis choisis ta réponse.",
                .italian: "Dai un nome a un trigger di oggi, poi scegli come rispondere.", .spanish: "Nombra hoy un desencadenante y elige cómo responder.",
                .portuguese: "Dê um nome a um gatilho de hoje e escolha como responder.", .japanese: "今日のきっかけを1つ言葉にして、対処を選びましょう。", .korean: "오늘 욕구를 일으킨 요인을 말해 보고 대응을 골라 보세요."
            ])
        }
        static var questPracticeCTA: String { t("Practice now", [
            .simplifiedChinese: "现在练习", .traditionalChinese: "現在練習", .german: "Jetzt üben", .french: "Pratiquer maintenant",
            .italian: "Pratica ora", .spanish: "Practicar ahora", .portuguese: "Praticar agora", .japanese: "今すぐ練習", .korean: "지금 연습"
        ]) }
        static var questCaptureCTA: String { t("Log a moment", [
            .simplifiedChinese: "记录一个时刻", .traditionalChinese: "記錄一個時刻", .german: "Moment festhalten", .french: "Noter un moment",
            .italian: "Registra un momento", .spanish: "Registrar un momento", .portuguese: "Registrar um momento", .japanese: "瞬間を記録", .korean: "순간 기록"
        ]) }
        static var questTriggerCTA: String { t("SOS", [
            .simplifiedChinese: "SOS", .traditionalChinese: "SOS", .german: "SOS", .french: "SOS",
            .italian: "SOS", .spanish: "SOS", .portuguese: "SOS", .japanese: "SOS", .korean: "SOS"
        ]) }
        static var questActionTag: String { t("One small step", [
            .simplifiedChinese: "先做一件小事", .traditionalChinese: "先做一件小事", .german: "Ein kleiner Schritt", .french: "Un petit pas",
            .italian: "Un piccolo passo", .spanish: "Un pequeño paso", .portuguese: "Um passo de cada vez", .japanese: "まずはひとつ", .korean: "작은 실천 하나"
        ]) }
        static func questActionsBanked(_ n: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "已完成 \(n) 个行动"
            case .traditionalChinese: return "已完成 \(n) 個行動"
            case .german: return n == 1 ? "1 Aktion geschafft" : "\(n) Aktionen geschafft"
            case .french: return n == 1 ? "1 action réalisée" : "\(n) actions réalisées"
            case .italian: return n == 1 ? "1 azione completata" : "\(n) azioni completate"
            case .spanish: return n == 1 ? "1 acción realizada" : "\(n) acciones realizadas"
            case .portuguese: return n == 1 ? "1 ação concluída" : "\(n) ações concluídas"
            case .japanese: return "\(n)個の行動を完了"
            case .korean: return "행동 \(n)개 완료"
            default: return n == 1 ? "1 action completed" : "\(n) actions completed"
            }
        }
        static var questCompleted: String { t("Completed ✓", [
            .simplifiedChinese: "已完成 ✓", .traditionalChinese: "已完成 ✓", .german: "Erledigt ✓", .french: "Terminé ✓",
            .italian: "Completato ✓", .spanish: "Completado ✓", .portuguese: "Concluído ✓", .japanese: "完了 ✓", .korean: "완료 ✓"
        ]) }
    }

    enum Tab {
        static var home: String { Strings.localized("Home", [
            .simplifiedChinese: "首页", .traditionalChinese: "首頁", .german: "Start",
            .french: "Accueil", .italian: "Home", .spanish: "Inicio", .portuguese: "Início",
            .japanese: "ホーム", .korean: "홈"
        ]) }
        static var progress: String { Strings.localized("Progress", [
            .simplifiedChinese: "进展", .traditionalChinese: "進度", .german: "Fortschritt",
            .french: "Progrès", .italian: "Progressi", .spanish: "Progreso", .portuguese: "Progresso",
            .japanese: "進捗", .korean: "진행"
        ]) }
        static var settings: String { Strings.localized("Settings", [
            .simplifiedChinese: "设置", .traditionalChinese: "設定", .german: "Einstellungen",
            .french: "Réglages", .italian: "Impostazioni", .spanish: "Ajustes", .portuguese: "Ajustes",
            .japanese: "設定", .korean: "설정"
        ]) }
        // Visible on the pill itself — short on purpose, it's the only
        // text in the tab bar's fixed-width center cell.
        static var sosButtonShortLabel: String { Strings.localized("SOS", [
            .simplifiedChinese: "SOS", .traditionalChinese: "SOS", .german: "SOS",
            .french: "SOS", .italian: "SOS", .spanish: "SOS", .portuguese: "SOS",
            .japanese: "SOS", .korean: "SOS"
        ]) }
        // Keep the accessibility label aligned with the visible action so
        // VoiceOver and the home-screen entry point use the same language.
        static var sosButtonLabel: String { sosButtonShortLabel }
    }

    enum Intervention {
        // Keep each four-step session coherent while rotating the focus.
        private static let englishUrgeSurfingPromptSets: [[String]] = [
            [
                "Where do you feel the urge right now: chest, throat, hands?",
                "You don't need to push it away. Is it tight, warm, or restless?",
                "It may get stronger or weaker. Just notice what changes.",
                "The urge is still here. You can wait a little longer before smoking."
            ],
            [
                "Picture the urge as a wave. Where does it begin?",
                "There's no need to get away from it. What does it feel like now?",
                "The wave may rise a little more. Stay with it for a moment.",
                "You're still here. The cigarette can wait."
            ],
            [
                "How are you breathing: shallow, fast, or holding your breath?",
                "Don't try to change it. Notice your next breath.",
                "Your body may still feel tense. Give it a little time.",
                "Keep breathing and see whether this feeling changes."
            ],
            [
                "What are your hands doing? Are they still, or looking for something?",
                "Try resting them on your legs. Notice the urge to move them.",
                "You don't have to act on it yet. Wait just a few seconds.",
                "Your hands are here. The next step is still yours to choose."
            ]
        ]

        static var urgeSurfingPromptSets: [[String]] {
            let language = AppLanguage.current.effective
            guard language != .english else { return englishUrgeSurfingPromptSets }
            return localizedUrgeSurfingPromptSets(for: language, fallback: englishUrgeSurfingPromptSets)
        }

        static var exit: String { Strings.localized("Exit", [.simplifiedChinese: "退出", .traditionalChinese: "退出", .german: "Beenden", .french: "Quitter", .italian: "Esci", .spanish: "Salir", .portuguese: "Sair", .japanese: "終了", .korean: "나가기"]) }

        static var endLine1: String { Strings.localized("The craving may still be here.", [.simplifiedChinese: "想抽的感觉可能还在。", .traditionalChinese: "想抽的感覺可能還在。", .german: "Das Verlangen kann noch da sein.", .french: "L’envie est peut-être encore là.", .italian: "La voglia potrebbe essere ancora qui.", .spanish: "Puede que el impulso siga aquí.", .portuguese: "O desejo pode continuar aqui.", .japanese: "欲求はまだ残っているかもしれません。", .korean: "욕구가 아직 남아 있을 수 있어요."]) }
        static var endLine2: String { Strings.localized("That's okay — it's not supposed to disappear.", [.simplifiedChinese: "没关系——它本来就不一定会立刻消失。", .traditionalChinese: "沒關係——它本來就不一定會立刻消失。", .german: "Das ist okay — es muss nicht sofort verschwinden.", .french: "Ce n’est pas grave : elle n’a pas à disparaître tout de suite.", .italian: "Va bene: non deve sparire subito.", .spanish: "Está bien: no tiene que desaparecer enseguida.", .portuguese: "Tudo bem — não precisa desaparecer agora.", .japanese: "大丈夫。すぐに消える必要はありません。", .korean: "괜찮아요 — 바로 사라질 필요는 없어요."]) }
        static var endLine3: String { Strings.localized("You let the craving pass without smoking.", [.simplifiedChinese: "这一次，你没有跟着想抽的感觉走。", .traditionalChinese: "這一次，你沒有跟著想抽的感覺走。", .german: "Du hast das Verlangen ausgehalten, ohne zu rauchen.", .french: "Tu as laissé passer l’envie sans fumer.", .italian: "Hai lasciato passare la voglia senza fumare.", .spanish: "Dejaste pasar las ganas sin fumar.", .portuguese: "Você deixou a vontade passar sem fumar.", .japanese: "吸わずに、吸いたい気持ちをやり過ごせました。", .korean: "담배를 피우지 않고 흡연 욕구를 넘겼어요."]) }
        static var didntSmoke: String { Strings.localized("I didn't smoke", [.simplifiedChinese: "我没有抽烟", .traditionalChinese: "我沒有抽煙", .german: "Ich habe nicht geraucht", .french: "Je n’ai pas fumé", .italian: "Non ho fumato", .spanish: "No fumé", .portuguese: "Não fumei", .japanese: "吸わなかった", .korean: "피우지 않았어요"]) }
        static var smoked: String { Strings.localized("I had a slip", [.simplifiedChinese: "我还是抽了", .traditionalChinese: "我還是抽了", .german: "Ich bin ausgerutscht", .french: "J’ai craqué", .italian: "Ho avuto uno scivolone", .spanish: "Tuve un desliz", .portuguese: "Tive um deslize", .japanese: "吸ってしまった", .korean: "한 번 피웠어요"]) }

        static var breatheInPrompt: String { Strings.localized("Breathe in", [.simplifiedChinese: "吸气", .traditionalChinese: "吸氣", .german: "Einatmen", .french: "Inspire", .italian: "Inspira", .spanish: "Inhala", .portuguese: "Inspire", .japanese: "吸う", .korean: "들이마셔요"]) }
        static var holdPrompt: String { Strings.localized("Hold", [.simplifiedChinese: "屏息", .traditionalChinese: "屏息", .german: "Halten", .french: "Retiens", .italian: "Trattieni", .spanish: "Mantén", .portuguese: "Segure", .japanese: "止める", .korean: "멈춰요"]) }
        static var breatheOutPrompt: String { Strings.localized("Breathe out", [.simplifiedChinese: "呼气", .traditionalChinese: "呼氣", .german: "Ausatmen", .french: "Expire", .italian: "Espira", .spanish: "Exhala", .portuguese: "Expire", .japanese: "吐く", .korean: "내쉬어요"]) }

        static var rideTheUrge: String { Strings.localized("Let the urge pass →", [.simplifiedChinese: "继续乘风破浪 →", .traditionalChinese: "繼續乘風破浪 →", .german: "Verlangen abklingen lassen →", .french: "Laisser passer l’envie →", .italian: "Lascia passare la voglia →", .spanish: "Deja pasar las ganas →", .portuguese: "Deixe a vontade passar →", .japanese: "吸いたい気持ちをやり過ごす →", .korean: "흡연 욕구 넘기기 →"]) }
        static var imFineNow: String { Strings.localized("I'm fine now", [.simplifiedChinese: "我现在好多了", .traditionalChinese: "我現在好多了", .german: "Mir geht es jetzt gut", .french: "Ça va mieux", .italian: "Ora sto bene", .spanish: "Ahora estoy bien", .portuguese: "Estou bem agora", .japanese: "もう大丈夫", .korean: "이제 괜찮아요"]) }
        static var stillHere: String { Strings.localized("Still here — try something else", [.simplifiedChinese: "还在想抽？试试别的", .traditionalChinese: "還在想抽？試試別的", .german: "Noch da — probier etwas anderes", .french: "Toujours là — essaie autre chose", .italian: "Ancora qui — prova altro", .spanish: "¿Sigues ahí? Prueba otra cosa", .portuguese: "Ainda aqui — tente outra coisa", .japanese: "まだつらい？別の方法を試す", .korean: "아직 힘든가요 — 다른 방법을 써 보세요"]) }
    }

    enum SOS {
        static var startTitle: String { Strings.localized("What do you need right now?", [
            .simplifiedChinese: "现在需要什么？", .traditionalChinese: "現在需要什麼？", .german: "Was brauchst du gerade?",
            .french: "De quoi as-tu besoin maintenant ?", .italian: "Di cosa hai bisogno adesso?",
            .spanish: "¿Qué necesitas ahora?", .portuguese: "O que você precisa agora?",
            .japanese: "今、必要なのは？", .korean: "지금 필요한 건 무엇인가요?"
        ]) }
        static var startSubtitle: String { Strings.localized("Pick a situation if you know it. You can change this later.", [
            .simplifiedChinese: "知道诱因就先选一个，之后也可以修改。", .traditionalChinese: "知道誘因就先選一個，之後也可以修改。",
            .german: "Wähle eine Situation, wenn du sie kennst. Du kannst das später ändern.",
            .french: "Choisis une situation si tu la connais. Tu pourras changer plus tard.",
            .italian: "Scegli una situazione, se la riconosci. Potrai cambiarla dopo.",
            .spanish: "Elige una situación si la reconoces. Puedes cambiarla después.",
            .portuguese: "Escolha uma situação, se souber qual é. Você pode mudar depois.",
            .japanese: "思い当たる場面があれば選んでください。あとで変更できます。",
            .korean: "상황을 알고 있다면 골라 주세요. 나중에 바꿀 수 있어요."
        ]) }
        static var suggestedEyebrow: String { Strings.localized("Your next move", [
            .simplifiedChinese: "下一步", .traditionalChinese: "下一步", .german: "Dein nächster Schritt",
            .french: "Ton prochain geste", .italian: "La tua prossima mossa", .spanish: "Tu próximo paso",
            .portuguese: "Seu próximo passo", .japanese: "次にすること", .korean: "다음 행동"
        ]) }
        static func suggestedBody(tool: String, beatenCount: Int, attemptCount: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "你用「\(tool)」撑过了 \(attemptCount) 次类似时刻中的 \(beatenCount) 次。要不要再试一次？"
            case .traditionalChinese: return "你用「\(tool)」撐過了 \(attemptCount) 次類似時刻中的 \(beatenCount) 次。要不要再試一次？"
            case .german: return "Mit \(tool) hast du \(beatenCount) von \(attemptCount) ähnlichen Momenten geschafft. Noch einmal?"
            case .french: return "Avec \(tool), tu as traversé \(beatenCount) moments similaires sur \(attemptCount). On réessaie ?"
            case .italian: return "Con \(tool) hai superato \(beatenCount) momenti simili su \(attemptCount). Vuoi riprovarci?"
            case .spanish: return "Con \(tool) superaste \(beatenCount) de \(attemptCount) momentos parecidos. ¿Lo intentamos otra vez?"
            case .portuguese: return "Com \(tool), você superou \(beatenCount) de \(attemptCount) momentos parecidos. Tentamos de novo?"
            case .japanese: return "\(tool)で、似た場面を\(attemptCount)回中\(beatenCount)回乗り越えました。もう一度試しますか？"
            case .korean: return "\(tool)로 비슷한 순간 \(attemptCount)번 중 \(beatenCount)번을 넘겼어요. 다시 해볼까요?"
            default: return "You got through \(beatenCount) of \(attemptCount) similar moments with \(tool). Worth trying again?"
            }
        }
        static var setAsDefault: String { Strings.localized("Use this by default", [
            .simplifiedChinese: "设为默认", .traditionalChinese: "設為預設", .german: "Standardmäßig verwenden",
            .french: "Utiliser par défaut", .italian: "Usa come predefinito", .spanish: "Usar por defecto",
            .portuguese: "Usar como padrão", .japanese: "デフォルトにする", .korean: "기본으로 사용"
        ]) }
        static var defaultSaved: String { Strings.localized("Default saved", [
            .simplifiedChinese: "已设为默认", .traditionalChinese: "已設為預設", .german: "Als Standard gespeichert",
            .french: "Enregistré par défaut", .italian: "Salvato come predefinito", .spanish: "Guardado por defecto",
            .portuguese: "Salvo como padrão", .japanese: "デフォルトに保存", .korean: "기본값으로 저장됨"
        ]) }
        static var noHistory: String { Strings.localized("No personal pattern yet — choose the tool that feels right.", [
            .simplifiedChinese: "还没有个人规律，先选一个适合你的工具。", .traditionalChinese: "還沒有個人規律，先選一個適合你的工具。",
            .german: "Noch kein persönliches Muster — wähle das Werkzeug, das sich richtig anfühlt.",
            .french: "Pas encore de tendance personnelle — choisis l'outil qui te convient.",
            .italian: "Nessuno schema personale ancora — scegli lo strumento che senti giusto.",
            .spanish: "Aún no hay un patrón personal: elige la herramienta que te venga bien.",
            .portuguese: "Ainda não há um padrão pessoal — escolha a ferramenta que fizer sentido.",
            .japanese: "まだ個人の傾向はありません。合うツールを選んでください。",
            .korean: "아직 개인 패턴이 없어요. 마음에 맞는 도구를 골라 주세요."
        ]) }
        static var contextLabel: String { Strings.localized("What set it off?", [
            .simplifiedChinese: "是什么引发的？", .traditionalChinese: "是什麼引發的？", .german: "Was hat es ausgelöst?",
            .french: "Qu'est-ce qui a déclenché l'envie ?", .italian: "Cosa l'ha scatenata?", .spanish: "¿Qué lo desencadenó?",
            .portuguese: "O que desencadeou isso?", .japanese: "きっかけは？", .korean: "무엇이 시작하게 했나요?"
        ]) }
        static var contextLater: String { Strings.localized("Choose later", [
            .simplifiedChinese: "稍后选择", .traditionalChinese: "稍後選擇", .german: "Später auswählen",
            .french: "Choisir plus tard", .italian: "Scegli dopo", .spanish: "Elegir más tarde",
            .portuguese: "Escolher depois", .japanese: "あとで選ぶ", .korean: "나중에 선택"
        ]) }

        static var toolboxTitle: String { Strings.localized("Still here. Let's redirect.", [
            .simplifiedChinese: "还在想抽？换个方向。", .traditionalChinese: "還在想抽？換個方向。", .german: "Noch da? Lenken wir um.", .french: "Toujours là ? Changeons de direction.", .italian: "Ci sei ancora? Cambiamo direzione.", .spanish: "¿Sigues ahí? Cambiemos de rumbo.", .portuguese: "Ainda aqui? Vamos mudar o foco.", .japanese: "まだつらい？別の方向へ切り替えよう。", .korean: "아직 힘든가요? 다른 쪽으로 돌려 볼게요."
        ]) }
        static var toolboxSubtitle: String { Strings.localized("Pick anything — action can help more than waiting it out.", [
            .simplifiedChinese: "选一个就好，做点事往往比干等更有帮助。", .traditionalChinese: "選一個就好，做點事往往比乾等更有幫助。", .german: "Wähle etwas aus — Handeln hilft oft mehr als Abwarten.", .french: "Choisis une action : agir aide souvent plus qu’attendre.", .italian: "Scegli qualcosa: agire aiuta più che aspettare.", .spanish: "Elige algo: actuar suele ayudar más que esperar.", .portuguese: "Escolha algo: agir costuma ajudar mais do que esperar.", .japanese: "どれか1つ選んで。待つより、動くほうが楽になることがあります。", .korean: "하나를 골라 보세요. 기다리는 것보다 움직이는 게 도움이 될 때가 있어요."
        ]) }

        static var delayTitle: String { Strings.localized("Wait 4 minutes", [.simplifiedChinese: "先等 4 分钟", .traditionalChinese: "先等 4 分鐘", .german: "4 Minuten warten", .french: "Attendre 4 minutes", .italian: "Aspetta 4 minuti", .spanish: "Espera 4 minutos", .portuguese: "Espere 4 minutos", .japanese: "まず4分待つ", .korean: "4분만 기다리기"]) }
        static var delaySubtitle: String { Strings.localized("Change rooms, then decide.", [.simplifiedChinese: "换个房间，再决定。", .traditionalChinese: "換個房間，再決定。", .german: "Wechsle den Raum und entscheide dann.", .french: "Change de pièce, puis décide.", .italian: "Cambia stanza, poi decidi.", .spanish: "Cambia de habitación y decide después.", .portuguese: "Mude de cômodo e decida depois.", .japanese: "場所を変えてから決めよう。", .korean: "방을 바꾼 뒤 결정해요."]) }
        static var delayDone: String { Strings.localized("Time's up — how do you feel?", [.simplifiedChinese: "时间到了——现在感觉如何？", .traditionalChinese: "時間到了——現在感覺如何？", .german: "Die Zeit ist um — wie fühlst du dich?", .french: "Le temps est écoulé — comment te sens-tu ?", .italian: "Tempo scaduto — come ti senti?", .spanish: "Se acabó el tiempo: ¿cómo te sientes?", .portuguese: "O tempo acabou — como você se sente?", .japanese: "時間です。今はどう感じる？", .korean: "시간이 끝났어요 — 지금 기분은 어때요?"]) }

        static var iceTitle: String { Strings.localized("Ice water", [.simplifiedChinese: "冰水", .traditionalChinese: "冰水", .german: "Eiswasser", .french: "Eau glacée", .italian: "Acqua ghiacciata", .spanish: "Agua fría", .portuguese: "Água gelada", .japanese: "冷たい水", .korean: "찬물"]) }
        static var iceSubtitle: String { Strings.localized("A quick shock to the system.", [.simplifiedChinese: "给身体一个短暂的刺激。", .traditionalChinese: "給身體一個短暫的刺激。", .german: "Ein kurzer Reiz für den Körper.", .french: "Un bref choc pour le corps.", .italian: "Un rapido stimolo per il corpo.", .spanish: "Un estímulo rápido para el cuerpo.", .portuguese: "Um estímulo rápido para o corpo.", .japanese: "体に短い刺激を。", .korean: "몸에 짧은 자극을 주세요."]) }
        static var iceToast: String { Strings.localized("Cold water on your wrists or face — 20 seconds.", [.simplifiedChinese: "用冷水冲手腕或脸 20 秒。", .traditionalChinese: "用冷水沖手腕或臉 20 秒。", .german: "20 Sekunden kaltes Wasser an Handgelenken oder Gesicht.", .french: "De l’eau froide sur les poignets ou le visage — 20 secondes.", .italian: "Acqua fredda su polsi o viso — 20 secondi.", .spanish: "Agua fría en las muñecas o la cara — 20 segundos.", .portuguese: "Água fria nos pulsos ou no rosto — 20 segundos.", .japanese: "手首か顔に冷水を20秒。", .korean: "손목이나 얼굴에 찬물을 20초 대 보세요."]) }

        static var moveTitle: String { Strings.localized("Move for 20 seconds", [.simplifiedChinese: "动一动，20 秒", .traditionalChinese: "動一動，20 秒", .german: "20 Sekunden bewegen", .french: "Bouger 20 secondes", .italian: "Muoviti per 20 secondi", .spanish: "Muévete 20 segundos", .portuguese: "Mexa-se por 20 segundos", .japanese: "20秒だけ体を動かす", .korean: "20초 동안 움직이기"]) }
        static var moveSubtitle: String { Strings.localized("A little movement can help.", [.simplifiedChinese: "起来活动一下。", .traditionalChinese: "起來活動一下。", .german: "Bewegung kann jetzt guttun.", .french: "Bouger un peu peut aider.", .italian: "Un po’ di movimento può aiutare.", .spanish: "Moverte un poco puede ayudar.", .portuguese: "Mexer o corpo pode ajudar.", .japanese: "少し体を動かしてみましょう。", .korean: "몸을 조금 움직여 보세요."]) }
        static var moveToast: String { Strings.localized("20 jumping jacks, or a lap around the room.", [.simplifiedChinese: "做 20 个开合跳，或绕房间走一圈。", .traditionalChinese: "做 20 個開合跳，或繞房間走一圈。", .german: "20 Hampelmänner oder eine Runde durch den Raum.", .french: "20 jumping jacks ou un tour de la pièce.", .italian: "20 jumping jack o un giro per la stanza.", .spanish: "20 saltos de tijera o una vuelta por la habitación.", .portuguese: "20 polichinelos ou uma volta pelo cômodo.", .japanese: "ジャンピングジャックを20回、または部屋を一周。", .korean: "팔벌려뛰기 20회나 방 한 바퀴 걷기."]) }

        static var nrtTitle: String { Strings.localized("Nicotine replacement", [.simplifiedChinese: "尼古丁替代品", .traditionalChinese: "尼古丁替代品", .german: "Nikotinersatz", .french: "Substituts nicotiniques", .italian: "Sostituti della nicotina", .spanish: "Sustitutos de nicotina", .portuguese: "Reposição de nicotina", .japanese: "ニコチン代替品", .korean: "니코틴 대체제"]) }
        static var nrtSubtitle: String { Strings.localized("Gum, patch, or lozenge.", [.simplifiedChinese: "口香糖、贴片或含片。", .traditionalChinese: "口香糖、貼片或含片。", .german: "Kaugummi, Pflaster oder Lutschtablette.", .french: "Gomme, patch ou pastille.", .italian: "Gomma, cerotto o pastiglia.", .spanish: "Chicle, parche o pastilla.", .portuguese: "Goma, adesivo ou pastilha.", .japanese: "ガム、パッチ、トローチ。", .korean: "껌, 패치 또는 로젠지."]) }
        static var nrtToast: String { Strings.localized("If you've got gum or a patch on hand, now's a good time.", [.simplifiedChinese: "手边有口香糖或贴片的话，现在正好用上。", .traditionalChinese: "手邊有口香糖或貼片的話，現在正好用上。", .german: "Wenn du Kaugummi oder ein Pflaster hast, ist jetzt ein guter Moment.", .french: "Si tu as une gomme ou un patch, c’est le bon moment.", .italian: "Se hai gomma o cerotto, questo è un buon momento.", .spanish: "Si tienes chicle o parche, este es un buen momento.", .portuguese: "Se você tem goma ou adesivo, agora é uma boa hora.", .japanese: "ガムやパッチがあれば、今使ってみましょう。", .korean: "껌이나 패치가 있다면 지금 사용해 보세요."]) }

        static var whyTitle: String { Strings.localized("Why I want to quit", [.simplifiedChinese: "我想戒烟的理由", .traditionalChinese: "我想戒菸的理由", .german: "Warum ich aufhören will", .french: "Pourquoi je veux arrêter", .italian: "Perché voglio smettere", .spanish: "Por qué quiero dejarlo", .portuguese: "Por que quero parar", .japanese: "やめたい理由", .korean: "내가 끊고 싶은 이유"]) }
        static var whySubtitle: String { Strings.localized("Your reason, on demand.", [.simplifiedChinese: "随时提醒自己原因。", .traditionalChinese: "隨時提醒自己原因。", .german: "Dein Grund, wenn du ihn brauchst.", .french: "Ta raison, à portée de main.", .italian: "Il tuo motivo, quando serve.", .spanish: "Tu motivo, cuando lo necesites.", .portuguese: "Seu motivo, quando precisar.", .japanese: "いつでも理由を思い出す。", .korean: "필요할 때 이유를 떠올려요."]) }
        static var whyToast: String { Strings.localized("Whatever brought you here — it's still true right now.", [.simplifiedChinese: "无论当初为什么开始，这个理由现在依然成立。", .traditionalChinese: "無論當初為什麼開始，這個理由現在依然成立。", .german: "Was dich hierher gebracht hat — es gilt auch jetzt.", .french: "La raison qui t’a amené ici est toujours valable.", .italian: "Qualunque sia il motivo, vale ancora adesso.", .spanish: "Sea cual sea tu motivo, sigue siendo válido ahora.", .portuguese: "Seja qual for o motivo, ele continua valendo agora.", .japanese: "ここに来た理由は、今も変わりません。", .korean: "여기까지 온 이유는 지금도 여전히 유효해요."]) }

        static var feelBetter: String { Strings.localized("I feel better — log it", [.simplifiedChinese: "感觉好些了——记录下来", .traditionalChinese: "感覺好些了——記錄下來", .german: "Ich fühle mich besser — eintragen", .french: "Je vais mieux — noter", .italian: "Sto meglio — registra", .spanish: "Estoy mejor — registrarlo", .portuguese: "Estou melhor — registrar", .japanese: "楽になった — 記録する", .korean: "괜찮아졌어요 — 기록하기"]) }
        static var stillSmoked: String { Strings.localized("I had a slip", [.simplifiedChinese: "我还是抽了", .traditionalChinese: "我還是抽了", .german: "Ich bin ausgerutscht", .french: "J’ai craqué", .italian: "Ho avuto uno scivolone", .spanish: "Tuve un desliz", .portuguese: "Tive um deslize", .japanese: "吸ってしまった", .korean: "한 번 피웠어요"]) }
    }

    enum Log {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }
        static var title: String { t("Quick log", [.simplifiedChinese: "记一下", .traditionalChinese: "記一下", .german: "Kurz eintragen", .french: "Noter ce moment", .italian: "Registra il momento", .spanish: "Registrar el momento", .portuguese: "Registrar o momento", .japanese: "記録する", .korean: "간단히 기록"]) }
        static var triggerQuestion: String { t("What set it off?", [.simplifiedChinese: "是什么让你想抽？", .traditionalChinese: "是什麼讓你想抽？", .german: "Was hat das Verlangen ausgelöst?", .french: "Qu’est-ce qui a déclenché l’envie ?", .italian: "Che cosa ha fatto partire la voglia?", .spanish: "¿Qué despertó las ganas?", .portuguese: "O que despertou a vontade?", .japanese: "きっかけは何でしたか？", .korean: "무엇 때문에 피우고 싶어졌나요?"]) }
        static var intensityQuestion: String { t("How strong was the urge?", [.simplifiedChinese: "刚才有多想抽？", .traditionalChinese: "剛才有多想抽？", .german: "Wie stark war das Verlangen?", .french: "L’envie était forte à quel point ?", .italian: "Quanto era forte la voglia?", .spanish: "¿Qué tan fuertes eran las ganas?", .portuguese: "Quão forte estava a vontade?", .japanese: "どのくらい吸いたくなりましたか？", .korean: "얼마나 피우고 싶었나요?"]) }
        static var submit: String { t("Save", [.simplifiedChinese: "保存记录", .traditionalChinese: "儲存記錄", .german: "Speichern", .french: "Enregistrer", .italian: "Salva", .spanish: "Guardar", .portuguese: "Salvar", .japanese: "記録する", .korean: "기록 저장"]) }

        static var victoryTitle: String { t("You got through it.", [.simplifiedChinese: "这次，你撑过去了。", .traditionalChinese: "這次，你撐過去了。", .german: "Du hast es geschafft.", .french: "Tu as tenu bon.", .italian: "Ce l’hai fatta.", .spanish: "Lo superaste.", .portuguese: "Você conseguiu passar por isso.", .japanese: "乗り越えられました。", .korean: "이번엔 잘 넘겼어요."]) }
        static func victorySubtitle(money: String, momentum: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: "省下 \(money) · 动力 +\(momentum)"
            case .traditionalChinese: "省下 \(money) · 動力 +\(momentum)"
            case .german: "\(money) gespart · Schwung +\(momentum)"
            case .french: "\(money) économisés · Élan +\(momentum)"
            case .italian: "\(money) risparmiati · Slancio +\(momentum)"
            case .spanish: "\(money) ahorrados · Impulso +\(momentum)"
            case .portuguese: "\(money) economizados · Ritmo +\(momentum)"
            case .japanese: "\(money)節約 · 勢い +\(momentum)"
            case .korean: "\(money) 절약 · 동력 +\(momentum)"
            default: "Saved \(money) · Momentum +\(momentum)"
            }
        }
    }

    enum Relapse {
        static var logged: String { Strings.localized("It's recorded.", [.simplifiedChinese: "已经记下了。", .traditionalChinese: "已經記下了。", .german: "Es ist eingetragen.", .french: "C’est noté.", .italian: "L’hai registrato.", .spanish: "Ya quedó registrado.", .portuguese: "Já está registrado.", .japanese: "記録しました。", .korean: "기록했어요."]) }
        static func winsStillCount(_ n: Int) -> String {
            if n == 0 {
                return Strings.localized("Your progress is still here.", [.simplifiedChinese: "你的进度还在。", .traditionalChinese: "你的進度還在。", .german: "Dein Fortschritt bleibt.", .french: "Tes progrès restent là.", .italian: "I tuoi progressi restano.", .spanish: "Tu progreso sigue ahí.", .portuguese: "Seu progresso continua aqui.", .japanese: "これまでの歩みは消えません。", .korean: "지금까지의 기록은 그대로예요."])
            }
            return switch AppLanguage.current.effective {
            case .simplifiedChinese: "之前撑过的 \(n) 次，仍然算数。"
            case .traditionalChinese: "之前撐過的 \(n) 次，依然算數。"
            case .german: "Deine \(n) geschafften Momente zählen weiter."
            case .french: "Tes \(n) envies surmontées comptent toujours."
            case .italian: "Le \(n) voglie superate contano ancora."
            case .spanish: "Las \(n) veces que resististe siguen contando."
            case .portuguese: "As \(n) vezes em que você resistiu continuam valendo."
            case .japanese: "これまで乗り越えた\(n)回は、そのまま残ります。"
            case .korean: "이전에 넘긴 \(n)번은 그대로 남아요."
            default: "Your \(n) previous wins still count."
            }
        }
        static var neverReset: String { Strings.localized("One cigarette doesn't erase them.", [.simplifiedChinese: "抽了这一支，也不会让它们清零。", .traditionalChinese: "抽了這一支，也不會讓它們歸零。", .german: "Eine Zigarette löscht sie nicht aus.", .french: "Une cigarette ne les efface pas.", .italian: "Una sigaretta non li cancella.", .spanish: "Un cigarrillo no los borra.", .portuguese: "Um cigarro não apaga isso.", .japanese: "1本吸っても、これまでの記録は消えません。", .korean: "담배 한 개비가 그 기록을 지우지는 않아요."]) }
        static var back: String { Strings.localized("Back", [.simplifiedChinese: "返回", .traditionalChinese: "返回", .german: "Zurück", .french: "Retour", .italian: "Indietro", .spanish: "Volver", .portuguese: "Voltar", .japanese: "戻る", .korean: "돌아가기"]) }
    }

    enum ReductionGoal {
        static var cardTitlePrompt: String { Strings.localized("Set a daily goal", [
            .simplifiedChinese: "设定每日目标", .traditionalChinese: "設定每日目標", .german: "Tagesziel festlegen", .french: "Fixer un objectif quotidien",
            .italian: "Imposta un obiettivo giornaliero", .spanish: "Define un objetivo diario", .portuguese: "Defina uma meta diária", .japanese: "1日の目標を設定", .korean: "하루 목표 설정"
        ]) }
        static var cardSubtitlePrompt: String { Strings.localized("See your progress against a target you choose.", [
            .simplifiedChinese: "按你选择的目标查看进展。", .traditionalChinese: "按你選擇的目標查看進度。", .german: "Sieh deinen Fortschritt an deinem Ziel.", .french: "Suis tes progrès par rapport à ton objectif.",
            .italian: "Segui i progressi rispetto al tuo obiettivo.", .spanish: "Mira tu progreso frente al objetivo que elijas.", .portuguese: "Acompanhe seu progresso em relação à meta escolhida.", .japanese: "選んだ目標に対する進み具合を確認できます。", .korean: "정한 목표에 따른 진행 상황을 확인해 보세요."
        ]) }
        static var setGoalCTA: String { Strings.localized("Set goal", [
            .simplifiedChinese: "设定目标", .traditionalChinese: "設定目標", .german: "Ziel festlegen", .french: "Fixer l’objectif", .italian: "Imposta obiettivo", .spanish: "Definir objetivo", .portuguese: "Definir meta", .japanese: "目標を設定", .korean: "목표 설정"
        ]) }

        static var goalQuestion: String { Strings.localized("What's a realistic target for today?", [
            .simplifiedChinese: "今天设定多少比较合适？", .traditionalChinese: "今天設定多少比較合適？", .german: "Welches Ziel ist heute realistisch?", .french: "Quel objectif est réaliste aujourd’hui ?", .italian: "Qual è un obiettivo realistico per oggi?", .spanish: "¿Qué objetivo es realista para hoy?", .portuguese: "Qual é uma meta realista para hoje?", .japanese: "今日の現実的な目標は？", .korean: "오늘 현실적인 목표는 얼마인가요?"
        ]) }
        static var goalSave: String { Strings.localized("Save", [
            .simplifiedChinese: "保存", .traditionalChinese: "儲存", .german: "Speichern", .french: "Enregistrer", .italian: "Salva", .spanish: "Guardar", .portuguese: "Salvar", .japanese: "保存", .korean: "저장"
        ]) }

        static func todayProgress(smoked: Int, target: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "今天已抽 \(smoked) 支 · 计划不超过 \(target) 支"
            case .traditionalChinese: return "今天已抽 \(smoked) 支 · 計畫不超過 \(target) 支"
            case .german: return "Heute \(smoked) geraucht · höchstens \(target) geplant"
            case .french: return "Aujourd’hui : \(smoked) fumées · pas plus de \(target) prévues"
            case .italian: return "Oggi ne hai fumate \(smoked) · limite previsto: \(target)"
            case .spanish: return "Hoy has fumado \(smoked) · te propusiste no pasar de \(target)"
            case .portuguese: return "Hoje você fumou \(smoked) · meta de no máximo \(target)"
            case .japanese: return "今日は\(smoked)本 · \(target)本以下を目指す"
            case .korean: return "오늘 \(smoked)개비 · \(target)개비 이하로 줄이기"
            default: return "Smoked \(smoked) today · aiming for \(target) or fewer"
            }
        }

        static var proposalTitle: String { Strings.localized("You've met your goal for two weeks.", [.simplifiedChinese: "你已经连续两周达到目标。", .traditionalChinese: "你已經連續兩週達到目標。", .german: "Du hast dein Ziel zwei Wochen lang erreicht.", .french: "Tu as tenu ton objectif pendant deux semaines.", .italian: "Hai raggiunto il tuo obiettivo per due settimane.", .spanish: "Llevas dos semanas cumpliendo tu objetivo.", .portuguese: "Você bateu sua meta por duas semanas.", .japanese: "2週間、目標を達成できました。", .korean: "2주 동안 목표를 지켰어요."]) }
        static var proposalBody: String { Strings.localized("If you're ready, you can choose a day to stop. You can also keep reducing at your own pace.", [.simplifiedChinese: "如果愿意，可以选一天开始戒烟。想继续按自己的节奏减量，也完全可以。", .traditionalChinese: "如果願意，可以選一天開始戒菸。想繼續按自己的步調減量，也可以。", .german: "Wenn du bereit bist, kannst du einen Tag zum Aufhören wählen. Du kannst auch in deinem Tempo weiter reduzieren.", .french: "Si tu te sens prêt, tu peux choisir un jour pour arrêter. Tu peux aussi continuer à réduire à ton rythme.", .italian: "Se te la senti, puoi scegliere il giorno in cui smettere. Oppure puoi continuare a ridurre con i tuoi tempi.", .spanish: "Si te apetece, puedes elegir un día para dejarlo. También puedes seguir reduciendo a tu ritmo.", .portuguese: "Se quiser, você pode escolher um dia para parar. Também pode continuar reduzindo no seu ritmo.", .japanese: "準備ができていたら、やめる日を決められます。自分のペースで本数を減らし続けても大丈夫です。", .korean: "준비가 됐다면 금연 날짜를 정해 보세요. 내 속도대로 조금씩 줄여도 괜찮아요."]) }
        static var proposalAccept: String { Strings.localized("Choose a quit day", [.simplifiedChinese: "选一个戒烟日", .traditionalChinese: "選一個戒菸日", .german: "Stopp-Tag wählen", .french: "Choisir une date d’arrêt", .italian: "Scegli il giorno", .spanish: "Elegir fecha", .portuguese: "Escolher uma data", .japanese: "やめる日を決める", .korean: "금연 날짜 정하기"]) }
        static var proposalDecline: String { Strings.localized("Not now", [.simplifiedChinese: "暂时不定", .traditionalChinese: "暫時不訂", .german: "Noch nicht", .french: "Pas maintenant", .italian: "Non ora", .spanish: "Ahora no", .portuguese: "Agora não", .japanese: "今は決めない", .korean: "지금은 정하지 않을게요"]) }

        static var quitDateQuestion: String { Strings.localized("When would you like to stop smoking?", [.simplifiedChinese: "你想从哪天开始不抽？", .traditionalChinese: "你想從哪天開始不抽？", .german: "Ab wann möchtest du nicht mehr rauchen?", .french: "À partir de quand aimerais-tu arrêter ?", .italian: "Da quale giorno vorresti smettere?", .spanish: "¿Qué día te gustaría dejarlo?", .portuguese: "Em que dia você gostaria de parar?", .japanese: "いつから吸わない日にしますか？", .korean: "언제부터 담배를 끊고 싶나요?"]) }
        static var quitDateSave: String { Strings.localized("Save date", [.simplifiedChinese: "保存日期", .traditionalChinese: "儲存日期", .german: "Datum speichern", .french: "Enregistrer la date", .italian: "Salva la data", .spanish: "Guardar fecha", .portuguese: "Salvar data", .japanese: "日付を保存", .korean: "날짜 저장"]) }
    }

    enum Report {
        static var chartHour: String { Strings.localized("Hour", [.simplifiedChinese: "小时", .traditionalChinese: "小時", .german: "Uhrzeit", .french: "Heure", .italian: "Ora", .spanish: "Hora", .portuguese: "Hora", .japanese: "時刻", .korean: "시간"]) }
        static var chartCount: String { Strings.localized("Count", [.simplifiedChinese: "次数", .traditionalChinese: "次數", .german: "Anzahl", .french: "Nombre", .italian: "Numero", .spanish: "Cantidad", .portuguese: "Quantidade", .japanese: "回数", .korean: "횟수"]) }
        static var chartMonthAxis: String { Strings.localized("Month", [.simplifiedChinese: "月份", .traditionalChinese: "月份", .german: "Monat", .french: "Mois", .italian: "Mese", .spanish: "Mes", .portuguese: "Mês", .japanese: "月", .korean: "월"]) }
        static var chartSavedAxis: String { Strings.localized("Saved", [.simplifiedChinese: "已省下", .traditionalChinese: "已省下", .german: "Gespart", .french: "Économies", .italian: "Risparmi", .spanish: "Ahorro", .portuguese: "Economia", .japanese: "節約額", .korean: "절약액"]) }
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }

        static var title: String { t("Progress", [
            .simplifiedChinese: "进展", .traditionalChinese: "進度", .german: "Fortschritt",
            .french: "Progrès", .italian: "Progressi", .spanish: "Progreso", .portuguese: "Progresso",
            .japanese: "進捗", .korean: "진행"
        ]) }

        static var milestonesTitle: String { t("Milestones", [
            .simplifiedChinese: "里程碑", .traditionalChinese: "里程碑", .german: "Meilensteine",
            .french: "Jalons", .italian: "Traguardi", .spanish: "Hitos", .portuguese: "Conquistas",
            .japanese: "マイルストーン", .korean: "마일스톤"
        ]) }
        static func milestoneLabel(_ count: Int) -> String {
            let formatted = count.formatted(.number.locale(AppLanguage.current.locale))
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "已撑过 " + formatted + " 次"
            case .traditionalChinese: return "已撐過 " + formatted + " 次"
            case .german: return formatted + " geschafft"
            case .french: return formatted + " surmontées"
            case .italian: return formatted + " superate"
            case .spanish: return formatted + " superados"
            case .portuguese: return formatted + " superados"
            case .japanese: return formatted + " 回達成"
            case .korean: return formatted + "번 넘김"
            default: return formatted + " beaten"
            }
        }
        static var notEnoughData: String { t("Not enough data yet — log a few more cravings this week.", [
            .simplifiedChinese: "数据还不够——这周再记录几次想抽的时刻。", .traditionalChinese: "資料還不夠——這週再記錄幾次想抽的時刻。",
            .german: "Noch nicht genug Daten — protokolliere diese Woche ein paar weitere Momente.",
            .french: "Pas encore assez de données — note encore quelques envies cette semaine.",
            .italian: "Non ci sono ancora abbastanza dati: registra qualche altra voglia questa settimana.",
            .spanish: "Aún faltan datos: registra algunos impulsos más esta semana.",
            .portuguese: "Ainda faltam dados — registre mais alguns desejos esta semana.",
            .japanese: "まだデータが足りません。今週、もう少し記録してみてください。",
            .korean: "아직 데이터가 부족해요. 이번 주에 몇 번 더 기록해 보세요."
        ]) }

        static var lockedTitle: String { t("Unlock with Decrave Pro", [.simplifiedChinese: "解锁 Decrave Pro", .traditionalChinese: "解鎖 Decrave Pro", .german: "Mit Decrave Pro freischalten", .french: "Déverrouiller avec Decrave Pro", .italian: "Sblocca con Decrave Pro", .spanish: "Desbloquear con Decrave Pro", .portuguese: "Desbloquear com Decrave Pro", .japanese: "Decrave Proで解放", .korean: "Decrave Pro 잠금 해제"]) }
        static var lockedBody: String { t("See your patterns over time — peak hours, top triggers, and trends. Everything you need to beat a craving stays free.", [.simplifiedChinese: "查看一段时间里的规律——高峰时段、主要诱因和趋势。撑过想抽时刻所需的工具始终免费。", .traditionalChinese: "查看一段時間裡的規律——高峰時段、主要誘因和趨勢。撐過想抽時刻所需的工具始終免費。", .german: "Sieh Muster über die Zeit — Spitzenzeiten, Auslöser und Trends. Alles für den nächsten Moment bleibt kostenlos.", .french: "Découvre tes tendances — pics, déclencheurs et évolutions. Les outils essentiels restent gratuits.", .italian: "Scopri i tuoi schemi nel tempo — picchi, trigger e tendenze. Gli strumenti essenziali restano gratuiti.", .spanish: "Mira tus patrones — horas punta, desencadenantes y tendencias. Las herramientas esenciales siguen siendo gratis.", .portuguese: "Veja seus padrões — horários de pico, gatilhos e tendências. O essencial continua gratuito.", .japanese: "時間ごとの傾向やきっかけを確認できます。欲求を乗り越える基本ツールは無料です。", .korean: "시간별 패턴과 요인을 확인해 보세요. 욕구를 넘기는 기본 도구는 계속 무료예요."]) }
        static var unlockCTA: String { t("See plans", [.simplifiedChinese: "查看方案", .traditionalChinese: "查看方案", .german: "Pläne ansehen", .french: "Voir les offres", .italian: "Vedi piani", .spanish: "Ver planes", .portuguese: "Ver planos", .japanese: "プランを見る", .korean: "플랜 보기"]) }

        // Section-level locks (see ProLockedSection) — the two deeper,
        // predictive layers plus peak hours stay Pro; Craving intensity /
        // Top triggers / Money trajectory above are free, matching
        // Decrave's own free/Pro boundary.
        static var unlockInsightsCTA: String { t("Unlock deep insights", [
            .simplifiedChinese: "解锁深度洞察", .traditionalChinese: "解鎖深度洞察", .german: "Tiefe Einblicke freischalten",
            .french: "Déverrouiller les analyses détaillées", .italian: "Sblocca gli insight avanzati",
            .spanish: "Desbloquear análisis avanzados", .portuguese: "Desbloquear insights detalhados",
            .japanese: "詳しい分析を解放", .korean: "심층 인사이트 잠금 해제"
        ]) }
        static var unlockRadarCTA: String { t("Unlock Trigger Radar", [
            .simplifiedChinese: "解锁诱因雷达", .traditionalChinese: "解鎖誘因雷達", .german: "Trigger-Radar freischalten",
            .french: "Déverrouiller le radar des déclencheurs", .italian: "Sblocca Trigger Radar",
            .spanish: "Desbloquear Radar de desencadenantes", .portuguese: "Desbloquear Radar de gatilhos",
            .japanese: "トリガーレーダーを解放", .korean: "트리거 레이더 잠금 해제"
        ]) }
        static var unlockPeakHoursCTA: String { t("Unlock peak hours", [
            .simplifiedChinese: "解锁高峰时段", .traditionalChinese: "解鎖高峰時段", .german: "Spitzenzeiten freischalten",
            .french: "Déverrouiller les heures de pointe", .italian: "Sblocca le ore di punta",
            .spanish: "Desbloquear horas punta", .portuguese: "Desbloquear horários de pico",
            .japanese: "ピーク時間を解放", .korean: "피크 시간 잠금 해제"
        ]) }

        static var peakHoursTitle: String { t("When cravings hit hardest", [
            .simplifiedChinese: "想抽的高峰时刻", .traditionalChinese: "想抽的高峰時刻", .german: "Wenn das Verlangen am stärksten ist", .french: "Quand l’envie est la plus forte",
            .italian: "Quando la voglia è più forte", .spanish: "Cuando el impulso pega más fuerte", .portuguese: "Quando o desejo aperta mais", .japanese: "欲求が強くなる時間帯", .korean: "욕구가 가장 강한 시간"
        ]) }
        static func peakHoursCaption(_ hour: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "想抽的时候大多在 \(hour) 左右。"
            case .traditionalChinese: return "想抽的時候大多在 \(hour) 左右。"
            case .german: return "Die meisten Momente kommen gegen \(hour)."
            case .french: return "La plupart des envies arrivent vers \(hour)."
            case .italian: return "La maggior parte delle voglie arriva verso le \(hour)."
            case .spanish: return "La mayoría de los impulsos aparece sobre las \(hour)."
            case .portuguese: return "A maioria dos desejos aparece por volta de \(hour)."
            case .japanese: return "欲求が強くなるのは \(hour) 頃です。"
            case .korean: return "대부분의 욕구는 \(hour)쯤 찾아와요."
            default: return "Most cravings hit around \(hour)."
            }
        }

        static var triggerRadarDetailTitle: String { t("Trigger Radar", [
            .simplifiedChinese: "诱因雷达", .traditionalChinese: "誘因雷達", .german: "Trigger-Radar", .french: "Radar des déclencheurs",
            .italian: "Trigger Radar", .spanish: "Radar de desencadenantes", .portuguese: "Radar de gatilhos", .japanese: "トリガーレーダー", .korean: "트리거 레이더"
        ]) }
        static func triggerRadarDetailBody(occurrences: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "基于这个时段目前记录的 " + String(occurrences) + " 次想抽时刻。"
            case .traditionalChinese: return "根據這個時段目前記錄的 " + String(occurrences) + " 次想抽時刻。"
            case .german: return "Basiert bisher auf " + String(occurrences) + " protokollierten Momenten in diesem Zeitfenster."
            case .french: return "Basé sur " + String(occurrences) + " envies notées dans ce créneau jusqu’ici."
            case .italian: return "In base alle " + String(occurrences) + " voglie registrate finora in questa fascia."
            case .spanish: return "Según los " + String(occurrences) + " impulsos registrados hasta ahora en este horario."
            case .portuguese: return "Com base nos " + String(occurrences) + " desejos registrados até agora neste horário."
            case .japanese: return "この時間帯にこれまで記録された欲求は " + String(occurrences) + " 回です。"
            case .korean: return "이 시간대에 지금까지 " + String(occurrences) + "번 기록된 욕구를 바탕으로 해요."
            default: return "Based on " + String(occurrences) + " logged cravings in this window so far."
            }
        }
        static var triggerRadarNotEnoughData: String { t("Log a few more cravings and Trigger Radar will start predicting your next window.", [
            .simplifiedChinese: "再记录几次想抽的时刻，诱因雷达就能开始预测下一个时段。",
            .traditionalChinese: "再記錄幾次想抽的時刻，誘因雷達就能開始預測下一個時段。",
            .german: "Protokolliere noch ein paar Momente, dann sagt der Trigger-Radar dein nächstes Zeitfenster voraus.",
            .french: "Note encore quelques envies pour que le radar puisse prévoir ton prochain créneau.",
            .italian: "Registra qualche altra voglia: Trigger Radar potrà prevedere la prossima finestra.",
            .spanish: "Registra algunos impulsos más y el Radar podrá predecir tu próxima franja.",
            .portuguese: "Registre mais alguns desejos para o Radar prever seu próximo horário.",
            .japanese: "もう少し記録すると、トリガーレーダーが次の時間帯を予測できるようになります。",
            .korean: "몇 번 더 기록하면 트리거 레이더가 다음 시간대를 예측해 줘요."
        ]) }

        static var moneyTrajectoryTitle: String { t("Money trajectory", [
            .simplifiedChinese: "省下的钱", .traditionalChinese: "省下的錢", .german: "Geldentwicklung",
            .french: "Évolution des économies", .italian: "Andamento dei risparmi", .spanish: "Evolución del ahorro",
            .portuguese: "Evolução da economia", .japanese: "節約額の推移", .korean: "절약 금액 추이"
        ]) }
        static func moneyTrajectoryCaption(_ amount: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "按现在的节奏，一年后大约能省下 \(amount)。"
            case .traditionalChinese: return "按現在的節奏，一年後大約能省下 \(amount)。"
            case .german: return "Bei deinem aktuellen Tempo sind das in einem Jahr \(amount)."
            case .french: return "À ce rythme, cela fera \(amount) économisés dans un an."
            case .italian: return "Con questo ritmo, tra un anno avrai risparmiato \(amount)."
            case .spanish: return "A este ritmo, dentro de un año habrás ahorrado \(amount)."
            case .portuguese: return "Nesse ritmo, daqui a um ano você terá economizado \(amount)."
            case .japanese: return "今のペースなら、1年後には \(amount) 節約できます。"
            case .korean: return "지금 속도라면 1년 후 \(amount)를 아끼게 돼요."
            default: return "At your current pace, that's \(amount) a year from now."
            }
        }

        static var cravingIntensityEyebrow: String { t("Craving intensity", [
            .simplifiedChinese: "想抽的强度", .traditionalChinese: "想抽的強度", .german: "Stärke des Verlangens",
            .french: "Intensité des envies", .italian: "Intensità delle voglie", .spanish: "Intensidad de los impulsos",
            .portuguese: "Intensidade dos desejos", .japanese: "欲求の強さ", .korean: "욕구 강도"
        ]) }
        static var cravingIntensityTitle: String { t("This week's intensity", [
            .simplifiedChinese: "本周的强度", .traditionalChinese: "本週的強度", .german: "Diese Woche",
            .french: "Cette semaine", .italian: "Questa settimana", .spanish: "Esta semana",
            .portuguese: "Esta semana", .japanese: "今週の強さ", .korean: "이번 주 강도"
        ]) }
        static func peakWindowCaption(weekday: String, hour: String) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "高峰时段：\(weekday) \(hour) 左右。"
            case .traditionalChinese: return "高峰時段：\(weekday) \(hour) 左右。"
            case .german: return "Häufigstes Zeitfenster: \(weekday) gegen \(hour)."
            case .french: return "Créneau le plus fréquent : \(weekday) vers \(hour)."
            case .italian: return "Fascia più frequente: \(weekday) verso le \(hour)."
            case .spanish: return "Franja más frecuente: \(weekday) sobre las \(hour)."
            case .portuguese: return "Horário mais comum: \(weekday) por volta de \(hour)."
            case .japanese: return "多い時間帯：\(weekday)の\(hour)頃。"
            case .korean: return "가장 잦은 시간대: \(weekday) \(hour)쯤."
            default: return "Peak window: \(weekday) around \(hour)."
            }
        }

        static var topTriggersEyebrow: String { t("Top triggers", [
            .simplifiedChinese: "常见诱因", .traditionalChinese: "常見誘因", .german: "Häufigste Auslöser",
            .french: "Déclencheurs principaux", .italian: "Trigger principali", .spanish: "Principales desencadenantes",
            .portuguese: "Principais gatilhos", .japanese: "主なきっかけ", .korean: "주요 유발 요인"
        ]) }
        static func triggerPercentage(_ percent: Int) -> String { "\(percent)%" }
        static var nextMoveEyebrow: String { t("Try this next", [
            .simplifiedChinese: "下一步试试", .traditionalChinese: "下一步試試", .german: "Als Nächstes",
            .french: "À essayer ensuite", .italian: "Prova ora", .spanish: "Prueba esto después",
            .portuguese: "Tente isto a seguir", .japanese: "次に試すこと", .korean: "다음에 해볼 일"
        ]) }
        static var chartNow: String { t("Now", [
            .simplifiedChinese: "现在", .traditionalChinese: "現在", .german: "Jetzt", .french: "Maintenant", .italian: "Ora", .spanish: "Ahora", .portuguese: "Agora", .japanese: "現在", .korean: "현재"
        ]) }
        static func chartMonth(_ month: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "\(month) 个月"
            case .traditionalChinese: return "\(month) 個月"
            case .german: return "\(month) Mon."
            case .french: return "\(month) mois"
            case .italian: return "\(month) mesi"
            case .spanish: return "\(month) meses"
            case .portuguese: return "\(month) meses"
            case .japanese: return "\(month)か月"
            case .korean: return "\(month)개월"
            default: return "\(month) mo"
            }
        }
    }

    enum Insights {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }
        static var sectionTitle: String { t("Insights", [.simplifiedChinese: "深入看看", .traditionalChinese: "深入看看", .german: "Einblicke", .french: "À retenir", .italian: "Approfondimenti", .spanish: "Lo que vemos", .portuguese: "Seus padrões", .japanese: "傾向を見てみる", .korean: "패턴 살펴보기"]) }

        static var commonTriggerTitle: String { t("Name the moment before you choose a tool", [
            .simplifiedChinese: "先认出诱因，再选应对方式", .traditionalChinese: "先認出誘因，再選應對方式", .german: "Erst den Auslöser erkennen, dann handeln", .french: "Repère d’abord ce qui déclenche l’envie", .italian: "Riconosci il momento, poi scegli cosa fare", .spanish: "Reconoce el momento antes de actuar", .portuguese: "Perceba o gatilho antes de agir", .japanese: "まずきっかけに気づく", .korean: "대처법을 고르기 전에 계기부터 살펴봐요"
        ]) }
        static func commonTriggerBody(trigger: CravingTrigger, count: Int) -> String {
            let label = trigger.label
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "你已记录 \(count) 次与「\(label)」有关的想抽时刻。下次可以先在 SOS 里选出这个诱因。"
            case .traditionalChinese: return "你已記錄 \(count) 次與「\(label)」有關的想抽時刻。下次可以先在 SOS 裡選出這個誘因。"
            case .german: return "Du hast \(count) Momente mit „\(label)“ festgehalten. Wähle diesen Auslöser beim nächsten Mal zuerst in SOS."
            case .french: return "Tu as noté \(count) envies liées à « \(label) ». La prochaine fois, indique d’abord ce déclencheur dans SOS."
            case .italian: return "Hai registrato \(count) momenti legati a «\(label)». La prossima volta, seleziona prima questo motivo in SOS."
            case .spanish: return "Has registrado \(count) momentos relacionados con «\(label)». La próxima vez, marca primero ese motivo en SOS."
            case .portuguese: return "Você registrou \(count) momentos ligados a “\(label)”. Na próxima, marque esse gatilho primeiro no SOS."
            case .japanese: return "「\(label)」に関係する欲求を\(count)回記録しています。次はSOSで先にきっかけを選んでみましょう。"
            case .korean: return "‘\(label)’와 관련된 순간을 \(count)번 기록했어요. 다음에는 SOS에서 이 계기를 먼저 골라 보세요."
            default: return "You've logged \(count) cravings linked to “\(label)”. Next time, name this trigger in SOS first."
            }
        }
        static var commonTriggerNotEnough: String { Strings.localized("Log two cravings with a trigger and Decrave can point you to the pattern worth preparing for.", [
            .simplifiedChinese: "记录两次带诱因的想抽时刻，Decrave 就能帮你找到值得提前准备的规律。",
            .traditionalChinese: "記錄兩次帶誘因的想抽時刻，Decrave 就能幫你找到值得提前準備的規律。",
            .german: "Protokolliere zwei Momente mit Auslöser, damit Decrave ein Muster zum Vorbereiten erkennt.",
            .french: "Note deux envies avec leur déclencheur et Decrave pourra repérer le schéma à préparer.",
            .italian: "Registra due voglie con il loro trigger e Decrave potrà indicarti lo schema da preparare.",
            .spanish: "Registra dos impulsos con su desencadenante y Decrave podrá señalarte el patrón que conviene preparar.",
            .portuguese: "Registre dois desejos com um gatilho e o Decrave poderá mostrar o padrão que vale preparar.",
            .japanese: "きっかけと一緒に2回記録すると、Decraveが次に備えたい傾向を見つけます。",
            .korean: "유발 요인과 함께 두 번 기록하면 Decrave가 미리 준비할 패턴을 찾아줘요."
        ]) }

        static var strongestPairingTitle: String { t("Your strongest pairing", [.simplifiedChinese: "最有效的组合", .traditionalChinese: "最有效的組合", .german: "Deine stärkste Kombination", .french: "Ton duo le plus efficace", .italian: "La combinazione più efficace", .spanish: "Tu combinación más eficaz", .portuguese: "Sua combinação mais eficaz", .japanese: "一番うまくいく組み合わせ", .korean: "가장 효과적인 조합"]) }
        static func strongestPairingBody(trigger: CravingTrigger, tool: String, beatenCount: Int, attemptCount: Int) -> String {
            let label = trigger.label
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "遇到「\(label)」时，用「\(tool)」的 \(attemptCount) 次里，你有 \(beatenCount) 次没有抽。下次可以先试它。"
            case .traditionalChinese: return "遇到「\(label)」時，用「\(tool)」的 \(attemptCount) 次裡，你有 \(beatenCount) 次沒有抽。下次可以先試它。"
            case .german: return "Bei „\(label)“ hast du mit \(tool) \(beatenCount) von \(attemptCount) Mal nicht geraucht. Probier es beim nächsten Mal zuerst."
            case .french: return "Pour « \(label) », \(tool) t’a aidé à ne pas fumer \(beatenCount) fois sur \(attemptCount). Tu peux commencer par là la prochaine fois."
            case .italian: return "Con «\(label)», \(tool) ti ha aiutato a non fumare \(beatenCount) volte su \(attemptCount). Potresti ripartire da lì."
            case .spanish: return "Con «\(label)», \(tool) te ayudó a no fumar \(beatenCount) de \(attemptCount) veces. Puede ser un buen primer paso la próxima vez."
            case .portuguese: return "Em momentos de “\(label)”, \(tool) ajudou você a não fumar \(beatenCount) de \(attemptCount) vezes. Vale começar por aí na próxima."
            case .japanese: return "「\(label)」のときに\(tool)を使った\(attemptCount)回のうち、\(beatenCount)回は吸わずに過ごせました。次もまず試してみましょう。"
            case .korean: return "‘\(label)’ 상황에서 \(tool)을 사용한 \(attemptCount)번 중 \(beatenCount)번은 피우지 않았어요. 다음에도 먼저 시도해 보세요."
            default: return "For “\(label)”, \(tool) helped you avoid smoking \(beatenCount) out of \(attemptCount) times. Try it first next time."
            }
        }

        static var triggerPatternTitle: String { t("A pattern worth noticing", [.simplifiedChinese: "值得留意的规律", .traditionalChinese: "值得留意的規律", .german: "Ein Muster, das sich lohnt", .french: "Un schéma à remarquer", .italian: "Uno schema da notare", .spanish: "Un patrón que merece atención", .portuguese: "Um padrão a observar", .japanese: "気づいておきたい傾向", .korean: "눈여겨볼 패턴"]) }
        static func triggerPatternBody(trigger: CravingTrigger, count: Int) -> String {
            let label = trigger.label
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "过去 7 天，「\(label)」出现了 \(count) 次，是你记录较多的诱因。"
            case .traditionalChinese: return "過去 7 天，「\(label)」出現了 \(count) 次，是你記錄較多的誘因。"
            case .german: return "„\(label)“ taucht in deinen Einträgen der letzten 7 Tage \(count) Mal auf."
            case .french: return "« \(label) » apparaît \(count) fois dans tes notes des 7 derniers jours."
            case .italian: return "Negli ultimi 7 giorni hai segnato «\(label)» \(count) volte."
            case .spanish: return "«\(label)» aparece \(count) veces en tus registros de los últimos 7 días."
            case .portuguese: return "“\(label)” apareceu \(count) vezes nos seus registros dos últimos 7 dias."
            case .japanese: return "過去7日間、「\(label)」をきっかけにした記録が\(count)回ありました。"
            case .korean: return "최근 7일 동안 ‘\(label)’가 계기였던 기록이 \(count)번 있어요."
            default: return "“\(label)” appears \(count) times in your logs from the past 7 days."
            }
        }
        // Preferred over triggerSuggestion when there's enough crossed data
        // (this trigger + a tool used together) — more specific than the
        // generic per-trigger tip below.
        static func triggerToolSuggestion(attemptCount: Int, beatenCount: Int) -> String {
            if attemptCount == beatenCount {
                switch AppLanguage.current.effective {
                case .simplifiedChinese: return "遇到这个诱因时，只要用了工具，你每次都没有抽。下次值得再试。"
                case .traditionalChinese: return "遇到這個誘因時，只要用了工具，你每次都沒有抽。下次值得再試。"
                case .german: return "Immer wenn du hier ein SOS-Werkzeug genutzt hast, hast du nicht geraucht. Probier es wieder."
                case .french: return "Chaque fois que tu as utilisé un outil SOS dans cette situation, tu n’as pas fumé. Pense à le refaire."
                case .italian: return "Ogni volta che hai usato uno strumento SOS in questa situazione, non hai fumato. Puoi riprovarci."
                case .spanish: return "Cada vez que usaste una herramienta SOS en esta situación, no fumaste. Vuelve a probarla."
                case .portuguese: return "Sempre que você usou uma ferramenta SOS nessa situação, não fumou. Vale tentar de novo."
                case .japanese: return "このきっかけでSOSのツールを使ったときは、毎回吸わずに過ごせました。次も試してみましょう。"
                case .korean: return "이 계기에서 SOS 도구를 사용했을 때는 매번 피우지 않았어요. 다음에도 써 보세요."
                default: return "When you used a craving tool for this trigger, you didn't smoke — every single time. Worth trying again next time."
                }
            }
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "遇到这个诱因时，你用了工具并撑过了 \(attemptCount) 次中的 \(beatenCount) 次。下次值得再试。"
            case .traditionalChinese: return "遇到這個誘因時，你用了工具並撐過了 \(attemptCount) 次中的 \(beatenCount) 次。下次值得再試。"
            case .german: return "Mit einem SOS-Werkzeug hast du hier \(beatenCount) von \(attemptCount) Mal nicht geraucht. Versuch es beim nächsten Mal wieder."
            case .french: return "Avec un outil SOS, tu n’as pas fumé \(beatenCount) fois sur \(attemptCount) dans cette situation. Tu peux réessayer."
            case .italian: return "Con uno strumento SOS, in questa situazione non hai fumato \(beatenCount) volte su \(attemptCount). Puoi riprovarci."
            case .spanish: return "Con una herramienta SOS, no fumaste \(beatenCount) de \(attemptCount) veces en esta situación. Puedes volver a usarla."
            case .portuguese: return "Com uma ferramenta SOS, você não fumou \(beatenCount) de \(attemptCount) vezes nessa situação. Vale tentar de novo."
            case .japanese: return "このきっかけでSOSを使った\(attemptCount)回のうち、\(beatenCount)回は吸わずに過ごせました。次も試す価値があります。"
            case .korean: return "이 상황에서 SOS 도구를 사용한 \(attemptCount)번 중 \(beatenCount)번은 피우지 않았어요. 다음에도 시도해 보세요."
            default: return "When you used a craving tool for this trigger, you didn't smoke \(beatenCount) out of \(attemptCount) times. Worth trying again next time."
            }
        }
        static func triggerSuggestion(_ trigger: CravingTrigger) -> String {
            switch trigger {
            case .coffee: return t("After coffee, try changing the routine: water, a short walk, or a different seat.", [
                .simplifiedChinese: "喝完咖啡先换个习惯：喝点水、走两步，或换个地方坐。", .traditionalChinese: "喝完咖啡先換個習慣：喝點水、走兩步，或換個地方坐。",
                .german: "Nach dem Kaffee: erst ein Glas Wasser, ein kurzer Weg oder ein anderer Platz.", .french: "Après le café, change le rituel : un verre d’eau, quelques pas ou une autre place.",
                .italian: "Dopo il caffè, cambia abitudine: acqua, due passi o un altro posto.", .spanish: "Después del café, cambia la rutina: agua, un paseo corto o siéntate en otro lugar.",
                .portuguese: "Depois do café, mude a rotina: água, uma caminhada curta ou outro lugar para sentar.", .japanese: "コーヒーの後は、水を飲む、少し歩く、座る場所を変えるなど、いつもと違うことを。", .korean: "커피를 마신 뒤에는 물을 마시거나 잠깐 걷거나 자리를 바꿔 보세요."
            ])
            case .meal: return t("After eating, try a short walk or put on a song before you decide.", [
                .simplifiedChinese: "饭后先走一小段，或放首歌，再决定要不要抽。", .traditionalChinese: "飯後先走一小段，或放首歌，再決定要不要抽。",
                .german: "Nach dem Essen erst ein paar Schritte gehen oder Musik anmachen, dann entscheiden.", .french: "Après le repas, fais quelques pas ou lance une chanson avant de décider.",
                .italian: "Dopo mangiato, fai due passi o metti una canzone prima di decidere.", .spanish: "Después de comer, camina un poco o pon una canción antes de decidir.",
                .portuguese: "Depois de comer, caminhe um pouco ou coloque uma música antes de decidir.", .japanese: "食後は少し歩くか、好きな曲を1曲聴いてから決めましょう。", .korean: "식사 후에는 잠깐 걷거나 노래 한 곡을 듣고 나서 결정해 보세요."
            ])
            case .stress: return t("When stress hits, try a minute of breathing before you decide.", [
                .simplifiedChinese: "压力上来时，先跟着呼吸一分钟，再做决定。", .traditionalChinese: "壓力上來時，先跟著呼吸一分鐘，再做決定。",
                .german: "Wenn der Stress kommt, atme erst eine Minute bewusst, bevor du entscheidest.", .french: "Quand la pression monte, prends une minute pour respirer avant de décider.",
                .italian: "Quando sale lo stress, prova un minuto di respirazione prima di decidere.", .spanish: "Cuando suba el estrés, respira un minuto antes de decidir.",
                .portuguese: "Quando o estresse apertar, respire por um minuto antes de decidir.", .japanese: "ストレスを感じたら、決める前に1分だけ呼吸を整えてみましょう。", .korean: "스트레스가 올라오면 결정하기 전에 1분만 호흡해 보세요."
            ])
            case .alcohol: return t("If drinking makes it harder, changing where you sit can help break the pattern.", [
                .simplifiedChinese: "喝酒时更难控制的话，换个座位也许能打断老习惯。", .traditionalChinese: "喝酒時更難控制的話，換個座位也許能打斷老習慣。",
                .german: "Beim Trinken hilft manchmal schon ein anderer Platz, um die Gewohnheit zu unterbrechen.", .french: "Quand l’alcool complique les choses, changer de place peut casser l’habitude.",
                .italian: "Se bere rende tutto più difficile, cambiare posto può spezzare l’abitudine.", .spanish: "Si al beber cuesta más, cambiar de sitio puede romper la costumbre.",
                .portuguese: "Se beber dificulta as coisas, mudar de lugar pode quebrar o hábito.", .japanese: "お酒の席では、座る場所を変えるだけでも流れを変えられることがあります。", .korean: "술자리에서는 자리를 바꾸는 것만으로도 익숙한 흐름을 끊는 데 도움이 될 수 있어요."
            ])
            case .breakTime: return t("At the start of a break, give your hands something else to do for two minutes.", [
                .simplifiedChinese: "休息刚开始时，先让手忙别的事两分钟。", .traditionalChinese: "休息剛開始時，先讓手忙別的事兩分鐘。",
                .german: "Beschäftige deine Hände in den ersten zwei Minuten der Pause mit etwas anderem.", .french: "Au début de la pause, occupe tes mains autrement pendant deux minutes.",
                .italian: "All’inizio della pausa, tieni le mani occupate con altro per due minuti.", .spanish: "Al empezar el descanso, ocupa las manos con otra cosa durante dos minutos.",
                .portuguese: "No começo da pausa, ocupe as mãos com outra coisa por dois minutos.", .japanese: "休憩の最初の2分だけ、手を別のことに使ってみましょう。", .korean: "쉬는 시간이 시작되면 처음 2분만 손으로 다른 일을 해 보세요."
            ])
            case .boredom: return t("For a quiet moment, try a two-minute task: send a message or tidy one small thing.", [
                .simplifiedChinese: "无聊时找件两分钟的小事：发条消息，或收拾一下桌面。", .traditionalChinese: "無聊時找件兩分鐘的小事：傳個訊息，或整理一下桌面。",
                .german: "Bei Langeweile hilft eine kleine Aufgabe: eine Nachricht schicken oder kurz etwas aufräumen.", .french: "Quand tu t’ennuies, trouve une petite chose à faire : écrire à quelqu’un ou ranger un coin.",
                .italian: "Se ti annoi, fai una cosa piccola: scrivi a qualcuno o metti in ordine un angolo.", .spanish: "Si te aburres, haz algo pequeño: manda un mensaje u ordena un rincón.",
                .portuguese: "Se bater o tédio, faça algo rápido: mande uma mensagem ou arrume um cantinho.", .japanese: "退屈なときは、メッセージを送る、机を少し片づけるなど、2分でできることを。", .korean: "심심할 때는 메시지를 보내거나 주변을 조금 정리하는 등 2분짜리 일을 해 보세요."
            ])
            case .other: return t("Next time it happens, notice where you are and what came just before the urge.", [
                .simplifiedChinese: "下次想抽时，留意自己在哪里，之前刚发生了什么。", .traditionalChinese: "下次想抽時，留意自己在哪裡，之前剛發生了什麼。",
                .german: "Achte beim nächsten Mal darauf, wo du bist und was kurz davor passiert ist.", .french: "La prochaine fois, note où tu es et ce qui s’est passé juste avant l’envie.",
                .italian: "La prossima volta, nota dove sei e cosa è successo poco prima della voglia.", .spanish: "La próxima vez, fíjate dónde estás y qué pasó justo antes de las ganas.",
                .portuguese: "Na próxima, repare onde você está e o que aconteceu logo antes da vontade.", .japanese: "次に吸いたくなったら、どこにいて、直前に何があったかを見てみましょう。", .korean: "다음에 피우고 싶어지면 어디에 있었고 바로 전에 무슨 일이 있었는지 살펴보세요."
            ])
            }
        }

        static var toolEffectivenessTitle: String { t("Progress, not luck", [.simplifiedChinese: "靠的是进步，不是运气", .traditionalChinese: "靠的是進步，不是運氣", .german: "Fortschritt, nicht Glück", .french: "Le progrès, pas la chance", .italian: "Progressi, non fortuna", .spanish: "Progreso, no suerte", .portuguese: "Progresso, não sorte", .japanese: "運ではなく、積み重ね", .korean: "운이 아니라 성장"]) }
        static func toolEffectivenessBody(attemptCount: Int, beatenCount: Int) -> String {
            if attemptCount == beatenCount {
                switch AppLanguage.current.effective {
                case .simplifiedChinese: return "这周你用了 \(attemptCount) 次想抽时刻工具，而且每次都没有抽。"
                case .traditionalChinese: return "這週你用了 \(attemptCount) 次想抽時刻工具，而且每次都沒有抽。"
                case .german: return "Du hast diese Woche \(attemptCount) Mal ein SOS-Werkzeug genutzt und jedes Mal nicht geraucht."
                case .french: return "Cette semaine, tu as utilisé un outil SOS \(attemptCount) fois, sans fumer une seule fois."
                case .italian: return "Questa settimana hai usato uno strumento SOS \(attemptCount) volte e non hai mai fumato."
                case .spanish: return "Esta semana usaste una herramienta SOS \(attemptCount) veces y no fumaste ninguna de ellas."
                case .portuguese: return "Nesta semana, você usou uma ferramenta SOS \(attemptCount) vezes e não fumou em nenhuma delas."
                case .japanese: return "今週はSOSのツールを\(attemptCount)回使い、どの回も吸わずに過ごせました。"
                case .korean: return "이번 주 SOS 도구를 \(attemptCount)번 사용했고, 모두 피우지 않고 넘겼어요."
                default: return "You used a craving tool \(attemptCount) times this week — and didn't smoke, every single time."
                }
            }
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "这周你用了 \(attemptCount) 次想抽时刻工具，其中 \(beatenCount) 次撑了过去。"
            case .traditionalChinese: return "這週你用了 \(attemptCount) 次想抽時刻工具，其中 \(beatenCount) 次撐了過去。"
            case .german: return "Du hast diese Woche \(attemptCount) Mal ein SOS-Werkzeug genutzt und \(beatenCount) Mal nicht geraucht."
            case .french: return "Cette semaine, tu as utilisé un outil SOS \(attemptCount) fois et tu n’as pas fumé \(beatenCount) fois."
            case .italian: return "Questa settimana hai usato uno strumento SOS \(attemptCount) volte e non hai fumato \(beatenCount) volte."
            case .spanish: return "Esta semana usaste una herramienta SOS \(attemptCount) veces y no fumaste en \(beatenCount) de ellas."
            case .portuguese: return "Nesta semana, você usou uma ferramenta SOS \(attemptCount) vezes e não fumou em \(beatenCount) delas."
            case .japanese: return "今週はSOSのツールを\(attemptCount)回使い、そのうち\(beatenCount)回は吸わずに過ごせました。"
            case .korean: return "이번 주 SOS 도구를 \(attemptCount)번 사용했고, 그중 \(beatenCount)번은 피우지 않았어요."
            default: return "You used a craving tool \(attemptCount) times this week — and didn't smoke \(beatenCount) of those times."
            }
        }
    }

    enum DailyReminder {
        static let title = "Decrave"
        static var body: String { Strings.localized("Need a moment? SOS is here when you are.", [
            .simplifiedChinese: "想缓一缓？需要时可以打开 SOS。", .traditionalChinese: "想緩一緩？需要時可以打開 SOS。",
            .german: "Brauchst du einen Moment? SOS ist für dich da.", .french: "Besoin d’une pause ? SOS est là si tu veux.",
            .italian: "Hai bisogno di un momento? SOS è qui per te.", .spanish: "¿Necesitas un momento? SOS está aquí cuando quieras.",
            .portuguese: "Precisa de um momento? O SOS está aqui quando quiser.", .japanese: "少し落ち着きたいときは、SOSを開いてください。", .korean: "잠깐 숨을 고르고 싶다면 SOS를 열어 보세요."
        ]) }

        static func body(for window: InsightsEngine.PredictedWindow?) -> String {
            guard let window else { return body }
            if let trigger = window.trigger {
                let label = trigger.label
                switch AppLanguage.current.effective {
                case .simplifiedChinese: return "你常想抽的时段到了（\(label)）。需要时，打开 SOS 缓一缓。"
                case .traditionalChinese: return "你常想抽的時段到了（\(label)）。需要時，打開 SOS 緩一緩。"
                case .german: return "Deine übliche Zeit ist da (\(label)). SOS ist da, wenn du es brauchst."
                case .french: return "C’est souvent un moment difficile pour toi (\(label)). SOS est là si tu veux."
                case .italian: return "È un momento in cui di solito arriva la voglia (\(label)). SOS è qui se ti serve."
                case .spanish: return "Es un momento en que suelen aparecer las ganas (\(label)). SOS está aquí si lo necesitas."
                case .portuguese: return "Este costuma ser um momento de vontade (\(label)). O SOS está aqui se precisar."
                case .japanese: return "吸いたくなりやすい時間です（\(label)）。必要ならSOSを開いてみてください。"
                case .korean: return "평소 피우고 싶어지던 시간이에요(\(label)). 필요하면 SOS를 열어 보세요."
                default: return "This is often a craving time for you (\(label)). SOS is here if you need it."
                }
            }
            return Strings.localized("This is often a craving time for you. SOS is here if you need it.", [
                .simplifiedChinese: "你常想抽的时段到了。需要时，打开 SOS 缓一缓。", .traditionalChinese: "你常想抽的時段到了。需要時，打開 SOS 緩一緩。",
                .german: "Deine übliche Zeit ist da. SOS ist da, wenn du es brauchst.", .french: "C’est souvent un moment difficile pour toi. SOS est là si tu veux.",
                .italian: "È un momento in cui di solito arriva la voglia. SOS è qui se ti serve.", .spanish: "Es un momento en que suelen aparecer las ganas. SOS está aquí si lo necesitas.",
                .portuguese: "Este costuma ser um momento de vontade. O SOS está aqui se precisar.", .japanese: "吸いたくなりやすい時間です。必要ならSOSを開いてみてください。", .korean: "평소 피우고 싶어지던 시간이에요. 필요하면 SOS를 열어 보세요."
            ])
        }
    }

    enum Settings {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }

        static var pageTitle: String { t("Settings", [
            .simplifiedChinese: "设置", .traditionalChinese: "設定", .german: "Einstellungen",
            .french: "Réglages", .italian: "Impostazioni", .spanish: "Ajustes", .portuguese: "Definições",
            .japanese: "設定", .korean: "설정"
        ]) }
        static var close: String { t("Close", [
            .simplifiedChinese: "关闭", .traditionalChinese: "關閉", .german: "Schließen", .french: "Fermer",
            .italian: "Chiudi", .spanish: "Cerrar", .portuguese: "Fechar", .japanese: "閉じる", .korean: "닫기"
        ]) }
        static var ok: String { t("OK", [.simplifiedChinese: "好", .traditionalChinese: "好", .german: "OK", .french: "OK", .italian: "OK", .spanish: "Aceptar", .portuguese: "OK", .japanese: "OK", .korean: "확인"]) }
        static var logSlipRow: String { t("Smoked? Log it without judgment", [
            .simplifiedChinese: "刚才没忍住——安全记录下来", .traditionalChinese: "剛才沒忍住——安全記錄下來",
            .german: "Doch geraucht? Ohne Wertung eintragen", .french: "J’ai fumé — le noter sans jugement",
            .italian: "Ho fumato — registralo senza giudicarti", .spanish: "Fumé — anotarlo sin culpa",
            .portuguese: "Fumei — registrar sem culpa", .japanese: "吸ってしまったときも、そのまま記録",
            .korean: "담배를 피웠어도 편하게 기록하기"
        ]) }
        static var languageTitle: String { t("Language", [
            .simplifiedChinese: "语言", .traditionalChinese: "語言", .german: "Sprache", .french: "Langue",
            .italian: "Lingua", .spanish: "Idioma", .portuguese: "Idioma", .japanese: "言語", .korean: "언어"
        ]) }
        static var languageSubtitle: String { t("Choose the language Decrave uses", [
            .simplifiedChinese: "选择 Decrave 使用的语言", .traditionalChinese: "選擇 Decrave 使用的語言",
            .german: "Wähle die Sprache für Decrave", .french: "Choisis la langue de Decrave",
            .italian: "Scegli la lingua di Decrave", .spanish: "Elige el idioma de Decrave",
            .portuguese: "Escolha o idioma do Decrave", .japanese: "Decraveで使う言語を選択",
            .korean: "Decrave에서 사용할 언어를 선택하세요"
        ]) }

        static var freeTitle: String { t("Free plan", [
            .simplifiedChinese: "免费方案", .traditionalChinese: "免費方案", .german: "Kostenloser Tarif",
            .french: "Offre gratuite", .italian: "Piano gratuito", .spanish: "Plan gratuito",
            .portuguese: "Plano gratuito", .japanese: "無料プラン", .korean: "무료 플랜"
        ]) }
        static var freeSubtitle: String { t("Core craving tools and headline stats", [
            .simplifiedChinese: "核心应对工具和关键数据", .traditionalChinese: "核心應對工具和關鍵數據",
            .german: "Wichtige Tools und Kennzahlen", .french: "Outils essentiels et chiffres clés",
            .italian: "Strumenti essenziali e dati principali", .spanish: "Herramientas clave y datos principales",
            .portuguese: "Ferramentas essenciais e dados principais", .japanese: "基本ツールと主な記録",
            .korean: "핵심 대처 도구와 주요 통계"
        ]) }
        static var memberTitle: String { t("Decrave Pro", [
            .simplifiedChinese: "Decrave Pro", .traditionalChinese: "Decrave Pro", .german: "Decrave Pro",
            .french: "Decrave Pro", .italian: "Decrave Pro", .spanish: "Decrave Pro", .portuguese: "Decrave Pro",
            .japanese: "Decrave Pro", .korean: "Decrave Pro"
        ]) }
        static var memberSubtitle: String { t("All features unlocked", [
            .simplifiedChinese: "全部功能已解锁", .traditionalChinese: "全部功能已解鎖", .german: "Alle Funktionen freigeschaltet",
            .french: "Toutes les fonctions sont disponibles", .italian: "Tutte le funzioni sbloccate",
            .spanish: "Todas las funciones desbloqueadas", .portuguese: "Todos os recursos desbloqueados",
            .japanese: "すべての機能を利用できます", .korean: "모든 기능이 잠금 해제됨"
        ]) }
        static var tryProCTA: String { t("Try Pro", [
            .simplifiedChinese: "试用 Pro", .traditionalChinese: "試用 Pro", .german: "Pro testen", .french: "Essayer Pro",
            .italian: "Prova Pro", .spanish: "Probar Pro", .portuguese: "Testar Pro", .japanese: "Proを試す", .korean: "Pro 체험"
        ]) }

        static var yourNumbersHeader: String { t("Your numbers", [
            .simplifiedChinese: "你的数据", .traditionalChinese: "你的數據", .german: "Deine Zahlen",
            .french: "Tes chiffres", .italian: "I tuoi numeri", .spanish: "Tus datos", .portuguese: "Seus números",
            .japanese: "あなたの記録", .korean: "나의 기록"
        ]) }
        static var moneySavedLabel: String { t("estimated savings", [
            .simplifiedChinese: "估算节省", .traditionalChinese: "估算節省", .german: "geschätzte Ersparnis", .french: "économies estimées",
            .italian: "risparmio stimato", .spanish: "ahorro estimado", .portuguese: "economia estimada", .japanese: "節約額の目安", .korean: "예상 절약액"
        ]) }
        static var cigsAvoidedLabel: String { t("cigarettes avoided", [
            .simplifiedChinese: "少抽的烟", .traditionalChinese: "少抽的煙", .german: "Zigaretten vermieden",
            .french: "cigarettes évitées", .italian: "sigarette evitate", .spanish: "cigarrillos evitados",
            .portuguese: "cigarros evitados", .japanese: "避けた本数", .korean: "피한 담배"
        ]) }
        static var cravingsBeatenLabel: String { t("cravings beaten", [
            .simplifiedChinese: "撑过的想抽时刻", .traditionalChinese: "撐過的想抽時刻", .german: "überstandene Momente",
            .french: "envies surmontées", .italian: "voglie superate", .spanish: "impulsos superados",
            .portuguese: "desejos superados", .japanese: "乗り越えた欲求", .korean: "넘긴 욕구"
        ]) }
        static var momentumLabel: String { t("current momentum", [
            .simplifiedChinese: "当前动力", .traditionalChinese: "目前動力", .german: "aktueller Schwung",
            .french: "élan actuel", .italian: "slancio attuale", .spanish: "impulso actual",
            .portuguese: "ritmo atual", .japanese: "現在の勢い", .korean: "현재 모멘텀"
        ]) }

        static var promiseTitle: String { t("The Never-Reset Promise", [
            .simplifiedChinese: "进度永不归零", .traditionalChinese: "進度永不歸零", .german: "Das Versprechen: kein Zurücksetzen",
            .french: "La promesse sans remise à zéro", .italian: "La promessa senza azzeramenti",
            .spanish: "La promesa de no volver a cero", .portuguese: "A promessa de nunca zerar",
            .japanese: "進捗はリセットしない", .korean: "진행 상황은 초기화되지 않아요"
        ]) }
        static var promiseSubtitle: String { t("Why Decrave never zeroes your progress", [
            .simplifiedChinese: "为什么 Decrave 不会清零你的进度", .traditionalChinese: "為什麼 Decrave 不會清零你的進度",
            .german: "Warum Decrave deinen Fortschritt nie löscht", .french: "Pourquoi Decrave ne remet jamais tes progrès à zéro",
            .italian: "Perché Decrave non azzera mai i tuoi progressi", .spanish: "Por qué Decrave nunca borra tu progreso",
            .portuguese: "Por que o Decrave nunca zera seu progresso", .japanese: "Decraveが進捗をリセットしない理由",
            .korean: "Decrave가 진행 상황을 초기화하지 않는 이유"
        ]) }
        static var promiseHeading: String { t("🛡️ The Never-Reset Promise", [
            .simplifiedChinese: "🛡️ 进度永不归零", .traditionalChinese: "🛡️ 進度永不歸零", .german: "🛡️ Das Versprechen: kein Zurücksetzen", .french: "🛡️ La promesse sans remise à zéro",
            .italian: "🛡️ La promessa senza azzeramenti", .spanish: "🛡️ La promesa de no volver a cero", .portuguese: "🛡️ A promessa de nunca zerar", .japanese: "🛡️ 進捗はリセットしない", .korean: "🛡️ 진행 상황은 초기화되지 않아요"
        ]) }
        static var promiseIntro: String { t("Smoking once doesn't erase the work you've done. Decrave keeps your progress so you can pick up where you left off.", [
            .simplifiedChinese: "抽了一次，不代表之前的努力白费。Decrave 会保留你的进展，让你从这里继续。",
            .traditionalChinese: "抽了一次，不代表之前的努力白費。Decrave 會保留你的進度，讓你從這裡繼續。",
            .german: "Eine Zigarette macht deine bisherigen Schritte nicht zunichte. Decrave behält deinen Fortschritt im Blick, damit du weitermachen kannst.",
            .french: "Une cigarette n’efface pas tes efforts. Decrave garde une trace de tes progrès pour que tu puisses reprendre.",
            .italian: "Una sigaretta non cancella quello che hai già fatto. Decrave conserva i tuoi progressi, così puoi ripartire da qui.",
            .spanish: "Fumar un cigarrillo no borra lo que ya has conseguido. Decrave conserva tus avances para que puedas seguir.",
            .portuguese: "Fumar um cigarro não apaga o caminho que você já percorreu. O Decrave guarda seu progresso para você seguir em frente.",
            .japanese: "一度吸ったからといって、これまでの頑張りが消えるわけではありません。Decraveは記録を残し、そこからまた続けられます。",
            .korean: "담배를 한 번 피웠다고 지금까지의 노력이 사라지지는 않아요. Decrave는 기록을 남겨 두니 여기서 다시 이어 가면 됩니다."
        ]) }
        static var promisePoint1Title: String { t("Your progress stays", [
            .simplifiedChinese: "已经做到的，都会留下", .traditionalChinese: "已經做到的，都會留下", .german: "Dein Fortschritt bleibt", .french: "Tes progrès restent", .italian: "I progressi restano", .spanish: "Tus avances se quedan", .portuguese: "Seu progresso fica", .japanese: "これまでの記録は残ります", .korean: "지금까지의 기록은 남아요"
        ]) }
        static var promisePoint1Body: String { t("The cravings you got through and the money you saved stay in your record.", [
            .simplifiedChinese: "撑过的想抽时刻、省下的钱，都还在记录里。", .traditionalChinese: "撐過的想抽時刻、省下的錢，都還在記錄裡。", .german: "Überstandene Momente und gespartes Geld bleiben in deiner Übersicht.", .french: "Les envies que tu as traversées et l’argent économisé restent dans ton suivi.", .italian: "Le voglie superate e i soldi risparmiati restano nel tuo resoconto.", .spanish: "Las ganas que superaste y el dinero que ahorraste siguen en tu registro.", .portuguese: "As vontades que você superou e o dinheiro economizado continuam no seu histórico.", .japanese: "吸わずに過ごせた回数や節約した金額は、そのまま記録に残ります。", .korean: "흡연 욕구를 넘긴 횟수와 절약한 금액은 기록에 그대로 남아요."
        ]) }
        static var promisePoint2Title: String { t("You can build momentum again", [
            .simplifiedChinese: "状态可以慢慢找回来", .traditionalChinese: "狀態可以慢慢找回來", .german: "Du kannst wieder in Schwung kommen", .french: "Tu peux retrouver ton élan", .italian: "Puoi ritrovare il ritmo", .spanish: "Puedes recuperar el ritmo", .portuguese: "Dá para retomar o ritmo", .japanese: "また少しずつ調子を戻せます", .korean: "다시 흐름을 찾을 수 있어요"
        ]) }
        static var promisePoint2Body: String { t("Smoking lowers your Momentum score a little. The next craving you get through raises it again. The score never resets to zero.", [
            .simplifiedChinese: "抽了一次，动力值会降一点。下次撑过想抽时，它又会回升，不会清零。", .traditionalChinese: "抽了一次，動力值會降一點。下次撐過想抽時，它又會回升，不會清零。", .german: "Wenn du rauchst, sinkt dein Momentum-Wert etwas. Bei der nächsten überstandenen Lust steigt er wieder. Auf null wird er nie gesetzt.", .french: "Si tu fumes, ton score baisse un peu. Il remonte la prochaine fois que tu traverses une envie. Il ne revient jamais à zéro.", .italian: "Se fumi, il punteggio scende un po’. Risale quando superi la prossima voglia. Non torna mai a zero.", .spanish: "Si fumas, tu puntuación baja un poco. Vuelve a subir cuando superas las siguientes ganas. Nunca se pone a cero.", .portuguese: "Se você fumar, sua pontuação cai um pouco. Ela sobe quando você supera a próxima vontade. Nunca volta a zero.", .japanese: "吸うと勢いのスコアは少し下がります。次に吸いたい気持ちをやり過ごすと、また上がります。ゼロには戻りません。", .korean: "담배를 피우면 점수가 조금 내려가요. 다음 흡연 욕구를 넘기면 다시 올라가고, 0으로 초기화되지는 않아요."
        ]) }
        static var promisePoint3Title: String { t("A slip is logged, not punished", [
            .simplifiedChinese: "失手会被记录，但不会被惩罚", .traditionalChinese: "失手會被記錄，但不會被懲罰", .german: "Ein Ausrutscher wird erfasst, nicht bestraft", .french: "Un écart est noté, pas puni", .italian: "Uno scivolone si registra, non si punisce", .spanish: "Un desliz se registra, no se castiga", .portuguese: "Um deslize é registrado, não punido", .japanese: "失敗は記録しますが、罰しません", .korean: "실수는 기록할 뿐, 벌주지 않아요"
        ]) }
        static var promisePoint3Body: String { t("There's no failure screen and no lost streak — just a safe place to log it and keep going.", [
            .simplifiedChinese: "没有失败页面，也不会失去连续记录。安心记下来，继续往前。", .traditionalChinese: "沒有失敗頁面，也不會失去連續記錄。安心記下來，繼續往前。", .german: "Kein Bildschirm des Scheiterns und keine verlorene Serie — nur ein sicherer Ort zum Eintragen und Weitermachen.", .french: "Pas d’écran d’échec ni de série perdue : note-le simplement dans un espace sûr et continue.", .italian: "Nessuna schermata di fallimento né serie persa: registralo in sicurezza e continua.", .spanish: "No hay pantalla de fracaso ni racha perdida: regístralo en un lugar seguro y sigue.", .portuguese: "Sem tela de fracasso nem sequência perdida: registre com segurança e continue.", .japanese: "失敗画面も連続記録の喪失もありません。安心して記録し、続けられます。", .korean: "실패 화면도 연속 기록 손실도 없어요. 안전하게 기록하고 계속하면 됩니다."
        ]) }

        static var notificationsToggle: String { t("Smart craving reminder", [
            .simplifiedChinese: "智能提醒", .traditionalChinese: "智能提醒", .german: "Intelligente Erinnerung",
            .french: "Rappel intelligent", .italian: "Promemoria intelligente", .spanish: "Recordatorio inteligente",
            .portuguese: "Lembrete inteligente", .japanese: "スマートリマインダー", .korean: "스마트 알림"
        ]) }
        static var notificationsDefaultFooter: String { t("Daily at 7:00 PM until Trigger Radar learns a usual craving window. Off by default — you decide.", [
            .simplifiedChinese: "在诱因雷达识别出常见时段前，每天 19:00 提醒。默认关闭，由你决定。",
            .traditionalChinese: "在誘因雷達辨識出常見時段前，每天 19:00 提醒。預設關閉，由你決定。",
            .german: "Täglich um 19:00 Uhr, bis der Trigger-Radar dein übliches Zeitfenster kennt. Standardmäßig aus.",
            .french: "Chaque jour à 19 h, jusqu’à ce que le radar connaisse ton créneau habituel. Désactivé par défaut.",
            .italian: "Ogni giorno alle 19:00, finché Trigger Radar non riconosce il tuo orario abituale. Disattivato di default.",
            .spanish: "Cada día a las 19:00 hasta que el Radar conozca tu horario habitual. Desactivado por defecto.",
            .portuguese: "Todos os dias às 19h, até o Radar reconhecer seu horário habitual. Desativado por padrão.",
            .japanese: "トリガーレーダーがいつもの時間帯を学ぶまで、毎日19時に通知します。初期設定はオフです。",
            .korean: "트리거 레이더가 평소 시간대를 파악할 때까지 매일 오후 7시에 알림을 보내요. 기본값은 꺼짐입니다."
        ]) }
        static func notificationsPatternFooter(weekday: String, hour: String, occurrences: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "根据已记录的 \(occurrences) 次想抽时刻，提醒时间设在\(weekday) \(hour) 左右。默认关闭，由你决定。"
            case .traditionalChinese: return "根據已記錄的 \(occurrences) 次想抽時刻，提醒時間設在\(weekday) \(hour) 左右。預設關閉，由你決定。"
            case .german: return "Nach \(occurrences) Einträgen für \(weekday) gegen \(hour) geplant. Standardmäßig aus — du entscheidest."
            case .french: return "Prévu le \(weekday) vers \(hour), selon \(occurrences) envies notées. Désactivé par défaut — tu décides."
            case .italian: return "Previsto per \(weekday) verso le \(hour), in base a \(occurrences) registrazioni. Disattivato di default."
            case .spanish: return "Programado para \(weekday) sobre las \(hour), según \(occurrences) registros. Desactivado por defecto."
            case .portuguese: return "Marcado para \(weekday) por volta de \(hour), com base em \(occurrences) registros. Desativado por padrão."
            case .japanese: return "記録した\(occurrences)回をもとに、\(weekday)の\(hour)頃に設定します。初期設定はオフです。"
            case .korean: return "기록한 \(occurrences)번을 바탕으로 \(weekday) \(hour)쯤 알림을 설정해요. 기본값은 꺼짐입니다."
            default: return "Timed for \(weekday) around \(hour), based on \(occurrences) logged cravings. Off by default — you decide."
            }
        }

        static var analyticsToggle: String { t("Share anonymous analytics", [
            .simplifiedChinese: "分享匿名分析数据", .traditionalChinese: "分享匿名分析資料", .german: "Anonyme Analysen teilen",
            .french: "Partager des analyses anonymes", .italian: "Condividi analisi anonime", .spanish: "Compartir análisis anónimos",
            .portuguese: "Compartilhar análises anônimas", .japanese: "匿名の分析データを共有", .korean: "익명 분석 공유"
        ]) }
        static var analyticsFooter: String { t("Shares product interactions and a privacy-preserving device identifier with TelemetryDeck. Never includes your craving logs, name, email, IP address, or advertising ID.", [
            .simplifiedChinese: "与 TelemetryDeck 分享产品使用情况和保护隐私的设备标识符。不包含你的记录、姓名、邮箱、IP 地址或广告 ID。",
            .traditionalChinese: "與 TelemetryDeck 分享產品使用情況和保護隱私的裝置識別碼。不包含你的記錄、姓名、電郵、IP 位址或廣告 ID。",
            .german: "Teilt Produktinteraktionen und eine datenschutzfreundliche Gerätekennung mit TelemetryDeck. Keine Protokolle, Namen, E-Mails, IP- oder Werbe-IDs.",
            .french: "Partage avec TelemetryDeck l’utilisation du produit et un identifiant respectueux de la vie privée. Jamais tes notes, ton nom, ton e-mail, ton IP ou ton identifiant publicitaire.",
            .italian: "Condivide con TelemetryDeck l’uso del prodotto e un identificatore rispettoso della privacy. Mai i tuoi registri, nome, email, IP o ID pubblicitario.",
            .spanish: "Comparte con TelemetryDeck el uso del producto y un identificador respetuoso con la privacidad. Nunca tus registros, nombre, correo, IP ni ID publicitario.",
            .portuguese: "Compartilha com a TelemetryDeck o uso do produto e um identificador que protege sua privacidade. Nunca seus registros, nome, e-mail, IP ou ID de anúncios.",
            .japanese: "TelemetryDeckに製品の利用状況とプライバシーに配慮した端末識別子を共有します。記録、氏名、メール、IPアドレス、広告IDは含みません。",
            .korean: "제품 사용 정보와 개인정보를 보호하는 기기 식별자를 TelemetryDeck과 공유해요. 기록, 이름, 이메일, IP 주소, 광고 ID는 포함하지 않습니다."
        ]) }

        static var proSectionHeader: String { t("Decrave Pro", [
            .simplifiedChinese: "Decrave Pro", .traditionalChinese: "Decrave Pro", .german: "Decrave Pro", .french: "Decrave Pro",
            .italian: "Decrave Pro", .spanish: "Decrave Pro", .portuguese: "Decrave Pro", .japanese: "Decrave Pro", .korean: "Decrave Pro"
        ]) }
        static var dataExportRow: String { t("Export your data", [
            .simplifiedChinese: "导出你的数据", .traditionalChinese: "匯出你的資料", .german: "Deine Daten exportieren",
            .french: "Exporter tes données", .italian: "Esporta i tuoi dati", .spanish: "Exportar tus datos",
            .portuguese: "Exportar seus dados", .japanese: "データを書き出す", .korean: "데이터 내보내기"
        ]) }

        static var restorePurchases: String { t("Restore purchases", [
            .simplifiedChinese: "恢复购买", .traditionalChinese: "恢復購買", .german: "Käufe wiederherstellen", .french: "Restaurer les achats", .italian: "Ripristina acquisti", .spanish: "Restaurar compras", .portuguese: "Restaurar compras", .japanese: "購入を復元", .korean: "구매 복원"
        ]) }
        static var restoreSuccessTitle: String { t("Purchases restored", [.simplifiedChinese: "购买已恢复", .traditionalChinese: "購買已恢復", .german: "Käufe wiederhergestellt", .french: "Achats restaurés", .italian: "Acquisti ripristinati", .spanish: "Compras restauradas", .portuguese: "Compras restauradas", .japanese: "購入を復元しました", .korean: "구매가 복원됨"]) }
        static var restoreSuccessMessage: String { t("Your Decrave Pro access is active.", [.simplifiedChinese: "你的 Decrave Pro 权限已启用。", .traditionalChinese: "你的 Decrave Pro 權限已啟用。", .german: "Dein Decrave-Pro-Zugang ist aktiv.", .french: "Ton accès Decrave Pro est actif.", .italian: "Il tuo accesso Decrave Pro è attivo.", .spanish: "Tu acceso a Decrave Pro está activo.", .portuguese: "Seu acesso ao Decrave Pro está ativo.", .japanese: "Decrave Proが有効になりました。", .korean: "Decrave Pro 이용 권한이 활성화됐어요."]) }
        static var restoreEmptyTitle: String { t("Nothing to restore", [.simplifiedChinese: "没有可恢复的购买", .traditionalChinese: "沒有可恢復的購買", .german: "Nichts wiederherzustellen", .french: "Aucun achat à restaurer", .italian: "Nessun acquisto da ripristinare", .spanish: "Nada que restaurar", .portuguese: "Nada para restaurar", .japanese: "復元する購入がありません", .korean: "복원할 구매가 없음"]) }
        static var restoreEmptyMessage: String { t("We didn't find any previous Decrave Pro purchases for this Apple ID.", [.simplifiedChinese: "没有找到此 Apple ID 以前购买的 Decrave Pro。", .traditionalChinese: "找不到此 Apple ID 之前購買的 Decrave Pro。", .german: "Für diese Apple-ID wurden keine früheren Decrave-Pro-Käufe gefunden.", .french: "Aucun achat Decrave Pro précédent trouvé pour cet identifiant Apple.", .italian: "Non risultano acquisti Decrave Pro precedenti per questo Apple ID.", .spanish: "No encontramos compras anteriores de Decrave Pro para este Apple ID.", .portuguese: "Não encontramos compras anteriores do Decrave Pro para este ID Apple.", .japanese: "このApple IDに以前のDecrave Pro購入は見つかりませんでした。", .korean: "이 Apple ID에서 이전 Decrave Pro 구매를 찾지 못했어요."]) }
        static var restoreErrorTitle: String { t("Couldn't restore purchases", [.simplifiedChinese: "无法恢复购买", .traditionalChinese: "無法恢復購買", .german: "Käufe konnten nicht wiederhergestellt werden", .french: "Impossible de restaurer les achats", .italian: "Impossibile ripristinare gli acquisti", .spanish: "No se pudieron restaurar las compras", .portuguese: "Não foi possível restaurar as compras", .japanese: "購入を復元できませんでした", .korean: "구매를 복원하지 못했어요"]) }
        static var restoreErrorMessage: String { t("Something went wrong. Please try again.", [.simplifiedChinese: "出了点问题，请重试。", .traditionalChinese: "出了點問題，請重試。", .german: "Etwas ist schiefgelaufen. Bitte versuche es erneut.", .french: "Une erreur est survenue. Réessaie.", .italian: "Qualcosa è andato storto. Riprova.", .spanish: "Algo salió mal. Inténtalo de nuevo.", .portuguese: "Algo deu errado. Tente novamente.", .japanese: "問題が発生しました。もう一度お試しください。", .korean: "문제가 발생했어요. 다시 시도해 주세요."]) }

        static var legalSectionHeader: String { t("Legal", [
            .simplifiedChinese: "法律与隐私", .traditionalChinese: "法律與隱私", .german: "Rechtliches", .french: "Informations légales",
            .italian: "Note legali", .spanish: "Información legal", .portuguese: "Informações legais", .japanese: "法的情報", .korean: "법률"
        ]) }
        static var privacyPolicy: String { t("Privacy Policy", [
            .simplifiedChinese: "隐私政策", .traditionalChinese: "隱私政策", .german: "Datenschutzrichtlinie", .french: "Politique de confidentialité",
            .italian: "Informativa sulla privacy", .spanish: "Política de privacidad", .portuguese: "Política de privacidade", .japanese: "プライバシーポリシー", .korean: "개인정보 처리방침"
        ]) }
        static var termsOfUse: String { t("Terms of Use", [
            .simplifiedChinese: "使用条款", .traditionalChinese: "使用條款", .german: "Nutzungsbedingungen", .french: "Conditions d’utilisation",
            .italian: "Termini d’uso", .spanish: "Términos de uso", .portuguese: "Termos de uso", .japanese: "利用規約", .korean: "이용 약관"
        ]) }
        static let privacyPolicyURL = "https://decrave.net/privacy-policy.html"
        static let termsOfUseURL = "https://decrave.net/terms-of-service.html"

        static var exportTitle: String { dataExportRow }
        static var exportDescription: String { t("Download your craving records as a CSV file, including each trigger and intensity rating.", [
            .simplifiedChinese: "将想抽记录导出为 CSV 文件，包含每次的诱因和强度。", .traditionalChinese: "將想抽記錄匯出為 CSV 檔案，包含每次的誘因和強度。",
            .german: "Lade deine Einträge als CSV herunter, mit Auslöser und Stärke jedes Moments.", .french: "Télécharge tes notes au format CSV, avec le déclencheur et l’intensité de chaque envie.",
            .italian: "Scarica le tue registrazioni in CSV, con motivo e intensità di ogni voglia.", .spanish: "Descarga tus registros en CSV, con el motivo y la intensidad de cada impulso.",
            .portuguese: "Baixe seus registros em CSV, com gatilho e intensidade de cada vontade.", .japanese: "記録したきっかけや強さを含め、CSVファイルとして書き出せます。", .korean: "기록한 계기와 강도를 포함해 CSV 파일로 내려받을 수 있어요."
        ]) }
        static var exportRangeLabel: String { t("Period", [.simplifiedChinese: "时间范围", .traditionalChinese: "時間範圍", .german: "Zeitraum", .french: "Période", .italian: "Periodo", .spanish: "Período", .portuguese: "Período", .japanese: "期間", .korean: "기간"]) }
        static var exportRangeWeek: String { t("7 days", [.simplifiedChinese: "近 7 天", .traditionalChinese: "近 7 天", .german: "7 Tage", .french: "7 jours", .italian: "7 giorni", .spanish: "7 días", .portuguese: "7 dias", .japanese: "過去7日", .korean: "최근 7일"]) }
        static var exportRangeMonth: String { t("30 days", [.simplifiedChinese: "近 30 天", .traditionalChinese: "近 30 天", .german: "30 Tage", .french: "30 jours", .italian: "30 giorni", .spanish: "30 días", .portuguese: "30 dias", .japanese: "過去30日", .korean: "최근 30일"]) }
        static var exportRangeAllTime: String { t("All", [.simplifiedChinese: "全部", .traditionalChinese: "全部", .german: "Alle", .french: "Tout", .italian: "Tutto", .spanish: "Todo", .portuguese: "Tudo", .japanese: "すべて", .korean: "전체"]) }
        static var exportButton: String { t("Export CSV", [.simplifiedChinese: "导出 CSV", .traditionalChinese: "匯出 CSV", .german: "CSV exportieren", .french: "Exporter le CSV", .italian: "Esporta CSV", .spanish: "Exportar CSV", .portuguese: "Exportar CSV", .japanese: "CSVを書き出す", .korean: "CSV 내보내기"]) }
        static var exportLockedBody: String { t("Data export is included with Decrave Pro. SOS and your everyday tools remain free.", [
            .simplifiedChinese: "数据导出包含在 Decrave Pro 中。SOS 和日常应对工具仍可免费使用。", .traditionalChinese: "資料匯出包含在 Decrave Pro 中。SOS 和日常應對工具仍可免費使用。",
            .german: "Der Datenexport gehört zu Decrave Pro. SOS und deine täglichen Werkzeuge bleiben kostenlos.", .french: "L’export des données fait partie de Decrave Pro. SOS et les outils du quotidien restent gratuits.",
            .italian: "L’esportazione dei dati è inclusa in Decrave Pro. SOS e gli strumenti quotidiani restano gratuiti.", .spanish: "La exportación de datos está incluida en Decrave Pro. SOS y las herramientas diarias siguen siendo gratis.",
            .portuguese: "A exportação de dados está incluída no Decrave Pro. O SOS e as ferramentas do dia a dia continuam grátis.", .japanese: "データの書き出しはDecrave Proに含まれます。SOSと毎日の基本ツールは無料のままです。", .korean: "데이터 내보내기는 Decrave Pro에 포함돼요. SOS와 기본 도구는 계속 무료로 사용할 수 있어요."
        ]) }
    }

    enum Paywall {
        private static func t(_ english: String, _ translations: [AppLanguage: String]) -> String {
            Strings.localized(english, translations)
        }
        static var title: String { t("See more with Decrave Pro", [.simplifiedChinese: "用 Decrave Pro 看得更清楚", .traditionalChinese: "用 Decrave Pro 看得更清楚", .german: "Mehr erkennen mit Decrave Pro", .french: "Voir plus loin avec Decrave Pro", .italian: "Scopri di più con Decrave Pro", .spanish: "Conoce mejor tus patrones con Decrave Pro", .portuguese: "Entenda seus padrões com Decrave Pro", .japanese: "Decrave Proで傾向をもっと詳しく", .korean: "Decrave Pro로 내 패턴 더 알아보기"]) }
        static var subtitle: String { t("SOS stays free. Pro helps you understand your patterns and prepare for what comes next.", [
            .simplifiedChinese: "SOS 始终免费。Pro 帮你看清规律，提前做好准备。", .traditionalChinese: "SOS 始終免費。Pro 幫你看清規律，提前做好準備。",
            .german: "SOS bleibt kostenlos. Pro zeigt dir deine Muster und hilft dir, dich vorzubereiten.", .french: "SOS reste gratuit. Pro t’aide à comprendre tes habitudes et à te préparer.",
            .italian: "SOS resta gratuito. Pro ti aiuta a capire le tue abitudini e a prepararti.", .spanish: "SOS sigue siendo gratis. Pro te ayuda a entender tus patrones y a prepararte.",
            .portuguese: "O SOS continua grátis. O Pro ajuda você a entender seus padrões e a se preparar.", .japanese: "SOSはずっと無料です。Proでは自分の傾向を知り、次に備えられます。", .korean: "SOS는 계속 무료예요. Pro는 내 패턴을 이해하고 다음 순간에 대비하도록 도와줘요."
        ]) }

        // Each pairs with an SF Symbol in PaywallView.benefitsList — named to
        // match the exact in-app feature names (Trigger Radar, Peak hours)
        // rather than vague "see your patterns", so what's being unlocked is
        // concrete before the plan cards ask for money.
        static var benefitTriggerRadar: String { t("Trigger Radar — see when cravings often show up", [.simplifiedChinese: "诱因雷达：看看什么时候更容易想抽", .traditionalChinese: "誘因雷達：看看什麼時候較容易想抽", .german: "Auslöser-Radar: Wann das Verlangen oft kommt", .french: "Radar des envies : repère tes moments sensibles", .italian: "Radar dei momenti: scopri quando arriva la voglia", .spanish: "Radar de impulsos: descubre cuándo suelen aparecer", .portuguese: "Radar de gatilhos: veja quando a vontade costuma aparecer", .japanese: "トリガーレーダー：吸いたくなりやすい時間を確認", .korean: "계기 레이더: 자주 피우고 싶어지는 시간 확인"]) }
        static var benefitDeepInsights: String { t("Deeper insights — find the tools that help you", [.simplifiedChinese: "深入分析：找到对你有用的应对方式", .traditionalChinese: "深入分析：找出對你有幫助的應對方式", .german: "Mehr Einblicke: Welche Werkzeuge dir helfen", .french: "Analyses détaillées : vois ce qui t’aide vraiment", .italian: "Analisi dettagliate: scopri cosa ti aiuta davvero", .spanish: "Análisis detallados: descubre qué te ayuda", .portuguese: "Análises detalhadas: descubra o que ajuda você", .japanese: "詳しい分析：自分に合う対処法を見つける", .korean: "심층 분석: 나에게 도움이 된 방법 찾기"]) }
        static var benefitPeakHours: String { t("Peak hours — see your cravings by time of day", [.simplifiedChinese: "高峰时段：按小时查看想抽记录", .traditionalChinese: "高峰時段：按小時查看想抽記錄", .german: "Häufige Zeiten: Deine Einträge nach Uhrzeit", .french: "Heures sensibles : tes envies au fil de la journée", .italian: "Ore più difficili: le tue voglie durante la giornata", .spanish: "Horas difíciles: tus impulsos a lo largo del día", .portuguese: "Horários mais difíceis: veja a vontade ao longo do dia", .japanese: "時間帯ごとの傾向：欲求が起こりやすい時間を確認", .korean: "자주 힘든 시간: 시간대별 기록 확인"]) }
        static var benefitFullExport: String { t("Data export — keep a copy of your full history", [.simplifiedChinese: "数据导出：留一份完整记录", .traditionalChinese: "資料匯出：保留一份完整記錄", .german: "Datenexport: Deinen Verlauf als Kopie sichern", .french: "Export des données : garde une copie de ton historique", .italian: "Esporta i dati: conserva una copia della cronologia", .spanish: "Exportar datos: guarda una copia de todo tu historial", .portuguese: "Exportar dados: guarde uma cópia do seu histórico", .japanese: "データの書き出し：これまでの記録を保存", .korean: "데이터 내보내기: 전체 기록 따로 보관"]) }

        static var monthlyPlan: String { t("Monthly", [.simplifiedChinese: "月度", .traditionalChinese: "月費", .german: "Monatlich", .french: "Mensuel", .italian: "Mensile", .spanish: "Mensual", .portuguese: "Mensal", .japanese: "月額", .korean: "월간"]) }
        static var yearlyPlan: String { t("Yearly", [.simplifiedChinese: "年度", .traditionalChinese: "年費", .german: "Jährlich", .french: "Annuel", .italian: "Annuale", .spanish: "Anual", .portuguese: "Anual", .japanese: "年額", .korean: "연간"]) }
        static var lifetimePlan: String { t("Lifetime", [.simplifiedChinese: "终身", .traditionalChinese: "永久", .german: "Dauerhaft", .french: "À vie", .italian: "A vita", .spanish: "De por vida", .portuguese: "Vitalício", .japanese: "買い切り", .korean: "평생"]) }
        static var bestValueBadge: String { t("Best value", [.simplifiedChinese: "更划算", .traditionalChinese: "更划算", .german: "Bester Preis", .french: "Meilleur tarif", .italian: "Più conveniente", .spanish: "Mejor precio", .portuguese: "Melhor custo-benefício", .japanese: "お得", .korean: "가장 경제적"]) }
        static func freeTrialLabel(days: Int) -> String {
            switch AppLanguage.current.effective {
            case .simplifiedChinese: "免费试用 \(days) 天"
            case .traditionalChinese: "免費試用 \(days) 天"
            case .german: "\(days) Tage kostenlos testen"
            case .french: "\(days) jours d’essai gratuit"
            case .italian: "\(days) giorni di prova gratuita"
            case .spanish: "\(days) días de prueba gratis"
            case .portuguese: "\(days) dias grátis para testar"
            case .japanese: "\(days)日間無料でお試し"
            case .korean: "\(days)일 무료 체험"
            default: "\(days)-day free trial"
            }
        }
        static var lifetimeLabel: String { t("One-time purchase", [.simplifiedChinese: "一次付费", .traditionalChinese: "一次付費", .german: "Einmaliger Kauf", .french: "Achat unique", .italian: "Acquisto unico", .spanish: "Pago único", .portuguese: "Compra única", .japanese: "一度のお支払い", .korean: "일회성 구매"]) }

        static var continueCTA: String { t("Continue", [.simplifiedChinese: "继续", .traditionalChinese: "繼續", .german: "Weiter", .french: "Continuer", .italian: "Continua", .spanish: "Continuar", .portuguese: "Continuar", .japanese: "続ける", .korean: "계속"]) }
        static var startTrialCTA: String { t("Start free trial", [.simplifiedChinese: "开始免费试用", .traditionalChinese: "開始免費試用", .german: "Kostenlos testen", .french: "Commencer l’essai gratuit", .italian: "Inizia la prova gratuita", .spanish: "Empezar prueba gratis", .portuguese: "Começar teste grátis", .japanese: "無料体験を始める", .korean: "무료 체험 시작"]) }
        static var restorePurchases: String { Strings.Settings.restorePurchases }

        static var purchaseSuccessTitle: String { t("Decrave Pro is ready", [.simplifiedChinese: "Decrave Pro 已开通", .traditionalChinese: "Decrave Pro 已開通", .german: "Decrave Pro ist bereit", .french: "Decrave Pro est prêt", .italian: "Decrave Pro è attivo", .spanish: "Decrave Pro ya está listo", .portuguese: "Decrave Pro está pronto", .japanese: "Decrave Proが使えるようになりました", .korean: "Decrave Pro를 사용할 수 있어요"]) }

        static var loadErrorTitle: String { t("Plans couldn't load", [.simplifiedChinese: "暂时无法加载方案", .traditionalChinese: "暫時無法載入方案", .german: "Angebote konnten nicht geladen werden", .french: "Impossible de charger les offres", .italian: "Impossibile caricare i piani", .spanish: "No se pudieron cargar los planes", .portuguese: "Não foi possível carregar os planos", .japanese: "プランを読み込めませんでした", .korean: "요금제를 불러오지 못했어요"]) }
        static var loadErrorMessage: String { t("Check your connection and try again.", [.simplifiedChinese: "检查网络连接后再试一次。", .traditionalChinese: "檢查網路連線後再試一次。", .german: "Prüfe deine Verbindung und versuche es noch einmal.", .french: "Vérifie ta connexion et réessaie.", .italian: "Controlla la connessione e riprova.", .spanish: "Comprueba tu conexión e inténtalo de nuevo.", .portuguese: "Confira sua conexão e tente de novo.", .japanese: "通信状態を確認して、もう一度お試しください。", .korean: "인터넷 연결을 확인하고 다시 시도해 주세요."]) }
        static var retry: String { t("Try again", [.simplifiedChinese: "重试", .traditionalChinese: "再試一次", .german: "Erneut versuchen", .french: "Réessayer", .italian: "Riprova", .spanish: "Reintentar", .portuguese: "Tentar de novo", .japanese: "再試行", .korean: "다시 시도"]) }

        static var purchaseErrorTitle: String { t("Purchase didn't go through", [.simplifiedChinese: "购买未完成", .traditionalChinese: "購買未完成", .german: "Kauf nicht abgeschlossen", .french: "Achat non terminé", .italian: "Acquisto non riuscito", .spanish: "La compra no se completó", .portuguese: "A compra não foi concluída", .japanese: "購入を完了できませんでした", .korean: "구매를 완료하지 못했어요"]) }
        static var purchaseErrorMessage: String { t("Please try again in a moment.", [.simplifiedChinese: "请稍后再试。", .traditionalChinese: "請稍後再試。", .german: "Versuche es bitte gleich noch einmal.", .french: "Réessaie dans un instant.", .italian: "Riprova tra poco.", .spanish: "Vuelve a intentarlo en un momento.", .portuguese: "Tente novamente em instantes.", .japanese: "少し待ってからもう一度お試しください。", .korean: "잠시 후 다시 시도해 주세요."]) }

        static func billingPeriod(unit: String, value: Int) -> String {
            let number = value == 1 ? "" : String(value)
            switch AppLanguage.current.effective {
            case .simplifiedChinese: return "/\(number)\(["day": "天", "week": "周", "month": "月", "year": "年"][unit] ?? "")"
            case .traditionalChinese: return "/\(number)\(["day": "天", "week": "週", "month": "月", "year": "年"][unit] ?? "")"
            case .german: return "/\(number)\(["day": "Tag", "week": "Woche", "month": "Monat", "year": "Jahr"][unit] ?? "")"
            case .french: return "/\(number)\(["day": "jour", "week": "semaine", "month": "mois", "year": "an"][unit] ?? "")"
            case .italian: return "/\(number)\(["day": "giorno", "week": "settimana", "month": "mese", "year": "anno"][unit] ?? "")"
            case .spanish: return "/\(number)\(["day": "día", "week": "semana", "month": "mes", "year": "año"][unit] ?? "")"
            case .portuguese: return "/\(number)\(["day": "dia", "week": "semana", "month": "mês", "year": "ano"][unit] ?? "")"
            case .japanese: return "/\(number)\(["day": "日", "week": "週", "month": "月", "year": "年"][unit] ?? "")"
            case .korean: return "/\(number)\(["day": "일", "week": "주", "month": "개월", "year": "년"][unit] ?? "")"
            default:
                let name = ["day": "day", "week": "week", "month": "month", "year": "year"][unit] ?? ""
                return "/\(number)\(name)\(value == 1 ? "" : "s")"
            }
        }

        static func renewalDisclosure(price: String, period: String, trialDays: Int?) -> String {
            let charge = "\(price)\(period)"
            if let trialDays {
                switch AppLanguage.current.effective {
                case .simplifiedChinese: return "免费试用 \(trialDays) 天，之后为 \(charge)。取消前会自动续订。"
                case .traditionalChinese: return "免費試用 \(trialDays) 天，之後為 \(charge)。取消前會自動續訂。"
                case .german: return "\(trialDays) Tage kostenlos, danach \(charge). Verlängert sich bis zur Kündigung automatisch."
                case .french: return "\(trialDays) jours gratuits, puis \(charge). Renouvellement automatique jusqu’à résiliation."
                case .italian: return "\(trialDays) giorni gratis, poi \(charge). Si rinnova automaticamente finché non annulli."
                case .spanish: return "\(trialDays) días gratis; después, \(charge). Se renueva automáticamente hasta que canceles."
                case .portuguese: return "\(trialDays) dias grátis; depois, \(charge). Renova automaticamente até você cancelar."
                case .japanese: return "\(trialDays)日間無料。その後は\(charge)。解約するまで自動更新されます。"
                case .korean: return "\(trialDays)일 무료 체험 후 \(charge)입니다. 취소할 때까지 자동 갱신됩니다."
                default: return "\(trialDays)-day free trial, then \(charge). Auto-renews until canceled."
                }
            }
            return t("\(charge). Auto-renews until canceled.", [
                .simplifiedChinese: "\(charge)。取消前会自动续订。", .traditionalChinese: "\(charge)。取消前會自動續訂。",
                .german: "\(charge). Verlängert sich bis zur Kündigung automatisch.", .french: "\(charge). Renouvellement automatique jusqu’à résiliation.",
                .italian: "\(charge). Si rinnova automaticamente finché non annulli.", .spanish: "\(charge). Se renueva automáticamente hasta que canceles.",
                .portuguese: "\(charge). Renova automaticamente até você cancelar.", .japanese: "\(charge)。解約するまで自動更新されます。", .korean: "\(charge)입니다. 취소할 때까지 자동 갱신됩니다."
            ])
        }
    }
}
