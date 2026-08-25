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
        static let statusC = "I still smoke, and I'm not ready to set a quit date yet"

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

        static let breatheInPrompt = "Breathe in... 4"
        static let holdPrompt = "Hold... 7"
        static let breatheOutPrompt = "Breathe out... 8"

        static let toolPickerQuestion = "Which would help right now?"
        static let urgeSurfingTitle = "Urge Surfing"
        static let urgeSurfingSubtitle = "Notice the craving without fighting it. About 3 minutes."
        static let breathingTitle = "4-7-8 Breathing"
        static let breathingSubtitle = "A slower breath pattern to settle into. About a minute."
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

    enum ReductionGoal {
        static let cardTitlePrompt = "Set a daily goal"
        static let cardSubtitlePrompt = "See your progress against a target you choose."
        static let setGoalCTA = "Set goal"

        static let goalQuestion = "What's a realistic target for today?"
        static let goalSave = "Save"

        static func todayProgress(smoked: Int, target: Int) -> String {
            "\(smoked) of \(target) today"
        }

        static let proposalTitle = "You've hit your goal for two weeks."
        static let proposalBody = "Some people find this is a good moment to pick a quit day. No pressure — you can keep going at your own pace."
        static let proposalAccept = "Set a quit day"
        static let proposalDecline = "Not now"

        static let quitDateQuestion = "When do you want to quit?"
        static let quitDateSave = "Set date"
    }

    enum Report {
        static let title = "Weekly Report"

        static func winsThisWeek(_ n: Int) -> String {
            "\(n) cravings beaten this week"
        }

        static let peakHoursTitle = "When cravings hit hardest"
        static let topTriggersTitle = "Top triggers"
        static let notEnoughData = "Not enough data yet — log a few more cravings this week."

        static let lockedTitle = "Unlock with SlipEasy Pro"
        static let lockedBody = "See your patterns over time — peak hours, top triggers, and trends. Everything you need to beat a craving stays free."
        static let unlockCTA = "See plans"
    }

    enum DailyReminder {
        static let title = "SlipEasy"
        static let body = "Having a craving? A few minutes here can help."
    }

    enum Settings {
        static let title = "Settings"

        static let notificationsToggle = "Daily reminder"
        static let notificationsFooter = "A once-a-day nudge to check in. Off by default — you decide."

        static let proSectionHeader = "SlipEasy Pro"
        static let dataExportRow = "Export your data"

        static let manageSubscription = "Manage subscription"
        static let restorePurchases = "Restore purchases"
        static let restoreAlertTitle = "Nothing to restore yet"
        static let restoreAlertMessage = "SlipEasy Pro isn't available for purchase yet — check back soon."

        static let legalSectionHeader = "Legal"
        static let privacyPolicy = "Privacy Policy"
        static let termsOfUse = "Terms of Use"
        static let privacyPolicyURL = "https://solaceu-legal.github.io/slipeasy-legal/privacy-policy.html"
        static let termsOfUseURL = "https://solaceu-legal.github.io/slipeasy-legal/terms.html"

        static let exportTitle = "Export your data"
        static let exportDescription = "Download everything you've logged as a CSV file — every craving, trigger, and intensity you've recorded."
        static let exportButton = "Export as CSV"
        static let exportLockedBody = "Data export is part of SlipEasy Pro. Everything you need to beat a craving stays free."
    }
}
