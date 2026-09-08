# CLAUDE.md — Decrave

放在 Xcode 工程根目录。Claude Code 每次开工会自动读取。
新增经验时直接追加，不要删旧条目 —— 这个文件的价值来自累积。

---

## 1. 项目是什么

戒烟 App，iOS 单人开发，面向英语市场（美/英/加/澳）。

**核心机制**：记录"战胜的烟瘾次数"，而不是"连续戒烟天数"。**这个数字永不归零**，即使用户复吸。

**目标用户**：想戒但**还没戒**的人。这是与所有竞品的分界线——别的 App 开局问"你哪天戒的"，我们不问。

**当前阶段**：v0.1 极薄验证版（TestFlight，不上架，无付费，无同步）。
范围见 `docs/14天薄版本.md`。**范围之外的功能不要主动实现，也不要主动建议实现。**

---

## 2. 和我协作的方式

我是产品负责人，能读懂代码结构和逻辑，但**不是专业 iOS 开发**。据此：

- **改动超过 3 个文件之前，先说方案，等我确认再动手。** 不要一次性大重构
- 报错时，先用一句人话说明"发生了什么"，再给修复方案。不要直接甩 diff
- 涉及 Xcode 项目设置、签名、Capability、App Store Connect 的操作，**给我逐步点击路径**（"Xcode → 选中 target → Signing & Capabilities → +Capability → ..."），因为这些你改不了
- 不确定 API 或 iOS 版本行为时，明说"我不确定，需要查"，不要猜一个 API 名字出来
- 每完成一个功能，告诉我**怎么手动验证它**（点哪里、看到什么算对）

---

## 3. 技术栈（不要引入清单外的依赖）

| 层 | 技术 | 备注 |
|---|---|---|
| UI | SwiftUI，iOS 17+ | |
| 本地存储 | SwiftData | v0.1 纯本地 |
| 云同步 | CloudKit 私有数据库 | **v0.1 不做**，v1.0 才加 |
| 订阅 | StoreKit 2 直连 | **v0.1 不做**。不用 RevenueCat |
| 通知 | UserNotifications | **v0.1 故意不做**（要测自然打开率） |
| 分析 | TelemetryDeck | 匿名，无个人信息 |
| 图表 | Swift Charts | 系统自带，不引第三方 |

**零第三方依赖是硬约束。** 需要引入任何 SPM 包，先问我。

---

## 4. Lenire 项目踩过的坑（真实事故，逐条避免）

上一个 App（Lenire）实际发生过的问题。每条都花过真金白银的时间。

### 4.1 ⚠️ 命名一致性 —— 曾导致 Guideline 5.6 拒审

**事故**：App 显示名改成 Lenire 后，App Store Connect 里的订阅商品展示名仍是旧名 "SolaceU"，被以 Guideline 5.6（开发者行为准则 / 隐藏功能）拒绝。**一行代码都改不了这个问题。**

**规则**：
- 品牌名 **Decrave 现在定死，永不更改**（2026-09 从 SlipEasy 改名而来，SlipEasy 之前是 2026-08 从 CraveCrush 改来的——这已经是第二次"最后一次改名"了。此时同样还没有任何 ASC 订阅商品上线、没有提审，仍属于安全窗口内。**教训：上次写"永不更改"没拦住这次改名，说明这条规则真正该管的是"改名这件事本身要走完整清单"，而不是假设不会再发生**）。所有对外可见的地方必须逐字一致
- 域名：原来的 **slipeasy.cc** 已经不适用，新域名待定——**在新域名确定并且隐私政策/服务条款迁移过去之前，不要提审**
- 提交前必须逐项核对以下清单：

```
[ ] Xcode → Display Name (CFBundleDisplayName)
[ ] App Store Connect → App 名称
[ ] App Store Connect → 订阅群组 显示名称
[ ] App Store Connect → 每个订阅商品的显示名称（每种语言都要检查）
[ ] App 内所有硬编码的产品名字符串
[ ] 隐私政策页面里的产品名
[ ] 服务条款页面里的产品名
[ ] 支持网址页面里的产品名
```

- Bundle ID 是内部标识，**不需要**和品牌名一致，也**不要**为了好看去改它（改 Bundle ID 等于换一个 App）
- 同理：**不要重命名 Xcode 工程文件**。工程内部名和品牌名无关，改它只会引入构建问题

### 4.2 订阅的脆弱点在配置，不在代码

StoreKit 2 的代码部分很短，Claude Code 能很快写对。真正出问题的永远是 App Store Connect 侧的配置：订阅群组、价格档、各语言的商品显示名、审核用的截图。
→ **写订阅代码之前，先在 ASC 把商品建好并填完所有语言，再写代码。**（v0.1 不涉及）

### 4.3 隐私政策和服务条款必须先上线

Lenire 用 GitHub Pages 托管，之前 SlipEasy 沿用 slipeasy.cc——改名 Decrave 后这个域名不再适用，新域名/托管地址待定。
**提交审核前这两个 URL 必须能在无痕窗口打开**，否则直接被拒。

### 4.4 登录方式

Lenire 用 Sign in with Apple 作为唯一登录方式。
Decrave v0.1 **完全不做账号**。v1.0 也优先不做——CloudKit 私有库天然跟随用户的 iCloud 账号，不需要自建账号体系。

### 4.5 多语言要连商店元数据一起做

Lenire 上线时是英文默认 + 简中 + 繁中。教训：App 内本地化做了，App Store 描述和**订阅商品名**的本地化容易漏。
Decrave v0.1 **只做英文**，不要主动加本地化脚手架。

### 4.6 夜间可用性是硬需求

Lenire 的用户常在深夜情绪低落时使用。Decrave 同理——烟瘾高峰常在夜间。
→ 所有颜色用系统语义色（`Color.primary` / `.secondary` / `Color(.systemBackground)`），深色模式自动生效。
→ 支持动态字体（Dynamic Type），不要写死 `.font(.system(size: 14))`。

---

## 5. SwiftData + CloudKit 硬约束（现在就要遵守）

v0.1 不开同步，**但数据模型现在就按同步的约束写**，否则 v1.0 加同步时要重做整个模型和迁移。

启用 CloudKit 后 SwiftData 的限制：

- ❌ 不能用 `@Attribute(.unique)`
- ❌ 所有属性必须是 **Optional 或带默认值**
- ❌ 关系必须是 Optional
- ❌ 不支持 `@Attribute(.allowsCloudEncryption)` 以外的部分修饰符组合

**写法示例：**

```swift
@Model
final class CravingLog {
    var timestamp: Date = Date()          // ✅ 有默认值
    var trigger: String?                  // ✅ Optional
    var intensity: Int = 3                // ✅ 有默认值
    var didSmoke: Bool = false            // ✅ 有默认值
    var id: UUID = UUID()                 // ✅ 不加 .unique
    init() {}                             // ✅ 无参 init
}
```

另外，v1.0 加同步时记得：
- CloudKit schema 改动后必须在 CloudKit Dashboard **手动部署到 Production**，否则 TestFlight/线上版本会静默失败
- 必须处理"用户未登录 iCloud"的降级路径：纯本地可用，不弹错误

---

## 6. 文案红线（合规 + 科学，两条都不能破）

### 6.1 绝对不能出现的词（Apple 健康类审核）

`treat` `cure` `heal` `therapy` `clinically proven` `medical` `diagnosis` `prescription`
中文：治疗、治愈、临床验证、医学证明、诊断、疗效

替代：`help` `support` `based on techniques studied in...`

### 6.2 绝对不能出现的承诺（科学准确性）

❌ "The craving will pass in 3–5 minutes"
❌ "Beat the craving away"
❌ 任何暗示烟瘾会在计时结束时消失的表述

**原因**：研究显示正念/urge surfing 并不降低烟瘾强度，只改变人对烟瘾的反应。如果用户计时结束后烟瘾还在，"承诺落空"会被归因为个人失败——这恰好制造了本产品要消除的破戒效应。

✅ 正确措辞：`You just practiced having it without smoking.`

### 6.3 复吸场景的措辞

❌ `failed` `relapse` `start over` `back to zero` `streak lost`
✅ `logged` `你的 N 次战胜依然有效` `永不归零`

**复吸屏必须主动重申计数有效**，不能只是"不减少"。

### 6.4 视觉素材

App 图标和 App Store 截图中**不得出现香烟、烟盒、打火机、烟雾的具象图形**。
原因：Apple 广告政策禁止含有烟草制品及器具的广告内容，而广告素材由 App Store 提交内容生成——出现这些会同时影响审核和后续投放资格。
✅ 用抽象波浪（呼应 urge surfing）、大号数字、单色几何。

---

## 7. 代码约定

- 目录：`Models/` `Views/` `Services/` `Resources/`
- 一个 View 一个文件，超过 150 行就拆
- 业务逻辑不写在 View 里，放 `Services/`
- 所有用户可见字符串集中在 `Resources/Strings.swift`（v0.1 不引 Localizable.strings，但字符串要集中，方便 v1.0 迁移）
- 埋点统一走 `Services/Analytics.swift` 一个入口，不在 View 里直接调 TelemetryDeck
- 提交信息用中文，一句话说清改了什么

---

## 8. 每次构建前的自检

```
[ ] 在真机上跑过（不只是模拟器）
[ ] 深色模式看过
[ ] 最大动态字体下没有截断
[ ] 冷启动到主按钮可点 < 1.5 秒
[ ] 主按钮点击到干预页 < 300ms
[ ] 计时器切后台/锁屏后仍正确
[ ] 复吸流程走了一遍，确认没有出现红线词
[ ] 第 4.1 节的命名清单核对过（仅提交审核时）
```

---

## 9. 当前不要做的事

以下每一条都会拖垮 v0.1 的 2 周时限：

- ❌ CloudKit 同步
- ❌ 推送通知（**故意的**：要测无提醒条件下的自然打开率）
- ❌ StoreKit / 付费墙
- ❌ 除 Urge Surfing 外的其他干预工具
- ❌ 图表、周报、热力图（主页 7 根柱子已足够）
- ❌ Widget
- ❌ 多语言
- ❌ iPad 适配
- ❌ 自定义设计系统 / 动画库
- ❌ 单元测试覆盖率目标（关键逻辑写测试即可，不追覆盖率）

想加任何一条，先问我。
