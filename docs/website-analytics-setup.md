# Decrave 官网统计接入

更新时间：2026-10-04（Asia/Shanghai）。

## 当前统计：Umami Cloud

官网已将 11 个有统计的页面切换至 Umami：首页、指南中心、8 篇指南及 SOS。隐私、条款和支持页保持原来的未统计范围。Plausible 历史报表保留，但官网不再加载其脚本或发送新事件；旧账号、试用与账单未修改。

- [Decrave 数据面板](https://cloud.umami.is/analytics/us/websites/f8cd9c76-858b-4053-8be4-e98849ac16b0)，US 区域。
- Website ID：`f8cd9c76-858b-4053-8be4-e98849ac16b0`（公开追踪标识，不是 API 密钥）。
- 官方脚本：`https://cloud.umami.is/script.js`，异步加载。`data-domains` 限制为 `decrave.net,www.decrave.net`，排除本地预览；`data-exclude-hash` 避免页面锚点产生额外浏览量，保留搜索参数以支持来源与 UTM 分析。
- `website/analytics.js` 统一处理按钮和 SOS 事件。只接受六个固定事件与 `button_location`，不传个人用户 ID、邮箱或练习详情。脚本延迟时在内存中暂存至多 20 个事件；页面离开前仍未加载的事件可能无法回传。统计失败不延迟导航或练习。
- 不调用 `umami.identify`，不启用热图、会话录制或额外性能统计。iOS 的 TelemetryDeck 及同意设置不变。
- 隐私政策已更新提供方和日期。不同提供方的访客、访问与会话口径可能不同，切换前后数据不可直接归为转化提升。

| 事件 | 触发 | 事件数据 |
| --- | --- | --- |
| App Store Click | 首页 5 个入口、指南入口、SOS 结束页 | button_location：保留各入口位置，SOS 为 sos_summary |
| Guide Open | 首页免费烟瘾指南 | button_location=hero |
| SOS Open | 首页一分钟 SOS 入口 | button_location=hero |
| SOS Started | 开始或重开练习 | 无 |
| SOS Timer Completed | 当前练习计时完成，仅一次 | 无 |
| SOS Ended Early | 当前练习主动结束，仅一次 | 无 |

Events 可查看事件次数与名称，事件数据中查看按钮位置。Overview 查看访问、页面和来源，UTM 查看活动参数。练习计时完成不代表烟瘾消失或戒烟成功；重复开始会增加事件次数。

App Store 链接仍使用同一 Website 活动：

```text
https://apps.apple.com/app/apple-store/id6801961627?pt=129291985&ct=Website&mt=8
```

Umami 只能验证官网访问与商店点击；首次下载与商店产品页转化继续查看 App Store Connect。建议按同一日期窗口查看官网点击访客、Website 活动产品页访问和首次下载，不把总点击次数与独立访客混用，也不把汇总指标当作逐人完整漏斗。

## 2026-10-04 验收

静态检查：11 个页面各一套正式接入、无 Plausible 加载或调用；14 个 HTML 页的结构化数据和所有商店活动链接保持一致。

隔离浏览器检查：11 页 25 个已标记入口各发一次正确事件和位置；模拟正式域名，所有网页由本地文件提供，外部请求被拦截。另验证原始代码在 localhost 不发送事件、延迟加载后按顺序回传且不重复、加载阻断/抛错/异步失败均不阻碍导航和练习。SOS 的 12 种状态/宽度组合、暂停/继续/完成去重/提前结束/重开、模拟后台暂停、减少动态效果、无 JS 指南后备均通过。无页面错误或个人练习存储。

线上发布已完成：代码批次 `1f74823bae6b00dab60a6b383b074eb554a1bc38`；[部署记录](https://github.com/solaceu-legal/decrave-site/actions/runs/37137826310) 的 build、deploy、IndexNow 均成功。部署完成时间为 2026-10-04 00:42:38（Asia/Shanghai）。线上 14 个修改文件已逐个核对，与本地通过验收的源码一致。

2026-10-04 00:44–00:50 在用户 Chrome 做少量正常访问和点击验收：Overview 的 Last 24 hours 显示 1 位访客、1 次访问、4 次页面浏览，首页、指南及 SOS 均出现。Events 显示 8 次事件、6 类事件：App Store Click 2，Guide Open 1，SOS Open 1，SOS Started 2，SOS Timer Completed 1，SOS Ended Early 1。与一次指南下载点击、一次提前结束、重开后完整一分钟、一次 SOS 结束页下载点击吻合。Properties 进一步确认 App Store Click 的两条记录分别为 `/sos/` / `button_location=sos_summary` 与烟瘾指南 / `button_location=craving_guide_header`，位置属性也已实际回传。这些全部是人工验收，不作为真实获客、转化增长或健康效果证据。

商店路径限制：此 Chrome 中两次原有活动链接点击最终被 Apple 跳转到 `https://apps.apple.com/cn/iphone/today`，没有看到 Decrave 产品页。已确认官网链接参数未变，Umami 下载点击回传成功；本轮不能据此确认目标市场的产品页或首次下载归因，也不能推断所有市场都受影响。此次接入保持既有活动链接，另行核查 Apple 的区域跳转。

## 2026-10-03 Plausible 接入记录（历史）

以下为切换前的配置、验收及小样本基线，仅保留历史；其中 Plausible 操作步骤不再作为现行统计设置。

更新时间：2026-10-03

### 目标

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

### 当前接入状态

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

### 发布后验证

1. 打开 Plausible 实时视图，再访问一次 `https://decrave.net/`，确认出现页面访问。
2. 分别点击五个 App Store 按钮，确认出现 `App Store Click`，并可按 `button_location` 查看位置。
3. 点击首屏的 “Read a free craving guide”，确认导航到烟瘾指南，并出现 `Guide Open` / `button_location=hero`。两个目标和属性登记已完成，22:05 起人工验收的指南跳转正常；本次后台检查暂未显示新事件，回传仍待确认，不能认为已经验收通过。
4. 检查跳转后的 App Store URL 仍包含 `pt=129291985`、`ct=Website` 和 `mt=8`。
5. Apple Campaign 数据通常不会实时出现，应在 App Store Connect 中稍后复查，并注意低于隐私门槛的指标可能不显示。
6. 记录每次人工验证的时间和入口；只做少量必要点击，避免把自己的验证当作真实增长。本轮本地自动检查阻断外部统计请求，没有生成线上测试点击。

2026-10-03 第 3 期补充核查：Plausible 官方安装检查显示 “Tracking is active on your site / Visitors are being counted correctly”。访问统计接入确认通过；Guide Open 尚未在报表出现，仍需正常用户浏览器单独验证。脚本会排除常见自动化环境，因此不能凭自动化点击未出现就判定安装失败。见 [第 3 期验证记录](Decrave-第3期体验验证记录.md)。

### 2026-10-03 基线快照

- Plausible 的 Last 28 days：8 位独立访客、8 次访问、10 次页面浏览；`App Store Click` 为 2 位独立访客、2 次事件，后台 CR 为 25%。
- 来源显示 Direct / None 6 位、Product Hunt 2 位。自己的历史验证访问是否包含在内尚未排除。
- 这是全站窗口口径，样本很小；不能把 25% 当作稳定转化率，也不能据此前后波动判断文案效果。
- Search Console 的 3 个月窗口：1 次曝光、0 次点击；查询词明细无数据。网页索引报告正在处理，现场 Core Web Vitals 无数据，均不能记为不合格。
- Website Campaign 首次下载与商店转化率本轮未读取，记为 unavailable，不能推断为零。
- 详细修改和验收见 [第 1、2 期实施记录](Decrave-第1-2期实施记录.md)。

### 建议关注的指标

- App Store 点击率 = App Store 点击访客数 ÷ 官网独立访客数
- 商店下载转化率 = Website Campaign 首次下载 ÷ 商店产品页访问
- 官网最终转化率 = Website Campaign 首次下载 ÷ 官网独立访客数
- 各按钮贡献 = 各 `location` 的点击数与点击率
- 指南入口点击访客数：用于观察下载前内容需求；没有对应区块曝光统计时，不声称是“看过入口的人”的点击率。

### 第 3 期 Web SOS 发布批次

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
