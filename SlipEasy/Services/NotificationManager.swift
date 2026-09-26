//
//  NotificationManager.swift
//  SlipEasy
//

import Foundation
import UserNotifications

enum NotificationManager {
    private static let dailyReminderID = "daily-checkin"
    private static let reminderHour = 19 // 7pm — a reasonable default check-in time
    private static let sosSourceKey = "sosSource"
    private static let delegate = NotificationDelegate()

    /// Installs the response handler before the first notification can be
    /// delivered. Tapping a reminder should land in SOS, including when the
    /// app was not already running.
    static func configure() {
        UNUserNotificationCenter.current().delegate = delegate
    }

    /// Only ever called from the settings toggle's onChange, never from
    /// onAppear/Onboarding — the system permission prompt should appear
    /// exactly once, at the moment the user actively opts in.
    static func requestAuthorizationAndSchedule(predictedWindow: InsightsEngine.PredictedWindow? = nil) async -> Bool {
        let center = UNUserNotificationCenter.current()
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        if granted {
            scheduleReminder(predictedWindow: predictedWindow)
        }
        return granted
    }

    /// Rebuilds the existing reminder without asking for permission again.
    /// Settings calls this when the user returns to the screen so a newly
    /// learned Trigger Radar window can replace the default time.
    static func refreshSchedule(predictedWindow: InsightsEngine.PredictedWindow? = nil) {
        scheduleReminder(predictedWindow: predictedWindow)
    }

    static func cancel() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
    }

    /// Reflects the true system authorization state — used to correct the
    /// in-app toggle if the user revoked permission from iOS Settings
    /// directly instead of through this app.
    static func isAuthorized() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }

    private static func scheduleReminder(predictedWindow: InsightsEngine.PredictedWindow?) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [dailyReminderID])

        let content = UNMutableNotificationContent()
        content.title = Strings.DailyReminder.title
        content.body = Strings.DailyReminder.body(for: predictedWindow)
        content.sound = .default
        content.userInfo = [sosSourceKey: SOSLaunchSource.notification.rawValue]

        var dateComponents = DateComponents()
        if let predictedWindow {
            // Trigger Radar's weekday+hour pair is a recurring pattern, so
            // the reminder runs once per week at the user's usual window.
            dateComponents.weekday = predictedWindow.weekday
            dateComponents.hour = predictedWindow.hour
        } else {
            // Keep the original daily check-in for people who have not yet
            // logged enough moments for a reliable prediction.
            dateComponents.hour = reminderHour
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: dailyReminderID, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

private final class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let rawSource = response.notification.request.content.userInfo["sosSource"] as? String
        let source = rawSource.flatMap(SOSLaunchSource.init(rawValue:)) ?? .notification
        SOSLaunchRequest.request(source: source)
        completionHandler()
    }
}
