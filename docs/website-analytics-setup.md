# Decrave 官网统计接入

更新时间：2026-10-03

## 目标

建立两层统计：

1. Plausible：官网访问、来源、设备、国家，以及 App Store 按钮点击与首页指南入口点击。
2. App Store Connect Campaign Link：从官网进入商店后的产品页访问、首次下载、销售与订阅归因。

官网的五个 App Store 入口已在 `website/index.html` 中标记：

| 位置 | `data-analytics-location` |
|---|---|
| 顶部导航 | `header` |
| 首屏商店按钮 | `hero` |
| Free 价格卡 | `pricing_free` |
| Pro 价格卡 | `pricing_pro` |
| 页面底部 | `footer` |

## 当前接入状态

- Plausible 站点脚本：已接入首页。
- 自定义事件：`App Store Click`；新增 `Guide Open`（首页免费烟瘾指南入口，代码待发布）。
- Plausible 自定义转化目标：原有 `App Store Click` 保留；2026-10-03 已创建并确认 `Guide Open`。
- 自定义属性：`button_location`。2026-10-03 已登记到 Plausible 的 Custom properties；此前代码已发送，但设置列表为空。值包括上述五个下载位置、已有指南下载位置；`Guide Open` 的值为 `hero`。
- 新事件只传递按钮位置，不传递个人烟瘾、诱因、记录内容或邮箱。
- Plausible 报告时区：Asia/Shanghai；试用状态剩余 24 天（2026-10-03 读取），本轮没有购买方案或承诺付费。
- Apple Campaign：`Website`。
- Apple Campaign Link：

```text
https://apps.apple.com/app/apple-store/id6801961627?pt=129291985&ct=Website&mt=8
```

官网五个按钮共用一个 Apple `Website` 活动链接，按钮位置差异由 Plausible 记录，避免早期下载量被拆散后达不到 Apple 的隐私显示门槛。

## 发布后验证

1. 打开 Plausible 实时视图，再访问一次 `https://decrave.net/`，确认出现页面访问。
2. 分别点击五个 App Store 按钮，确认出现 `App Store Click`，并可按 `button_location` 查看位置。
3. 点击首屏的 “Read a free craving guide”，确认导航到烟瘾指南，并出现 `Guide Open` / `button_location=hero`。两个目标和属性登记已完成；新入口的线上事件需发布后验证。
4. 检查跳转后的 App Store URL 仍包含 `pt=129291985`、`ct=Website` 和 `mt=8`。
5. Apple Campaign 数据通常不会实时出现，应在 App Store Connect 中稍后复查，并注意低于隐私门槛的指标可能不显示。
6. 记录每次人工验证的时间和入口；只做少量必要点击，避免把自己的验证当作真实增长。本轮本地自动检查阻断外部统计请求，没有生成线上测试点击。

## 2026-10-03 基线快照

- Plausible 的 Last 28 days：8 位独立访客、8 次访问、10 次页面浏览；`App Store Click` 为 2 位独立访客、2 次事件，后台 CR 为 25%。
- 来源显示 Direct / None 6 位、Product Hunt 2 位。自己的历史验证访问是否包含在内尚未排除。
- 这是全站窗口口径，样本很小；不能把 25% 当作稳定转化率，也不能据此前后波动判断文案效果。
- Search Console 的 3 个月窗口：1 次曝光、0 次点击；查询词明细无数据。网页索引报告正在处理，现场 Core Web Vitals 无数据，均不能记为不合格。
- Website Campaign 首次下载与商店转化率本轮未读取，记为 unavailable，不能推断为零。
- 详细修改和验收见 [第 1、2 期实施记录](Decrave-第1-2期实施记录.md)。

## 建议关注的指标

- App Store 点击率 = App Store 点击访客数 ÷ 官网独立访客数
- 商店下载转化率 = Website Campaign 首次下载 ÷ 商店产品页访问
- 官网最终转化率 = Website Campaign 首次下载 ÷ 官网独立访客数
- 各按钮贡献 = 各 `location` 的点击数与点击率
- 指南入口点击访客数：用于观察下载前内容需求；没有对应区块曝光统计时，不声称是“看过入口的人”的点击率。
