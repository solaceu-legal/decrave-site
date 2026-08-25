//
//  NotificationManager.swift
//  SlipEasy
//

import Foundation
import UserNotifications

enum NotificationManager {
    private static let dailyReminderID = "daily-checkin"
    private static let reminderHour = 19 // 7pm — a reasonable default check-in time

    /// Only ever called from the settings toggle's onChange, never from
    /// onAppear/Onboarding — the system permission prompt should appear
    /// exactly once, at the moment the user actively opts in.
    static func requestAuthorizationAndSchedule() async -> Bool {
        let center = UNUserNotificationCenter.current()
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        if granted {
            scheduleDailyReminder()
        }
        return granted
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

    private static func scheduleDailyReminder() {
        let content = UNMutableNotificationContent()
        content.title = Strings.DailyReminder.title
        content.body = Strings.DailyReminder.body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = reminderHour
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: dailyReminderID, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
