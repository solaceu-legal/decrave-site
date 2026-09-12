# Decrave Build 2 重新提审检查清单

## 1. 上传前

- 在 Xcode 中选择真机或 `Any iOS Device`，执行 Archive。
- 确认版本号仍为 App Store Connect 中的当前版本，构建号为 `2`。
- 确认最低系统版本为 iOS 17.0。
- 将更新后的 `docs/legal/privacy-policy.html` 部署到 `https://decrave.net/privacy-policy.html`，并在无登录状态下打开确认内容已更新。
- 在 CloudKit Dashboard 将本版本使用的 schema 部署到 Production。

## 2. App Store Connect 商品

- 月订阅：`com.slipeasy.pro.monthly`。
- 年订阅：`com.slipeasy.pro.yearly`，7 天免费试用。
- 终身版：`com.slipeasy.pro.lifetime`，类型为非消耗型内购。
- 月订阅和年订阅位于同一个订阅组。
- 商品显示名称、描述和审核截图统一使用品牌名 Decrave。
- 所有商品状态可随 Build 2 一起提交审核，没有缺失的本地化、价格或审核信息。

## 3. App 隐私

在 App Store Connect 的 App Privacy 中如实申报：

- Product Interaction：用途为 Analytics，不与用户身份关联，不用于追踪。
- Device ID：用途为 Analytics，不与用户身份关联，不用于追踪。
- App 内分析默认关闭；用户在首次引导中主动同意后才开启，并可在 Settings → Analytics 随时关闭。

不要申报姓名、邮箱、广告标识符、精确位置或健康数据，除非发布版本后来确实新增了这些采集。

## 4. 沙盒账号人工验收

建议在一台未安装旧版本的真机上，用 Sandbox Apple Account 逐项验证：

- 未购买时，Pro 功能保持锁定，免费功能与页面描述一致。
- 月订阅购买成功后立即解锁 Pro，杀掉 App 再打开仍保持解锁。
- 年订阅页面明确展示 7 天试用、试用后价格、周期和自动续订说明。
- 终身版购买成功后立即解锁 Pro。
- 删除并重装 App 后，“Restore Purchases”可以恢复已有权益。
- 在 StoreKit Transaction Manager 或沙盒中让订阅过期/撤销后，再次进入 App 会自动取消 Pro 权益。
- 购买取消、购买待处理、网络失败时不会误解锁，也不会卡死在加载状态。

## 5. 审核备注

- 写明 Pro 入口和恢复购买入口的具体路径。
- 若审核员需要沙盒操作说明，注明月订阅、年订阅和终身版均可从 Paywall 选择。
- 说明分析功能为可选项、默认关闭，并可在 Settings → Analytics 撤回同意。
- 确认隐私政策、服务条款和支持网址均可公开访问。

## 6. 上传后再检查

- 在 TestFlight 安装刚上传的 Build 2，而不是本地调试版本。
- 再完成一次购买、恢复购买、冷启动权益恢复和分析开关检查。
- 将 Build 2 选入版本，连同三个内购商品一起送审。
