cask "mactoys" do
  # version / sha256 由 MacToys 仓库的 release 工作流在 tag 发版后自动改掉
  # （bump-cask job，需要 TAP_GITHUB_TOKEN）。手动改的话：
  #   shasum -a 256 MacToys-X.Y.Z.dmg
  version "1.2.0"
  sha256 "REPLACE-WITH-ACTUAL-SHA256"
  url "https://github.com/lich-wang/MacToys/releases/download/v#{version}/MacToys-#{version}.dmg"
  name "MacToys"
  desc "Real-time caption translation, selection translation, and Windows-style key remapping"
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
