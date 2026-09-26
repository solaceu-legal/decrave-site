# Decrave v1.1

- App 版本：1.1
- 构建号：3（主 App 与 Widget 一致）
- 最低系统版本：iOS 17.0

## 本版本更新

- 合并洞察和个人内容为「进展」，底部保留首页、SOS 和进展三个入口。
- SOS 支持保存常用方案、记录诱因，并根据已有记录提供下一次应对建议。
- 调整呼吸练习、乘风破浪和换个方向的布局及退出流程。
- 两个抽烟记录入口使用一致的保存确认页，保存的数据继续参与统计和分析。
- 增加主屏幕及锁屏 Widget、快捷指令和控制中心 SOS 入口，支持共享状态及跳转。
- 增加每日行动及基于记录的任务状态，并与 Pro 洞察、诱因雷达和提醒衔接。
- 支持英文、简体中文、繁体中文、德语、法语、意大利语、西班牙语、葡萄牙语、日语和韩语；可在设置切换语言。
- 增加每包价格与币种设置，金额按用户填写的每包价格估算，不进行汇率换算。
- 明确每日烟量为控制上限，优化身体恢复卡片、滚动区域和设置入口。

## App Store 更新说明（中文）

这次更新，让想抽的时候更容易找到适合自己的应对方式。

- SOS 入口更醒目，可以保存常用练习，并根据记录获得应对建议。
- 新增桌面、锁屏及控制中心入口，也可通过快捷指令打开 SOS。
- 进展页面整合了趋势、诱因和个人数据。
- 支持更多语言，可在设置中选择。
- 可以设置每包价格和币种，让节省金额的估算更贴近实际。
- 优化练习、记录和设置页面的使用体验。

## App Store 更新说明（英语，美国）

Decrave 1.1 makes support easier to reach when a craving hits.

- Open SOS from the Home Screen, Lock Screen, Control Center, or Shortcuts.
- Save favorite tools and get suggestions based on your own patterns.
- Explore a redesigned Progress tab for trends, triggers, and personal data.
- Set your pack price and currency for more accurate savings.
- Use Decrave in English, Chinese, German, French, Italian, Spanish, Portuguese, Japanese, or Korean.
- Enjoy smoother exercises, logging, and settings.

Your cravings beaten still never reset.

## App Store v1.1 元数据

- 推广文案：`Still smoking? Start anyway. Open SOS in one tap, spot your triggers, and keep progress that never resets—even after a slip.`
- 关键词（100/100 字节）：`nicotine,tobacco,cigarette,cessation,withdrawal,craving,urge,tracker,reduce,stop,breathing,free,help`
- 名称与副标题保持不变：`Decrave: Quit Smoking Support` / `No quit date required`
- 完整描述与审核备注以 `docs/app-store-assets/copy.md` 为准。
- v1.0 截图暂不替换；下一轮复核 v1.1 截图后再上传。

## 验证与提交状态

- 近期已在 iPhone 17 Pro / iOS 26.5 模拟器验证主要流程，用户也已完成多轮真机验收。
- 2026-09-26：真机目标的本地 Release 构建通过（未签名）；已核对产物中主 App 和 Widget 均为 1.1 / Build 3。
- 2026-09-26：正式签名归档通过；首次上传时 Apple 校验发现 Widget 缺少 `CFBundleDisplayName`，已补为 `Decrave`，重新归档并成功上传 1.1 / Build 3；App Store Connect 已处理完成，状态为“准备提交”。
- 提交前仍需复核 App Groups、CloudKit Production schema、Pro 商品、商店本地化资料与新版截图。
- v1.1 审核备注中的付费入口已改为：Progress → 右上角设置 → Free Plan → Try Pro；旧版 “You” 标签路径不能继续使用。
