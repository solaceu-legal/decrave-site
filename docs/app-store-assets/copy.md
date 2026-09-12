# Decrave — App Store Connect 文案与素材清单

生成日期：2026-09-09。所有文案已按 `CLAUDE.md` §6 红线检查（无 treat/cure/heal/therapy/clinically proven/medical/diagnosis/prescription，无"烟瘾会消失"承诺）。

---

## 1. App 信息

| 字段 | 内容 | 字数限制 | 实际字数 |
|---|---|---|---|
| App 名称 (Name) | `Decrave: Quit Smoking Support` | 30 | 29 |
| 副标题 (Subtitle) | `No quit date required` | 30 | 21 |
| 分类 (Category) | Health & Fitness（主）/ Lifestyle（次，可选） | — | — |
| 版本号 | 1.0（已在 Xcode 里设好，不用改） | — | — |

**为什么是这两句**：竞品几乎都用"连续戒烟天数"做卖点，App 名称已经用完了"Quit Smoking"这个大家会搜的词；副标题专门用来打差异化——"不需要先定戒烟日"是这个 App 和所有竞品最大的不同（对应 `CLAUDE.md` §1）。

---

## 2. 推广文案 (Promotional Text)

> Still smoking? Start anyway. Decrave counts every craving you beat — not days since you quit. A slip doesn't erase your count. Zero is impossible.

146/170 字符。这个字段可以**随时改，不用重新提审**，适合后续做 A/B 测试或节日文案。

---

## 3. 完整描述 (Description)

```
Decrave is for people who still smoke and want to quit — not people who already have.

Most quit-smoking apps start by asking "what day did you quit?" Decrave doesn't. It's built for the messier, more honest part before that: the part where you're still smoking sometimes, still slipping, and still trying anyway.

THE COUNT THAT NEVER RESETS
Every other app tracks a streak — one slip and you're back to Day 0. Decrave counts something different: how many cravings you've beaten, total, ever. That number only goes up. If you smoke, it doesn't move backward. It just waits for the next craving you beat.

IN THE MOMENT
When a craving hits, open Decrave and ride it out with a short breathing and urge-surfing exercise, based on techniques studied for craving management. You're not promised the craving will vanish — it might still be there when you finish. What changes is that you'll have just practiced having it without smoking.

WHAT YOU'LL SEE
• Momentum score — a gentler alternative to a streak that bends when you slip, but never breaks
• Trigger Radar — learn when and why your cravings tend to hit hardest
• Money saved — a running total based on your own price per pack, never resets
• Craving intensity, top triggers, and peak-hour charts, built entirely from your own logged data
• Milestones for every 5th, 10th, 25th craving beaten, all the way up

DECRAVE PRO
Free users get the core loop: logging, the in-the-moment tool, Momentum, and headline stats. Decrave Pro unlocks deeper insight into your own patterns — trigger-by-trigger breakdowns, peak-hour prediction, and full data export — for people who want to understand their habit, not just track it.

Decrave is a wellness and habit-support tool, not a substitute for professional care. If you have questions about nicotine dependence, talk to a doctor.

Terms of Use (EULA): https://www.apple.com/legal/internet-services/itunes/dev/stdeula/
Privacy Policy: https://decrave.net/privacy-policy.html
```

约 1500 字符，远低于 4000 上限，没有必要硬凑满。

⚠️ **最后两行链接是必须的，不是可选装饰**——v1.0 提审第一次被拒就是因为漏了这个（Guideline 3.1.2：订阅类 App 必须在 App Store 产品页面公开信息里放服务条款链接，App 内部 Settings 页面有链接不算数，审核员看的是不下载 App 也能看到的那一层）。之前我错误地认为"App 内已经有链接就够了"，这是我的判断失误，实际必须把链接放进 Description 里才算满足要求。以后改这段描述时，务必保留这两行。

---

## 4. 关键词 (Keywords，100 字符，逗号分隔无空格)

```
nicotine,tobacco,vape,relapse,urge,craving,tracker,habit,addiction,recovery,mindfulness,sobriety
```

96/100 字符。"quit"、"smoking" 已经在 App 名称里出现过（Apple 会自动索引名称/副标题里的词），这里故意不重复，省下的字符位换成别的搜索词。

---

## 5. What's New（版本说明）

之前说"首个版本不会展示这一栏"不准确，实际是个空输入框——既然会显示，写一段简短的欢迎语+亮点比空着好。这个字段的本职是"这个版本改了什么"，v1.0 没有上一版可比，所以不用写成完整功能清单（那是 Description 的活），保持简短；等 v1.1 更新时这里的内容会被新版本说明覆盖，现在写的东西本来就是临时的。

```
Welcome to Decrave.

Decrave is built for people who still smoke and want to quit — no quit date required. Log every craving you beat, and watch a number that never resets, no matter what happens along the way.

This first release includes:
• A private, in-the-moment tool for riding out a craving
• Money saved and cravings beaten, tracked for good
• Trigger Radar, Momentum, and body-recovery milestones
• Decrave Pro: deeper insight into your own patterns, plus full data export

Thanks for trying it early — we'd love to hear what you think.
```

约 480 字符。

---

## 6. 订阅商品 (Decrave Pro) —— App Store Connect 里要新建的 3 个商品

代码里已经写好的商品 ID（来自 `SlipEasy/Services/ProProduct.swift`，**内部标识，不用改，也不需要跟品牌名一致**——这条和 Bundle ID 是同一个道理，见 `CLAUDE.md` §4.1）：

| Product ID | 类型 | 建议价格（来自 `docs/SlipEasy-v1.0-开发任务书.md`） | ASC 里必须填的"显示名称" |
|---|---|---|---|
| `com.slipeasy.pro.monthly` | 自动续费订阅 | $9.99 / 月 | **Decrave Pro Monthly** |
| `com.slipeasy.pro.yearly` | 自动续费订阅（主推，含 7 天试用） | $59.99 / 年 | **Decrave Pro Yearly** |
| `com.slipeasy.pro.lifetime` | 非消耗型内购（买断） | $99.99 一次性 | **Decrave Pro Lifetime** |

⚠️ **这一步是 `CLAUDE.md` §4.1 那次 Guideline 5.6 拒审事故的直接教训**——显示名称必须写 **Decrave**，绝对不能出现 SlipEasy 或 CraveCrush 这两个旧名字的任何残留。三个商品、每种语言（这里只做英文）都要单独检查一遍。

---

## 7. App Privacy（隐私"营养标签"）问卷怎么填

我读了代码里实际的数据行为（`PrivacyInfo.xcprivacy`、`Services/Analytics.swift`、`Services/StoreManager.swift`）和已经写好的 `docs/legal/privacy-policy.html`，两边应该完全对得上：

**数据收集情况**：
- **App 功能所需数据**：无。所有烟瘾记录、目标、价格设置都只存在设备本地 SwiftData / iCloud 私有库（CloudKit），Decrave 团队自己拿不到。
- **分析数据（TelemetryDeck）**：会收集"产品交互"类事件（如 `craving_logged`、`app_opened`），但**不含姓名、邮箱、设备广告标识符（IDFA）、IP**。ASC 问卷里对应勾选：
  - Data Type: **Product Interaction**（或 "Other Usage Data"）
  - Data Type: **Device ID**（TelemetryDeck 用于生成不关联身份的隐私保护标识；其 SDK 隐私清单明确申报了这一项）
  - Linked to your identity: **No**
  - Used for tracking: **No**（这一点很重要，`PrivacyInfo.xcprivacy` 里 `NSPrivacyTracking` 已经是 `false`，如果 ASC 问卷选了"是用于 tracking"，会跟这个文件互相矛盾导致审核问题）
  - App 内默认关闭；用户在 onboarding 明确同意后才开始发送，并可在 You 页随时撤回
- **订阅/内购**：StoreKit 直连，Decrave 自己不接触也不存储支付信息，这部分数据由 Apple 处理，问卷里可以直接说明"handled by Apple"或对应勾选"Not collected by developer"。
- **不收集**：位置、联系人、照片、健康数据（HealthKit 没用到）、精确/粗略地理位置、用户内容分享给第三方。

**填表路径**：App Store Connect → 选中 App → App Privacy → Get Started，按上面的分类逐项勾选。

---

## 8. Age Rating（年龄分级）问卷怎么填

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

## 9. Support URL / Marketing URL

- **Support URL（必填）**：`https://decrave.net/support.html` —— 我已经写好了这个页面：[docs/legal/support.html](../legal/support.html)，风格和已有的隐私政策/服务条款页面一致，包含常见问题（订阅怎么取消、复吸算不算清零等）。**现在还是本地文件，需要你部署上线后这个 URL 才能真正打开。**
- **Marketing URL（选填）**：可以先留空，或者以后有独立官网了再填，不影响提审。
- **隐私政策 URL**：`https://decrave.net/privacy-policy.html`
- **服务条款 URL**：`https://decrave.net/terms-of-service.html`（这个要填在 ASC 的 EULA 字段，不是 Support URL 字段）
