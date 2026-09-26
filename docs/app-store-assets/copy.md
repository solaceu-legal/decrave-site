# Decrave — App Store Connect 文案与素材清单

更新日期：2026-09-26。适用于 Decrave v1.1。所有文案已按 `CLAUDE.md` §6 红线检查（无 treat/cure/heal/therapy/clinically proven/medical/diagnosis/prescription，无“烟瘾会消失”承诺）。

---

## 1. App 信息

| 字段 | 内容 | 字数限制 | 实际字数 |
|---|---|---|---|
| App 名称 (Name) | `Decrave: Quit Smoking Support` | 30 | 29 |
| 副标题 (Subtitle) | `No quit date required` | 30 | 21 |
| 分类 (Category) | Health & Fitness（主）/ Lifestyle（次，可选） | — | — |
| 版本号 | 1.1（Xcode：Build 3） | — | — |

**为什么是这两句**：竞品几乎都用"连续戒烟天数"做卖点，App 名称已经用完了"Quit Smoking"这个大家会搜的词；副标题专门用来打差异化——"不需要先定戒烟日"是这个 App 和所有竞品最大的不同（对应 `CLAUDE.md` §1）。

---

## 2. 推广文案 (Promotional Text)

> Still smoking? Start anyway. Open SOS in one tap, spot your triggers, and keep progress that never resets—even after a slip.

124/170 字符。这个字段可以**随时改，不用重新提审**。推广文案不参与 App Store 搜索排名，这一版专注表达 v1.1 的即时 SOS、诱因洞察和“永不归零”差异化。

---

## 3. 完整描述 (Description)

```
Decrave is for people who still smoke and want to quit — not only people who have already stopped.

Most quit-smoking apps begin by asking for the day you quit. Decrave doesn't. Start while you are still smoking, record the cravings you face, and build progress from every cigarette you choose not to smoke.

PROGRESS THAT NEVER RESETS
Decrave counts how many cravings you have beaten in total. That number only goes up. If you smoke, your previous wins still count and your progress does not return to zero.

SOS WHEN A CRAVING HITS
Open SOS in one tap and choose a short breathing, urge-surfing, or redirection exercise based on techniques studied for craving management. You can save favorite tools and, as you build a history, see suggestions based on the triggers and approaches you have logged.

With v1.1, SOS can also be reached from supported Home Screen and Lock Screen widgets, Control Center, and Shortcuts, so your next step is easier to find in the moment.

UNDERSTAND YOUR PATTERNS
Your Progress tab brings your history together in one place:
• Momentum that bends after a slip but never breaks
• Trigger Radar, top triggers, craving intensity, and peak-hour patterns
• Daily actions based on your own recent activity
• Money saved using the pack price and currency you choose
• Body-recovery milestones and long-term trends

PRIVATE BY DESIGN
No account is required. Your craving records remain on your devices and, when available, in your private iCloud database. Anonymous analytics are optional and off by default.

DECRAVE PRO
SOS, logging, Momentum, and everyday tools remain free. Decrave Pro adds deeper reports, longer-term trends, trigger-by-trigger analysis, peak-hour insights, and full data export.

Decrave supports English, Simplified Chinese, Traditional Chinese, German, French, Italian, Spanish, Portuguese, Japanese, and Korean.

Decrave is a wellness and habit-support tool, not a substitute for professional care. If you have questions about nicotine dependence, talk to a doctor.

Terms of Use (EULA): https://www.apple.com/legal/internet-services/itunes/dev/stdeula/
Privacy Policy: https://decrave.net/privacy-policy.html
```

远低于 4000 字符上限。v1.1 新增能力已写入，但没有加入无法验证的效果承诺。

⚠️ **最后两行链接是必须的，不是可选装饰**——v1.0 提审第一次被拒就是因为漏了这个（Guideline 3.1.2：订阅类 App 必须在 App Store 产品页面公开信息里放服务条款链接，App 内部 Settings 页面有链接不算数，审核员看的是不下载 App 也能看到的那一层）。之前我错误地认为"App 内已经有链接就够了"，这是我的判断失误，实际必须把链接放进 Description 里才算满足要求。以后改这段描述时，务必保留这两行。

---

## 4. 关键词 (Keywords，100 字符，逗号分隔无空格)

```
nicotine,tobacco,cigarette,cessation,withdrawal,craving,urge,tracker,reduce,stop,breathing,free,help
```

100/100 字节。`quit`、`smoking` 已经在 App 名称里出现，不重复占位；移除没有专属功能支持的 `vape`，以及容易偏向酒精/药物戒断语境的 `sobriety`、`recovery`、`relapse`，换成更贴近戒烟搜索意图的 `cigarette`、`cessation`、`withdrawal`、`reduce` 和 `stop`。

---

## 5. What's New（版本说明）

v1.1 英语（美国）版本说明：

```
Decrave 1.1 makes support easier to reach when a craving hits.

• Open SOS from the Home Screen, Lock Screen, Control Center, or Shortcuts.
• Save favorite tools and get suggestions based on your own patterns.
• Explore a redesigned Progress tab for trends, triggers, and personal data.
• Set your pack price and currency for more accurate savings.
• Use Decrave in English, Chinese, German, French, Italian, Spanish, Portuguese, Japanese, or Korean.
• Enjoy smoother exercises, logging, and settings.

Your cravings beaten still never reset.
```

中文版本说明见 `docs/Decrave-v1.1-release.md`。

---

## 6. v1.1 审核备注（英语）

```
Decrave does not require an account or login.

To access the purchase screen in v1.1:
1. Complete the first-launch onboarding.
2. Open the “Progress” tab.
3. Tap the gear button in the top-right corner.
4. Tap “Try Pro” in the Free Plan card.

The purchase screen offers:
- Monthly auto-renewable subscription
- Yearly auto-renewable subscription with a 7-day free trial for eligible users
- Lifetime non-consumable purchase

To restore purchases:
- Tap “Restore Purchases” on the purchase screen, or
- Open Progress → gear button → Restore Purchases under Decrave Pro.

SOS is the center tab. The Home Screen and Lock Screen widgets, Control Center control, and App Shortcut open the same SOS flow where supported by the OS.

Anonymous analytics are optional and disabled by default. Users can opt in during onboarding and change this later under Progress → gear button → Analytics.

Craving records are stored locally and, when available, in the user's private iCloud database. No demo account is required.
```

---

## 7. 订阅商品 (Decrave Pro)

代码里已经写好的商品 ID（来自 `SlipEasy/Services/ProProduct.swift`，**内部标识，不用改，也不需要跟品牌名一致**——这条和 Bundle ID 是同一个道理，见 `CLAUDE.md` §4.1）：

| Product ID | 类型 | 建议价格（来自 `docs/SlipEasy-v1.0-开发任务书.md`） | ASC 里必须填的"显示名称" |
|---|---|---|---|
| `com.slipeasy.pro.monthly` | 自动续费订阅 | $5.99 / 月 | **Decrave Pro Monthly** |
| `com.slipeasy.pro.yearly` | 自动续费订阅（主推，含 7 天试用） | $29.99 / 年 | **Decrave Pro Yearly** |
| `com.slipeasy.pro.lifetime` | 非消耗型内购（买断） | $59.99 一次性 | **Decrave Pro Lifetime** |

⚠️ **这一步是 `CLAUDE.md` §4.1 那次 Guideline 5.6 拒审事故的直接教训**——显示名称必须写 **Decrave**，绝对不能出现 SlipEasy 或 CraveCrush 这两个旧名字的任何残留。三个商品、每种语言（这里只做英文）都要单独检查一遍。

---

## 8. App Privacy（隐私“营养标签”）问卷怎么填

我读了代码里实际的数据行为（`PrivacyInfo.xcprivacy`、`Services/Analytics.swift`、`Services/StoreManager.swift`）和已经写好的 `docs/legal/privacy-policy.html`，两边应该完全对得上：

**数据收集情况**：
- **App 功能所需数据**：无。所有烟瘾记录、目标、价格设置都只存在设备本地 SwiftData / iCloud 私有库（CloudKit），Decrave 团队自己拿不到。
- **分析数据（TelemetryDeck）**：会收集"产品交互"类事件（如 `craving_logged`、`app_opened`），但**不含姓名、邮箱、设备广告标识符（IDFA）、IP**。ASC 问卷里对应勾选：
  - Data Type: **Product Interaction**（或 "Other Usage Data"）
  - Data Type: **Device ID**（TelemetryDeck 用于生成不关联身份的隐私保护标识；其 SDK 隐私清单明确申报了这一项）
  - Linked to your identity: **No**
  - Used for tracking: **No**（这一点很重要，`PrivacyInfo.xcprivacy` 里 `NSPrivacyTracking` 已经是 `false`，如果 ASC 问卷选了"是用于 tracking"，会跟这个文件互相矛盾导致审核问题）
  - App 内默认关闭；用户在 onboarding 明确同意后才开始发送，并可在 Progress → 右上角设置 → Analytics 随时撤回
- **订阅/内购**：StoreKit 直连，Decrave 自己不接触也不存储支付信息，这部分数据由 Apple 处理，问卷里可以直接说明"handled by Apple"或对应勾选"Not collected by developer"。
- **不收集**：位置、联系人、照片、健康数据（HealthKit 没用到）、精确/粗略地理位置、用户内容分享给第三方。

**填表路径**：App Store Connect → 选中 App → App Privacy → Get Started，按上面的分类逐项勾选。

---

## 9. Age Rating（年龄分级）问卷怎么填

⚠️ 这块最早查资料时判断错了，后来对照真实上架的同类 App 才更正——记录一下更正后的结论，避免以后又翻回旧版本。

Decrave 涉及"烟草"这个主题，属于新问卷里 **Mature Themes（成人题材）→ Alcohol, Tobacco, or Drug Use or References** 这一项。最早以为 App 只是"提到"吸烟、没有画面，应该选偏轻的 "Infrequent/Mild"（对应 13+）。但实际去查了几个已上架的同类戒烟 App（EasyQuit、Kwit、Smoke Free、iQuit、Tobaquit）的公开分级，全部都是选 **"Frequent/Intense"（频繁）**，没有一个是"偶尔"——原因是这道题问的是"用户在 App 里多频繁遇到这个话题"，不是"App 的意图是否鼓励吸烟"，而 Decrave 的核心循环（记录烟瘾、"I smoked"按钮、每日抽几根）几乎每次打开都在处理这个主题，属于高频。

最终选择：

- **Frequent/Intense（频繁）** → 对应最终评级 **18+**（已经在 ASC 里实际选出这个结果，`docs/legal/privacy-policy.html` §7 儿童隐私那段也已经跟着改成"18+、不面向 18 岁以下"）

医疗信息那一题（"医疗或治疗信息"）选的是 **偶尔**（不是无，也不是频繁）——对应 Home 页的 Body recovery 时间线卡片，同样参照了这几个同类 App 的公开分级（它们也都是选 Infrequent Medical Treatment information）。"健康或保健主题"选**是**。

**填表路径**：App Store Connect → App Information → Age Ratings → Set Up Age Rating，一共 7 步问卷。

Sources:
- [Updated age ratings in App Store Connect – Apple Developer](https://developer.apple.com/news/?id=ks775ehf)
- [EasyQuit - Stop Smoking on the App Store](https://apps.apple.com/us/app/easyquit-stop-smoking/id1508110799)
- [Smoke Free - Quit Smoking Now on the App Store](https://apps.apple.com/us/app/smoke-free-quit-smoking-now/id577767592)
- [App Store Connect Help — Age ratings](https://developer.apple.com/help/app-store-connect/reference/age-ratings)

---

## 10. Support URL / Marketing URL

- **Support URL（必填）**：`https://decrave.net/support.html`（已上线）
- **Marketing URL（建议填写）**：`https://decrave.net/`（已上线）
- **隐私政策 URL**：`https://decrave.net/privacy-policy.html`
- **服务条款 URL**：`https://decrave.net/terms-of-service.html`（这个要填在 ASC 的 EULA 字段，不是 Support URL 字段）

---

## 11. v1.1 截图状态

本轮不替换 App Store Connect 中的 v1.0 截图。v1.1 截图将在下一轮单独复核版式、顺序和设备尺寸后再上传；提交审核前必须完成替换，避免商店页面展示已经变更的旧导航和旧界面。
