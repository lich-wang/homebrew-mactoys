cask "mactoys" do
  # 每次 MacToys 版本化发版后：更新 version，并用
  #   shasum -a 256 MacToys-X.Y.Z.dmg
  # 更新 sha256
  version "1.2.0"
  sha256 "REPLACE-WITH-ACTUAL-SHA256"
  url "https://github.com/lich-wang/MacToys/releases/download/v#{version}/MacToys-#{version}.dmg"
  name "MacToys"
  desc "Real-time caption translation, selection translation, and Windows-style key remapping"
  homepage "https://github.com/lich-wang/MacToys/"

  depends_on macos: :sonoma

  app "MacToys.app"

  caveats do
    <<-~EOS
      MacToys is not notarized (no paid Apple Developer account).
      The first launch will be blocked by Gatekeeper. Allow it once:
        System Settings > Privacy & Security > "Open Anyway"
      Later \`brew upgrade\` runs will not be blocked again
      (the package carries a stable self-signed identity).
    EOS
  end
end
