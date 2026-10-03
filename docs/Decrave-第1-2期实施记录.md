# Decrave 第 1、2 期实施记录

日期：2026-10-03，北京时间。目标：提高现有官网访客的下载转化，并改善两篇现有指南的内容质量。

状态：本地页面修改与验收完成，Plausible 配置已保存；用户授权后已提交并发布官网，未修改 App。真实用户理解测试及增长效果观察尚未完成；发布核验见文末。

## 第 1 期：明确入口、费用和数据处理

- 保留 “Still smoking? Start anyway.”；下载按钮旁明确免费 SOS、不需要 Decrave 账号、适用 iPhone / iOS 17+。
- 增加与实际数据流一致的隐私摘要及政策链接：设备及可用时的私有 iCloud，同意后才开启匿名 App 统计。
- 首屏加入免费烟瘾指南入口，保留工作原理入口。无需先填写邮箱。
- 删除未有数据支持的 “Most popular” 与竞品弃用结论，改为说明累计应对次数与连续天数的实际区别。
- Pro 按钮统一为下载后探索 Pro；不再暗示点击网页按钮即可开始试用或购买。保留既有美国区月付、年付、终身价格；提示在 App 查看试用资格、由 Apple 确认条款。
- 定价切换使用可按 Enter / Space 的普通按钮及 `aria-pressed`，价格说明可被辅助技术读到。
- 添加产品设计动机、指南发布责任、资料范围和纠错联系方式。没有虚构创始人经历、专家审阅、用户评价或疗效数据。
- 修正支持页导出路径为 Progress → Settings → Export your data。

涉及：`website/index.html`、`website/styles.css`、`website/support.html`。

## 第 2 期：两篇指南与首屏性能

本批指南：

1. `website/guides/quit-smoking-without-a-quit-date.html`
2. `website/guides/what-to-do-when-cigarette-craving-hits.html`

两篇均补充章节导航、具体可执行示例、相关指南内链、署名责任链接、免费与隐私说明；来源靠近相关表述，正文与 Article / BreadcrumbList、canonical、更新日期保持一致。原发布日期不变，仅更新实际改动的日期及 sitemap 中首页和两篇指南的 lastmod。

无需先设日期的指南明确：可以先准备，目标仍是完全停止吸烟；记录或减少数量不意味着存在安全吸烟量。烟瘾指南先给当下可选的行动，再解释诱因与后续支持，不保证计时结束后烟瘾消失。

2026-10-03 核查的主要资料：

- [Smokefree：建立戒烟计划](https://smokefree.gov/build-your-quit-plan)
- [Smokefree：应对烟瘾](https://smokefree.gov/challenges-when-quitting/cravings-triggers/how-manage-cravings)
- [Smokefree：了解诱因](https://smokefree.gov/challenges-when-quitting/cravings-triggers/know-your-triggers)
- [NCI：尼古丁戒断与诱因](https://www.cancer.gov/about-cancer/causes-prevention/risk/tobacco/withdrawal-fact-sheet)
- [NHS：诱因与烟瘾](https://www.nhs.uk/better-health/quit-smoking/staying-smoke-free/understand-your-smoking-triggers-and-cravings/)
- [Google：面包屑结构化数据](https://developers.google.com/search/docs/appearance/structured-data/breadcrumb)

首页截图优化：

| 图片 | 实际文件大小 | 用途 |
| --- | ---: | --- |
| 原 `screens-v11.png` | 897,000 字节 | 保留为画廊兼容回退 |
| 新 `screens-v11.webp` | 484,496 字节 | 六张截图的无损合集，约减少 46% |
| 新 `screenshot-home-v11.webp` | 108,050 字节 | 独立首页截图，优先加载 |

无损图在黑色与白色背景上的可见像素均与原图一致，首屏图与原合集对应裁剪一致。现代浏览器不再为首屏等待整张六图合集；总截图下载量约减少 34%，首屏可先完成独立图片的加载。

## 数据基线与后台变更

2026-10-03 读取 Plausible 最近 28 天，报告时区 Asia/Shanghai：8 位独立访客、8 次访问、10 次浏览、跳出率 75%、平均访问时长 3 秒。来源 Direct / None 6 位、Product Hunt 2 位。App Store Click 为 2 位独立访客、2 次事件，后台 CR 为 25%。自己的历史访问未排除，样本不足以评判转化变化。

首页 `/` 与 `/index.html` 在报表中分别出现。全站访客以后台去重值为准，不能把各页面独立访客相加作为分母。

已保存的 Plausible 配置：

- 保留原 `App Store Click` 目标和下载按钮位置名称。
- 新增 `Guide Open` 自定义目标；代码在首屏指南链接点击时发送该事件。
- 将既有 `button_location` 登记到 Custom properties，支持按按钮位置查看报表。
- 新入口仅发送按钮位置；本地自动验收拦截外部请求，没有生成线上测试点击。
- 后台显示剩余 24 天试用；未购买方案、未承诺费用。试用结束前需按实际使用决定服务安排。

Search Console 的 3 个月窗口显示：1 次曝光、0 次点击、CTR 0%、平均位置 8；查询词明细无数据。平均位置来自极小样本，不构成关键词排名结论。网页索引报告显示正在处理、提示约一天后查看；没有可据以修复的新错误列表。移动与桌面现场 Core Web Vitals 无数据，没有重复提交索引申请。

Website Campaign 首次下载、商店页面转化及当前订阅试用配置本轮未读取，均不能按零处理。没有真实搜索词样本，本批按用户问题组织内容，不宣称筛出了高流量关键词。

## 已完成验收

- 静态检查全站 13 个 HTML 页面：每页一个 H1、无重复 ID、本地文件与锚点有效、JSON-LD 可解析。
- 首页、两篇指南、支持页在 320 / 390 / 768 / 1440 像素宽度共 16 种布局中没有横向溢出或越界控制项；检查了移动截图。
- 检查 720 CSS 像素的布局重排，作为 1440 屏幕约 200% 缩放的近似；这不等同于所有浏览器文字缩放的完整验收。
- 月付、年付、终身切换及 Enter / Space 操作通过；仅一个按钮处于选中状态，价格、周期正确，下载链接不变。
- 首页五个 App Store 事件位置及 Guide Open / hero 在本地模拟中正确，未发现脚本错误。App Store 链接保留正确应用 ID 和 `pt` / `ct` / `mt` 参数。
- 指南章节链接跳转后标题在固定导航下方，署名、来源与隐私入口可用。
- 新图片可加载，现代 Chrome 选择 WebP，无额外 PNG 下载；检查图片像素一致性和空白字符差异。

一次相同条件的本地性能诊断：Chrome，1440×1000，150ms 延迟、1.6Mbps 下载、CPU 4 倍减速、无缓存、外部统计请求拦截。使用仓库 HEAD 的首页与样式作为修改前版本。修改前 LCP 4.968 秒，修改后 1.068 秒，两次 CLS 均为 0。

该结果用于确认图片加载瓶颈及优化方向，只有各一次实验，不能当作线上第 75 百分位、移动真实用户结果或稳定提升幅度；INP 本轮未测量。上线后需观察真实数据。

## 上线与后续观察

本地预览：`http://127.0.0.1:8765/`（本次预览服务运行期间可用）。线上官网：[decrave.net](https://decrave.net/)。

上线后按以下顺序检查：

1. 确认部署完成，核对首页免费入口、定价和两篇指南；记录实际上线时间与版本。
2. 做少量 App Store / Guide Open 线上事件验收，记录人工验证时间；商店活动参数保持不变。
3. 读取同日期范围的访客与点击访客，分来源、设备查看；ASC 数据缺失时记录 unavailable。
4. 找 5 位目标用户验证“不必先戒烟、哪些功能免费、是否需要注册”的理解；这是方向性可用性验证，尚未完成。
5. 上线约 1–2 周复看下载路径，2–4 周起复看指南曝光与抓取；样本不足就延长观察，不强行判胜。不因无数据反复申请索引。

真实创始人个人故事、商店价格与试用后台确认、可授权评价仍待材料或后台核验；没有通过添加虚构信任信号补足。现阶段不启动无样本 A/B 实验。

工作区原有 `docs/seo-next-phase.md` 修改和两份 outreach 文档已保留，未纳入本批页面修改。

## 发布记录

- 用户明确授权发布后，将本批 11 个文件提交并推送到 main，发布提交 `1f227eff51c6a0f74bea7eee854227e00a775d53`。其余工作区改动未提交。
- GitHub Pages 部署于 2026-10-03 22:04:32（北京时间）完成；[工作流 37128342652](https://github.com/solaceu-legal/decrave-site/actions/runs/37128342652) 全部成功。
- IndexNow 接收 4 个变更页面，HTTP 200；通知接收不等同于已抓取或收录。
- 浏览器看到新版免费、账号及隐私信息；首屏免费指南链接跳转到更新后的烟瘾指南。
- 线上首页、样式、支持页、站点地图、两篇指南与两张 WebP 共 8 个文件均与发布版本逐字节一致。大图首次网络读取超时，延长读取后核对通过。
- 本次人工验收发生在 22:05 起，会计入统计，后续分析需与真实访问区别。
- Plausible 后台本次检查暂未显示新的 Guide Open 事件；线上导航通过，本地事件检查通过，但后台回传仍待确认，不宣称统计端到端验收已完成。
- 回退网站时使用前一版本 `5c78849` 的 website 文件并正常提交、发布；无需重置其他文档或工作区改动。
