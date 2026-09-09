//
//  Strings.swift
//  Decrave
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

        static let priceQuestion = "About how much is a pack?"
        static let priceCaption = "This is what turns every craving you beat into money back in your pocket."
        static let priceDone = "That's motivating"
    }

    enum Home {
        static let cravingsBeaten = "cravings beaten"
        static let last7Days = "Cravings beaten — last 7 days"

        static let moneySavedCaption = "saved · never resets"
        static let momentumLabel = "Momentum"
        static func cigsAvoided(_ n: Int) -> String { "\(n) avoided" }
        static func timeReclaimed(_ text: String) -> String { "\(text) reclaimed" }

        static let bodyRecoveryTitle = "Body recovery"
        static let sinceLastCigarette = "Since your last cigarette"
        static let noCigaretteLoggedYet = "Starts once you log your first craving"

        static let triggerRadarEyebrow = "Trigger Radar"
        static let proBadge = "PRO"
        static let triggerRadarPlaceholder = "Log a few more cravings and Trigger Radar will start predicting your next window."
        static func triggerRadarPreview(weekday: String, hour: String) -> String {
            "Next likely window: \(weekday) around \(hour)."
        }
        static func triggerRadarPreview(weekday: String, hour: String, trigger: String) -> String {
            "Next likely window: \(weekday) around \(hour) — \(trigger) tends to trigger it."
        }
        // Split title/subtitle pair used by the Home card's redesigned
        // layout (see TriggerRadarPreviewCard) — the two triggerRadarPreview
        // functions above stay as-is since WeeklyReportView's detail section
        // still builds its one-line sentence from them.
        static func triggerRadarWindowLabel(weekday: String, hour: String) -> String {
            "\(weekday) around \(hour)"
        }
        static func triggerRadarTriggerNote(trigger: String, occurrences: Int) -> String {
            "\(trigger) tends to trigger it — based on \(occurrences) logged cravings."
        }
        static func triggerRadarOccurrenceNote(occurrences: Int) -> String {
            "Based on \(occurrences) logged cravings so far."
        }
        static let triggerRadarPreviewCTA = "Preview radar"

        static let questEyebrow = "Today's quest"
        static let questTitle = "The 4-minute delay"
        static let questBody = "Practice riding out an urge before it happens for real — breathe through it, no cigarette required."
        static func questMomentumTag(_ n: Int) -> String { "+\(n) Momentum" }
        static let questAccept = "Accept quest"
        static let questAccepted = "Accepted ✓"
    }

    enum Tab {
        static let home = "Home"
        static let insights = "Insights"
        static let you = "You"
        // Visible on the pill itself — short on purpose, it's the only
        // text in the tab bar's fixed-width center cell.
        static let sosButtonShortLabel = "Decrave it"
        // Accessibility label only — more descriptive than the visible
        // "Decrave it" text (see MainFlowView).
        static let sosButtonLabel = "I want to smoke"
    }

    enum Intervention {
        // 8 complete four-line arcs, rotated one per Urge Surfing session
        // (see InterventionView) so repeat users don't see identical copy
        // every time. Each arc keeps the same beats as the original
        // (locate → describe without fighting → notice it may intensify →
        // "both true" reframe) — sets are reviewed as whole units, never
        // mixed with lines from another set.
        static let urgeSurfingPromptSets: [[String]] = [
            [
                "Where do you feel it? Chest, throat, hands?",
                "Don't fight it. Just describe it. Is it hot? Tight? Moving?",
                "Notice if it changes. It might get stronger first. That's normal.",
                "You're having the craving. You're not smoking. Both are true right now."
            ],
            [
                "Picture it like a wave. Where does it start?",
                "Don't paddle away. Just watch its shape — sharp, dull, steady?",
                "It might rise before it falls. That's just how waves move.",
                "You're riding it out. You're not smoking. Both are true right now."
            ],
            [
                "Notice your breath right now. Shallow? Fast? Held?",
                "Don't force it slower. Just watch it. Does it shift on its own?",
                "It might feel tighter for a moment. That's part of it, not a problem.",
                "You're breathing through it. You're not smoking. Both are true right now."
            ],
            [
                "What are your hands doing? Still, fidgeting, reaching?",
                "Let them be restless if they are. Just notice the pull to move.",
                "It might feel more urgent before it eases. That's expected, not alarming.",
                "Your hands are restless. You're not smoking. Both are true right now."
            ],
            [
                "What can you hear right now, without trying to change it?",
                "Let the craving sit alongside the sound. Don't push either away.",
                "The craving might get louder in your mind first. That's normal here.",
                "You're noticing both. You're not smoking. Both are true right now."
            ],
            [
                "This has a start. Notice the moment you're in right now.",
                "Don't rush past it. Just stay with what the next few seconds feel like.",
                "A minute from now it may feel different — stronger or weaker. Either is fine.",
                "You're staying with it. You're not smoking. Both are true right now."
            ],
            [
                "What thought showed up first? Notice it without answering it yet.",
                "Don't argue with the thought. Just watch where it goes next.",
                "It might get more insistent for a moment. That's what thoughts do.",
                "You're noticing the thought. You're not smoking. Both are true right now."
            ],
            [
                "Scan from head to hands. Where does the craving actually sit?",
                "Stay there without trying to fix it. Just notice its edges.",
                "It might spread or shift as you watch. That's just what it does.",
                "You're scanning through it. You're not smoking. Both are true right now."
            ]
        ]
        static let exit = "Exit"

        static let endLine1 = "The craving may still be here."
        static let endLine2 = "That's okay — it's not supposed to disappear."
        static let endLine3 = "You just practiced having it without smoking."
        static let didntSmoke = "I didn't smoke"
        static let smoked = "I smoked"

        static let breatheInPrompt = "Breathe in"
        static let holdPrompt = "Hold"
        static let breatheOutPrompt = "Breathe out"

        static let rideTheUrge = "Ride the urge →"
        static let imFineNow = "I'm fine now"
        static let stillHere = "Still here — try something else"
    }

    enum SOS {
        static let toolboxTitle = "Still here. Let's redirect."
        static let toolboxSubtitle = "Pick anything — action can help more than waiting it out."

        static let delayTitle = "Delay 4:00"
        static let delaySubtitle = "Change rooms, then decide."
        static let delayDone = "Time's up — how do you feel?"

        static let iceTitle = "Ice water"
        static let iceSubtitle = "A quick shock to the system."
        static let iceToast = "Cold water on your wrists or face — 20 seconds."

        static let moveTitle = "Move 20"
        static let moveSubtitle = "Burn off the restlessness."
        static let moveToast = "20 jumping jacks, or a lap around the room."

        static let nrtTitle = "NRT nudge"
        static let nrtSubtitle = "Gum, patch, or lozenge."
        static let nrtToast = "If you've got gum or a patch on hand, now's a good time."

        static let whyTitle = "Why I quit"
        static let whySubtitle = "Your reason, on demand."
        static let whyToast = "Whatever brought you here — it's still true right now."

        static let feelBetter = "I feel better — log it"
        static let stillSmoked = "I smoked"
    }

    enum Log {
        static let title = "Quick log"
        static let triggerQuestion = "What triggered it?"
        static let intensityQuestion = "How intense?"
        static let submit = "Done"

        static let victoryTitle = "Craving beaten."
        static func victorySubtitle(money: String, momentum: Int) -> String {
            "That's +\(money) saved and +\(momentum) momentum."
        }
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
        static let title = "Insights"

        static let milestonesTitle = "Milestones"
        static let notEnoughData = "Not enough data yet — log a few more cravings this week."

        static let lockedTitle = "Unlock with Decrave Pro"
        static let lockedBody = "See your patterns over time — peak hours, top triggers, and trends. Everything you need to beat a craving stays free."
        static let unlockCTA = "See plans"

        // Section-level locks (see ProLockedSection) — the two deeper,
        // predictive layers plus peak hours stay Pro; Craving intensity /
        // Top triggers / Money trajectory above are free, matching
        // Decrave's own free/Pro boundary.
        static let unlockInsightsCTA = "Unlock deep insights"
        static let unlockRadarCTA = "Unlock Trigger Radar"
        static let unlockPeakHoursCTA = "Unlock peak hours"

        static let peakHoursTitle = "When cravings hit hardest"
        static func peakHoursCaption(_ hour: String) -> String {
            "Most cravings hit around \(hour)."
        }

        static let triggerRadarDetailTitle = "Trigger Radar"
        static func triggerRadarDetailBody(occurrences: Int) -> String {
            "Based on \(occurrences) logged cravings in this window so far."
        }
        static let triggerRadarNotEnoughData = "Log a few more cravings and Trigger Radar will start predicting your next window."

        static let moneyTrajectoryTitle = "Money trajectory"
        static func moneyTrajectoryCaption(_ amount: String) -> String {
            "At your current pace, that's \(amount) a year from now."
        }

        static let cravingIntensityEyebrow = "Craving intensity"
        static let cravingIntensityTitle = "This week's intensity"
        static func peakWindowCaption(weekday: String, hour: String) -> String {
            "Peak window: \(weekday) around \(hour)."
        }

        static let topTriggersEyebrow = "Top triggers"
        static func triggerPercentage(_ percent: Int) -> String { "\(percent)%" }
    }

    enum Insights {
        static let sectionTitle = "Insights"

        static let triggerPatternTitle = "A pattern worth noticing"
        static func triggerPatternBody(trigger: CravingTrigger, count: Int) -> String {
            "You tend to smoke \(triggerClause(trigger)) — that's happened \(count) times in the past 7 days."
        }
        // Each trigger needs its own preposition/phrasing to read naturally
        // in "You tend to smoke ___" — a single lowercased(label) template
        // doesn't work across all of them ("after break" reads wrong).
        private static func triggerClause(_ trigger: CravingTrigger) -> String {
            switch trigger {
            case .coffee: return "after coffee"
            case .meal: return "after meals"
            case .stress: return "when you're stressed"
            case .alcohol: return "after drinking"
            case .breakTime: return "on breaks"
            case .boredom: return "when you're bored"
            case .other: return "in similar moments"
            }
        }
        // Preferred over triggerSuggestion when there's enough crossed data
        // (this trigger + a tool used together) — more specific than the
        // generic per-trigger tip below.
        static func triggerToolSuggestion(attemptCount: Int, beatenCount: Int) -> String {
            if attemptCount == beatenCount {
                return "When you used a craving tool for this trigger, you didn't smoke — every single time. Worth trying again next time."
            }
            return "When you used a craving tool for this trigger, you didn't smoke \(beatenCount) out of \(attemptCount) times. Worth trying again next time."
        }
        static func triggerSuggestion(_ trigger: CravingTrigger) -> String {
            switch trigger {
            case .coffee: return "Next time, try switching up the after-coffee moment — water, a walk, or a different spot to sit."
            case .meal: return "Next time, try stepping outside for a few minutes or putting on a song before deciding."
            case .stress: return "Next time, the breathing exercise before deciding might help take the edge off the moment."
            case .alcohol: return "This one's harder to plan around in the moment — even changing where you're sitting can help."
            case .breakTime: return "Next time, try filling the first few minutes of a break with something else first."
            case .boredom: return "Next time, a two-minute distraction — a message, a quick tidy — can carry you past the moment."
            case .other: return "Notice what's around you right when the urge shows up — that's the pattern worth watching."
            }
        }

        static let toolEffectivenessTitle = "Progress, not luck"
        static func toolEffectivenessBody(attemptCount: Int, beatenCount: Int) -> String {
            if attemptCount == beatenCount {
                return "You used a craving tool \(attemptCount) times this week — and didn't smoke, every single time."
            }
            return "You used a craving tool \(attemptCount) times this week — and didn't smoke \(beatenCount) of those times."
        }
    }

    enum DailyReminder {
        static let title = "Decrave"
        static let body = "Having a craving? A few minutes here can help."
    }

    enum Settings {
        static let title = "Settings"

        static let logSlipRow = "I smoked — log it safely"

        static let freeTitle = "Free plan"
        static let freeSubtitle = "Unlimited insights, Trigger Radar & deep reports"
        static let memberTitle = "Decrave Pro"
        static let memberSubtitle = "All features unlocked"
        static let tryProCTA = "Try Pro"

        static let yourNumbersHeader = "Your numbers"
        static let moneySavedLabel = "money saved"
        static let cigsAvoidedLabel = "cigarettes avoided"
        static let cravingsBeatenLabel = "cravings beaten"
        static let momentumLabel = "current momentum"

        static let promiseTitle = "The Never-Reset Promise"
        static let promiseSubtitle = "Why Decrave never zeroes your progress"
        static let promiseHeading = "🛡️ The Never-Reset Promise"
        static let promiseIntro = "Streak-reset is the #1 reason people abandon quit apps. Shame kills attempts. So Decrave works differently:"
        static let promisePoint1Title = "Progress is a bank, not a streak"
        static let promisePoint1Body = "Cravings beaten and money saved — once earned, always yours."
        static let promisePoint2Title = "Momentum bends, never breaks"
        static let promisePoint2Body = "A slip costs a little Momentum. Beating the next craving earns it back. Zero is impossible."
        static let promisePoint3Title = "A slip is logged, not punished"
        static let promisePoint3Body = "There's no failure screen and no lost streak — just a safe place to log it and keep going."

        static let notificationsToggle = "Daily reminder"
        static let notificationsFooter = "A once-a-day nudge to check in. Off by default — you decide."

        static let proSectionHeader = "Decrave Pro"
        static let dataExportRow = "Export your data"

        static let restorePurchases = "Restore purchases"
        static let restoreSuccessTitle = "Purchases restored"
        static let restoreSuccessMessage = "Your Decrave Pro access is active."
        static let restoreEmptyTitle = "Nothing to restore"
        static let restoreEmptyMessage = "We didn't find any previous Decrave Pro purchases for this Apple ID."
        static let restoreErrorTitle = "Couldn't restore purchases"
        static let restoreErrorMessage = "Something went wrong. Please try again."

        static let legalSectionHeader = "Legal"
        static let privacyPolicy = "Privacy Policy"
        static let termsOfUse = "Terms of Use"
        static let privacyPolicyURL = "https://decrave.net/privacy-policy.html"
        static let termsOfUseURL = "https://decrave.net/terms-of-service.html"

        static let exportTitle = "Export your data"
        static let exportDescription = "Download everything you've logged as a CSV file — every craving, trigger, and intensity you've recorded."
        static let exportRangeLabel = "Range"
        static let exportRangeWeek = "Week"
        static let exportRangeMonth = "Month"
        static let exportRangeAllTime = "All time"
        static let exportButton = "Export as CSV"
        static let exportLockedBody = "Data export is part of Decrave Pro. Everything you need to beat a craving stays free."
    }

    enum Paywall {
        static let title = "Unlock Decrave Pro"
        static let subtitle = "See your patterns over time, and export everything you've logged. The tools to face a craving stay free — always."

        static let bestValueBadge = "Best value"
        static func freeTrialLabel(days: Int) -> String {
            "\(days)-day free trial"
        }
        static let lifetimeLabel = "One-time purchase"

        static let continueCTA = "Continue"
        static let startTrialCTA = "Start Free Trial"
        static let restorePurchases = "Restore purchases"

        static let purchaseSuccessTitle = "Welcome to Pro"

        static let loadErrorTitle = "Couldn't load plans"
        static let loadErrorMessage = "Check your connection and try again."
        static let retry = "Retry"

        static let purchaseErrorTitle = "Purchase failed"
        static let purchaseErrorMessage = "Something went wrong. Please try again."
    }
}
