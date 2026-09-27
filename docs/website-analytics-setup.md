# Decrave 官网统计接入

更新时间：2026-09-27

## 目标

建立两层统计：

1. Plausible：官网访问、来源、设备、国家，以及 App Store 按钮点击。
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
- 自定义事件：`App Store Click`。
- 自定义属性：`button_location`，值为表格中的五个位置之一。
- Apple Campaign：`Website`。
- Apple Campaign Link：

```text
https://apps.apple.com/app/apple-store/id6801961627?pt=129291985&ct=Website&mt=8
```

官网五个按钮共用一个 Apple `Website` 活动链接，按钮位置差异由 Plausible 记录，避免早期下载量被拆散后达不到 Apple 的隐私显示门槛。

## 发布后验证

1. 打开 Plausible 实时视图，再访问一次 `https://decrave.net/`，确认出现页面访问。
2. 分别点击五个 App Store 按钮，确认出现 `App Store Click`，并可按 `button_location` 查看位置。
3. 在 Plausible Settings → Goals 中添加名称完全一致的 `App Store Click` Custom event goal；未创建目标时事件虽会发送，但不会显示在 Dashboard。
4. 检查跳转后的 App Store URL 仍包含 `pt=129291985`、`ct=Website` 和 `mt=8`。
5. Apple Campaign 数据通常不会实时出现，应在 App Store Connect 中稍后复查，并注意低于隐私门槛的指标可能不显示。

## 建议关注的指标

- App Store 点击率 = App Store 点击访客数 ÷ 官网独立访客数
- 商店下载转化率 = Website Campaign 首次下载 ÷ 商店产品页访问
- 官网最终转化率 = Website Campaign 首次下载 ÷ 官网独立访客数
- 各按钮贡献 = 各 `location` 的点击数与点击率
