//
//  Strings.swift
//  SlipEasy
//
//  Centralized user-facing copy. Not final marketing copy — wording will
//  be refined after interviews (see docs), but redline words are avoided
//  even in this skeleton.
//

import Foundation

enum Strings {

    enum Onboarding {
        static let introTitle = "Most apps start on the day you quit."
        static let introSubtitle = "This one starts while you're still smoking."
        static let introContinue = "Continue"

        static let statusQuestion = "What's your situation right now?"
        static let statusA = "I already quit, staying quit"
        static let statusB = "I still smoke, and I want to quit"
        static let statusC = "I still smoke, and I want to cut down"

        static let cigsQuestion = "About how many cigarettes a day?"
        static let cigsDone = "Done"
    }

    enum Home {
        static let cravingsBeaten = "cravings beaten"
        static let wantToSmoke = "I want to smoke"
        static let iSmoked = "I smoked"
        static let last7Days = "Last 7 days"
    }

    enum Intervention {
        static let phase1Prompt = "Where do you feel it? Chest, throat, hands?"
        static let phase2Prompt = "Don't fight it. Just describe it. Is it hot? Tight? Moving?"
        static let phase3Prompt = "Notice if it changes. It might get stronger first. That's normal."
        static let phase4Prompt = "You're having the craving. You're not smoking. Both are true right now."
        static let exit = "Exit"

        static let endLine1 = "The craving may still be here."
        static let endLine2 = "That's okay — it's not supposed to disappear."
        static let endLine3 = "You just practiced having it without smoking."
        static let didntSmoke = "I didn't smoke"
        static let smoked = "I smoked"
    }

    enum Log {
        static let title = "Quick log"
        static let triggerQuestion = "What triggered it?"
        static let intensityQuestion = "How intense?"
        static let submit = "Done"
    }

    enum Relapse {
        static let logged = "Logged."
        static func winsStillCount(_ n: Int) -> String {
            "Your \(n) wins are still \(n)."
        }
        static let neverReset = "They don't reset. Ever."
        static let back = "Back"
    }
}
