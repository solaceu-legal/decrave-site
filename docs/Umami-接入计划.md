# Decrave 官网切换到 Umami

核查日期：2026-10-04（Asia/Shanghai）。用户已选择切换到 Umami，停止官网 Plausible 的新数据发送；保留 Plausible 历史数据及现有 App Store Website 活动链接。

## 账号与站点创建记录

Umami Cloud 的 US 网站列表仅有 Lightvessel。尝试新增 Decrave / decrave.net 时，后台返回 `Website limit reached`，未创建成功。

当前账号为 Hobby：$0/月、1 个网站、每月 100K 事件、6 个月数据保留。后台显示 Pro 为 $20/月、最多 20 个网站、每月包含 1M 事件，超额事件另收费，有 14 天免费试用。本轮没有升级、开启付费试用或修改 Lightvessel。

用户随后使用新账号自行注册登录，并授权继续。2026-10-04 在用户当前 Chrome 中确认新账号与空网站列表，成功创建 Decrave / decrave.net，后台显示 Saved，并提供正式 Website ID `f8cd9c76-858b-4053-8be4-e98849ac16b0` 和脚本 `https://cloud.umami.is/script.js`。站点位于 US 区域。未升级、开启付费试用或修改旧账号站点。

11 页替换、隐私政策更新和隔离验收已完成；当前代码发布批次为 `1f74823`。正式发布和线上 14 个修改文件核对已通过，Umami 实际报表出现全部六类事件。详细验收与商店区域跳转限制见 [官网统计接入记录](website-analytics-setup.md)。

## 接入范围

1. 在选定账号中新增 Decrave，域名 decrave.net，从后台复制正式 Tracking code。
2. 替换已有统计的 11 个 HTML 页面：首页、指南中心、8 篇指南、SOS 页。保持目前未统计的隐私、条款和支持页范围不变。
3. 保留六个事件名称，并使用 Umami 的事件数据承载按钮位置：

| 事件 | 触发 | 事件数据 |
| --- | --- | --- |
| App Store Click | 官网或指南、SOS 结束页点击商店入口 | button_location，保留现有位置值 |
| Guide Open | 首页点击免费烟瘾指南 | button_location=hero |
| SOS Open | 首页点击一分钟 SOS 入口 | button_location=hero |
| SOS Started | 开始或重新开始练习 | 无 |
| SOS Timer Completed | 当前练习计时结束，仅一次 | 无 |
| SOS Ended Early | 主动提前结束，仅一次 | 无 |

4. 外部统计加载失败、被用户拦截时，导航和 SOS 功能仍应正常；计时与统计分开，避免重复发送完成事件。
5. 将脚本限制为正式域名，隔离本地测试流量。仅统计访问、来源、设备和上述事件，不传烟瘾、诱因、吸烟结果、邮箱或个人 ID，不启用会话录制及热图。
6. 隐私政策如实更新服务商与统计行为；官网统计文档标明切换时间。不同服务商的访客口径可能不同，不把切换前后数据直接当作转化改善。

## 验证与发布

- 静态检查：11 个页面各有且仅有一套正式 Umami 接入，清除 Plausible 加载及调用；下载活动参数保持一致。
- 隔离检查：各按钮事件名称和位置正确、没有重复事件、SOS 暂停/继续/结束/重开正常；外部网络请求拦截，不制造真实增长数据。
- 发布后核对线上文件，执行少量真实浏览器访问与按钮验收，检查 Umami 中的访问和事件；验证点击不是正式获客。
- 尚未出现的事件记为待确认，不将脚本已发布等同于所有事件已回传。App Store 下载归因继续由 App Store Connect 提供。

## 官方参考

- [安装追踪代码](https://docs.umami.is/docs/collect-data)
- [追踪自定义事件](https://docs.umami.is/docs/track-events)
- [Tracker functions](https://docs.umami.is/docs/tracker-functions)
- [限制正式域名与其他配置](https://docs.umami.is/docs/tracker-configuration)
