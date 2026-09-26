//  InterventionPrompts.swift
//  Decrave
//
//  Four complete, locally written urge-surfing arcs per language. An arc is
//  kept together so the final line follows what the person just observed.

import Foundation

extension Strings.Intervention {
    static func localizedUrgeSurfingPromptSets(for language: AppLanguage, fallback: [[String]]) -> [[String]] {
        switch language {
        case .simplifiedChinese:
            return [
                ["这阵想抽的感觉在哪里？胸口、喉咙，还是手上？", "先不用赶它走。只是看看：紧绷、发热，还是坐立不安？", "它可能一会儿强、一会儿弱。留意变化就好。", "感觉还在，你也可以先不抽。再待一会儿。"],
                ["把想抽的感觉想成一阵浪。它从哪里涌上来？", "不用急着躲开，看看它此刻是什么样。", "浪头可能还会抬高。你可以继续站在这里，慢慢看着它。", "这一阵正在过去。现在，先不拿起烟。"],
                ["先注意自己的呼吸。是浅了，快了，还是憋着？", "不用刻意调整，看看下一口气会怎样。", "身体也许还紧着。给自己一点时间。", "你在呼吸，也在等这阵想抽慢慢变化。"],
                ["看看双手。它们在找什么，还是只是闲不住？", "可以把手放在腿上，感受一下这股想伸手的劲。", "不用马上回应它。先等过这几秒。", "手还在这里，选择也还在你手里。"]
            ]
        case .traditionalChinese:
            return [
                ["這陣想抽的感覺在哪裡？胸口、喉嚨，還是手上？", "先不用趕它走。只是看看：緊繃、發熱，還是坐立不安？", "它可能一會兒強、一會兒弱。留意變化就好。", "感覺還在，你也可以先不抽。再待一會兒。"],
                ["把想抽的感覺想成一陣浪。它從哪裡湧上來？", "不用急著躲開，看看它此刻是什麼樣。", "浪頭可能還會抬高。你可以繼續站在這裡，慢慢看著它。", "這一陣正在過去。現在，先不拿起菸。"],
                ["先注意自己的呼吸。是淺了、快了，還是憋著？", "不用刻意調整，看看下一口氣會怎樣。", "身體也許還緊著。給自己一點時間。", "你在呼吸，也在等這陣想抽慢慢變化。"],
                ["看看雙手。它們在找什麼，還是只是閒不住？", "可以把手放在腿上，感受一下這股想伸手的勁。", "不用馬上回應它。先等過這幾秒。", "手還在這裡，選擇也還在你手裡。"]
            ]
        case .german:
            return [
                ["Wo spürst du das Verlangen gerade – in der Brust, im Hals, in den Händen?", "Du musst es nicht wegdrücken. Wie fühlt es sich an: eng, warm, unruhig?", "Vielleicht wird es stärker, vielleicht schwächer. Beobachte einfach, was passiert.", "Das Verlangen ist da. Du kannst trotzdem noch warten, bevor du rauchst."],
                ["Stell dir das Verlangen wie eine Welle vor. Wo beginnt sie?", "Du musst ihr nicht ausweichen. Schau nur, wie sie sich gerade anfühlt.", "Die Welle kann noch steigen. Bleib einen Moment und beobachte sie.", "Du bist noch hier. Die Zigarette kann noch warten."],
                ["Wie atmest du gerade – flach, schnell oder hältst du die Luft an?", "Du brauchst nichts zu verändern. Nimm nur den nächsten Atemzug wahr.", "Vielleicht bleibt dein Körper noch angespannt. Gib dir etwas Zeit.", "Du atmest weiter. Auch dieses Gefühl darf sich verändern."],
                ["Was machen deine Hände gerade? Sind sie ruhig oder suchen sie etwas?", "Leg sie einmal auf deine Beine. Spür, wie stark der Impuls ist.", "Du musst ihm nicht sofort folgen. Warte nur ein paar Sekunden.", "Deine Hände sind da. Die Entscheidung bleibt bei dir."]
            ]
        case .french:
            return [
                ["Où sens-tu l’envie ? Dans la poitrine, la gorge, les mains ?", "Pas besoin de la chasser. Observe-la : chaleur, tension, agitation ?", "Elle peut monter ou baisser. Regarde simplement ce qui change.", "L’envie est là. Tu peux aussi attendre encore avant de fumer."],
                ["Imagine l’envie comme une vague. D’où part-elle ?", "Tu n’as pas à l’éviter. Regarde la forme qu’elle prend maintenant.", "La vague peut encore monter. Reste là un instant et observe.", "Tu es toujours là. La cigarette peut attendre."],
                ["Comment respires-tu en ce moment ? Vite, doucement, en retenant ton souffle ?", "Ne force rien. Porte juste attention à ta prochaine respiration.", "Ton corps est peut-être encore tendu. Donne-toi un peu de temps.", "Tu continues de respirer. Cette sensation peut changer."],
                ["Que font tes mains ? Sont-elles immobiles ou cherchent-elles quelque chose ?", "Pose-les sur tes jambes et sens l’envie de bouger.", "Tu n’es pas obligé d’y répondre tout de suite. Attends quelques secondes.", "Tes mains sont là. Le choix t’appartient toujours."]
            ]
        case .italian:
            return [
                ["Dove senti la voglia adesso? Nel petto, in gola, nelle mani?", "Non serve mandarla via. Osserva com’è: calore, tensione, irrequietezza?", "Può salire o scendere. Nota soltanto se cambia qualcosa.", "La voglia c’è. Puoi comunque aspettare ancora prima di fumare."],
                ["Immagina la voglia come un’onda. Da dove parte?", "Non devi evitarla. Guarda che forma ha in questo momento.", "L’onda può salire ancora. Resta qui un attimo e osserva.", "Sei ancora qui. La sigaretta può aspettare."],
                ["Com’è il tuo respiro adesso? Corto, veloce, trattenuto?", "Non devi cambiarlo. Nota soltanto il prossimo respiro.", "Il corpo può restare teso per un po’. Concediti tempo.", "Continui a respirare. Anche questa sensazione può cambiare."],
                ["Che cosa fanno le tue mani? Sono ferme o cercano qualcosa?", "Prova ad appoggiarle sulle gambe e senti la voglia di muoverle.", "Non devi seguirla subito. Aspetta solo qualche secondo.", "Le mani sono qui. La scelta resta tua."]
            ]
        case .spanish:
            return [
                ["¿Dónde notas las ganas ahora: en el pecho, la garganta, las manos?", "No hace falta apartarlas. Obsérvalas: ¿calor, tensión, inquietud?", "Puede que suban o bajen. Fíjate solo en lo que cambia.", "Las ganas siguen ahí. También puedes esperar un poco antes de fumar."],
                ["Imagina las ganas como una ola. ¿Dónde empieza?", "No tienes que esquivarla. Mira cómo se siente ahora mismo.", "La ola puede subir un poco más. Quédate y obsérvala un momento.", "Sigues aquí. El cigarrillo puede esperar."],
                ["¿Cómo respiras ahora: rápido, superficial, aguantando el aire?", "No intentes cambiarlo. Nota simplemente la próxima respiración.", "Puede que tu cuerpo siga tenso. Date un poco de tiempo.", "Sigues respirando. Esta sensación también puede cambiar."],
                ["¿Qué hacen tus manos? ¿Están quietas o buscan algo?", "Déjalas sobre las piernas y nota las ganas de moverlas.", "No tienes que hacerles caso ahora. Espera unos segundos.", "Tus manos están aquí. La decisión sigue siendo tuya."]
            ]
        case .portuguese:
            return [
                ["Onde você sente a vontade agora: no peito, na garganta, nas mãos?", "Não precisa espantar a vontade. Observe: calor, aperto, inquietação?", "Ela pode aumentar ou diminuir. Só perceba o que muda.", "A vontade ainda está aí. Você também pode esperar mais um pouco antes de fumar."],
                ["Imagine essa vontade como uma onda. Onde ela começa?", "Não precisa fugir dela. Veja como ela está neste momento.", "A onda pode subir mais um pouco. Fique aqui e observe.", "Você continua aqui. O cigarro pode esperar."],
                ["Como está sua respiração agora: curta, rápida, presa?", "Não tente mudar nada. Apenas perceba a próxima respiração.", "Seu corpo talvez continue tenso. Dê um tempo a si mesmo.", "Você continua respirando. Essa sensação também pode mudar."],
                ["O que suas mãos estão fazendo? Estão paradas ou procurando algo?", "Apoie as mãos nas pernas e sinta a vontade de movê-las.", "Você não precisa seguir esse impulso agora. Espere alguns segundos.", "Suas mãos estão aqui. A escolha continua sendo sua."]
            ]
        case .japanese:
            return [
                ["吸いたい気持ちは、今どこにありますか。胸、喉、それとも手？", "追い払わなくて大丈夫。熱さ、こわばり、落ち着かなさを感じてみましょう。", "強くなったり弱くなったりするかもしれません。変化を見ているだけで十分です。", "まだ吸いたくても、今はもう少し待つことを選べます。"],
                ["吸いたい気持ちを波にたとえると、どこから始まっていますか？", "よけようとせず、今の波の形を見てみましょう。", "波はもう少し高くなるかもしれません。ここで少し眺めてみてください。", "あなたはここにいます。たばこは、まだ手に取らなくて大丈夫。"],
                ["今の呼吸はどうですか。浅い、速い、止めている？", "変えようとせず、次のひと呼吸に気づいてみましょう。", "体がまだ緊張していても大丈夫。少し時間をあげてください。", "呼吸を続けながら、この感じがどう変わるか待ってみましょう。"],
                ["今、手は何をしていますか。落ち着かない感じはありますか？", "手を膝に置いて、動かしたい気持ちを感じてみましょう。", "すぐにその気持ちに従わなくても大丈夫。数秒だけ待ってみてください。", "手はここにあります。どうするかは、まだ自分で選べます。"]
            ]
        case .korean:
            return [
                ["지금 피우고 싶은 마음이 어디에서 느껴지나요? 가슴, 목, 손?", "억지로 없애려 하지 않아도 돼요. 뜨겁거나 답답하거나 들뜨나요?", "조금 강해지거나 약해질 수도 있어요. 어떻게 달라지는지만 살펴보세요.", "마음은 아직 남아 있어도, 지금은 조금 더 기다릴 수 있어요."],
                ["피우고 싶은 마음을 파도라고 생각해 보세요. 어디서 시작되나요?", "피하려고 애쓰지 말고 지금 어떤 모양인지 바라보세요.", "파도가 조금 더 높아질 수도 있어요. 여기서 잠시 지켜봐요.", "지금도 잘 버티고 있어요. 담배는 조금 더 기다려도 됩니다."],
                ["지금 호흡은 어떤가요? 얕거나 빠르거나 숨을 참고 있나요?", "억지로 바꾸지 말고 다음 숨 한 번만 느껴 보세요.", "몸이 아직 긴장돼도 괜찮아요. 시간을 조금 주세요.", "숨을 쉬면서 이 느낌이 어떻게 달라지는지 기다려 봐요."],
                ["지금 손은 무엇을 하고 있나요? 가만히 있나요, 뭔가를 찾나요?", "손을 무릎 위에 올리고 움직이고 싶은 마음을 느껴 보세요.", "그 마음을 바로 따라갈 필요는 없어요. 몇 초만 기다려 봐요.", "손은 여기 있어요. 다음 행동은 여전히 내가 고를 수 있어요."]
            ]
        case .system, .english:
            return fallback
        }
    }
}
