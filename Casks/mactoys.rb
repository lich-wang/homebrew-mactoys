cask "mactoys" do
  # version / sha256 由 MacToys 仓库的 release 工作流在 tag 发版后自动改掉
  # （bump-cask job，需要 TAP_GITHUB_TOKEN）。手动改的话：
  #   shasum -a 256 MacToys-X.Y.Z.dmg
  version "1.1.1"
  sha256 "609373f7c5f47d4baea5bfc1b8b49a391817106f8a17dc2204156f9fc9d48d88"

  # 包发在本仓库的 Release 里：源码仓库是私有的，它的 Release 资产对外 404
  url "https://github.com/lich-wang/homebrew-mactoys/releases/download/v#{version}/MacToys-#{version}.dmg"
  name "MacToys"
  desc "Caption translation, selection translation and Windows-style key remapping"
  homepage "https://github.com/lich-wang/MacToys/"

  depends_on macos: :sonoma

  app "MacToys.app"

  uninstall quit: "tech.lich.mactoys"

  zap trash: [
    "~/Library/Application Support/MacToys",
    "~/Library/Logs/MacToys.log",
    "~/Library/Preferences/tech.lich.mactoys.plist",
  ]

  caveats do
    <<~EOS
      MacToys is not notarized (no paid Apple Developer account).
      The first launch will be blocked by Gatekeeper. Allow it once:
        System Settings > Privacy & Security > "Open Anyway"
      Later `brew upgrade` runs will not be blocked again
      (the package carries a stable self-signed identity).
    EOS
  end
end
