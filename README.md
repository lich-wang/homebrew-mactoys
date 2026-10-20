# homebrew-mactoys

[MacToys](https://github.com/lich-wang/MacToys)（macOS 小工具合集：实时字幕翻译 / 划词翻译 / 键位适配 / 动作快捷键 / 菜单栏黑色外观）的 Homebrew tap。

应用**未经 Apple 公证**（无付费开发者账号），但用稳定自签名身份签名：

- 首次启动会被 Gatekeeper 拦一次 → 系统设置 › 隐私与安全性 ›「仍要打开」
- 之后 `brew upgrade` 不再被拦（Homebrew 比对 designated requirement，
  一致则继承用户的放行标记），辅助功能授权也跨更新保留

## 安装

```bash
brew tap lich-wang/mactoys && brew trust lich-wang/mactoys && brew install --cask mactoys
```

三条都省不掉（Homebrew 7.0.10 实测）：全名直装会被拒（`If you trust this tap,
tap it explicitly`），只 tap 不 trust 则在加载 cask 时报
`Refusing to load cask ... from untrusted tap`。`brew trust` 就是 Homebrew 要你
对第三方 tap 给出的显式背书，所以**动手前先看一眼要信任的东西**：
[Casks/mactoys.rb](Casks/mactoys.rb) 一屏就看完。
只想信任这一个 cask 而不是整个 tap，就把中间那条换成
`brew trust --cask lich-wang/mactoys/mactoys`。

装好之后更新就只要 `brew upgrade --cask mactoys` 了。

安装包（`.dmg` / `.pkg`，arm64 + x86_64 通用架构）发布在
[本仓库的 Releases](https://github.com/lich-wang/homebrew-mactoys/releases) 里 ——
MacToys 的源码仓库是私有的，私有仓库的 Release 资产对外下不到，所以包放在这边。

## 更新 / 卸载

```bash
brew upgrade --cask mactoys
brew uninstall --cask mactoys
```

## 维护说明

MacToys 仓库推 `v*` tag 后，它的 release 工作流会构建、发版，并自动把这里的
`version` / `sha256` 改掉再提交（`bump-cask` job，校验和取自 Release 里的
`SHA256SUMS.txt`）。前提是 MacToys 仓库配了 `TAP_GITHUB_TOKEN`
（对本仓库有 contents: write 的 fine-grained PAT）；没配就只打印一条提示，
需要手动改：

1. 更新 `Casks/mactoys.rb` 里的 `version` 和 `sha256`（`shasum -a 256` 取校验和）
2. `git commit && git push`

> 注意：现存的 `v1.1.0` Release 产物名是 `MacToys-1.0.12.dmg`（历史命名不一致，
> cask 的 `MacToys-#{version}.dmg` 约定对不上）。建议等下一个 tag 发版（CI 产物名
> 与版本一致）后再启用 cask。
