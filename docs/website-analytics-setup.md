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
- 自定义事件：`App Store Click`；新增 `Guide Open`（首页免费烟瘾指南入口，已于 2026-10-03 22:04 发布）。
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
3. 点击首屏的 “Read a free craving guide”，确认导航到烟瘾指南，并出现 `Guide Open` / `button_location=hero`。两个目标和属性登记已完成，22:05 起人工验收的指南跳转正常；本次后台检查暂未显示新事件，回传仍待确认，不能认为已经验收通过。
4. 检查跳转后的 App Store URL 仍包含 `pt=129291985`、`ct=Website` 和 `mt=8`。
5. Apple Campaign 数据通常不会实时出现，应在 App Store Connect 中稍后复查，并注意低于隐私门槛的指标可能不显示。
6. 记录每次人工验证的时间和入口；只做少量必要点击，避免把自己的验证当作真实增长。本轮本地自动检查阻断外部统计请求，没有生成线上测试点击。

2026-10-03 第 3 期补充核查：Plausible 官方安装检查显示 “Tracking is active on your site / Visitors are being counted correctly”。访问统计接入确认通过；Guide Open 尚未在报表出现，仍需正常用户浏览器单独验证。脚本会排除常见自动化环境，因此不能凭自动化点击未出现就判定安装失败。见 [第 3 期验证记录](Decrave-第3期体验验证记录.md)。

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

## 第 3 期 Web SOS 发布批次

用户已明确授权在首页增加入口并发布。首屏 App Store 按钮下方新增 “Try one minute of SOS”，跳转至 `/sos/`。商店下载链接沿用同一 Website 活动。

| 事件 | 触发 | 属性 |
| --- | --- | --- |
| `SOS Open` | 首页点击体验入口 | `button_location=hero` |
| `SOS Started` | 开始或重新开始练习 | 无 |
| `SOS Timer Completed` | 本次练习计时结束，仅一次 | 无 |
| `SOS Ended Early` | 用户主动提前结束，仅一次 | 无 |
| `App Store Click` | 体验结束页点击商店入口 | `button_location=sos_summary` |

四个 SOS 自定义目标已在 Plausible 后台创建并确认；原有目标保留。页面与隐私说明同步更新。不记录阶段、精确时长、暂停次数、烟瘾强度、诱因或吸烟结果，不保存个人练习历史。计时完成不是“战胜烟瘾”或戒烟效果。

发布前隔离浏览器检查已通过：12 种 SOS 页面布局、4 种首页宽度及入口导航、暂停/继续/重开、计时完成去重、提前结束独立统计、商店按钮属性与无存储。外部统计请求被拦截，没有向线上报表制造测试量。真实报表回传须与代码检查区分，尚待正常访客事件出现后确认。

评估时分别查看 `/sos/` 的访问、开始访客数、计时完成与提前结束访客数，以及 `sos_summary` 的商店点击。重复练习会增加事件次数；采用访客口径时仍不可把多项汇总数当作同一批人的完整路径，更不能宣称下载或健康结果提升。
