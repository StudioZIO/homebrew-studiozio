cask "studiozio-tempo-delay" do
  # The release tag carries a build label after the version: version.csv.first is
  # the number in the tag and installer file name, version.csv.second is the build
  # label. For this release the installer is numbered 4.1.0 while the plug-in
  # itself reports 4.0.1 -- a deliberate split recorded in the release notes.
  # 16 September's clean-packaging release supersedes "-aax-2026.09.10"; it is the
  # build the product site, KVR and the release truth manifest point at.
  version "4.1.0,clean-packaging-2026.09.16"
  sha256 "fa16f0c9f04f5f56e446ae06074a0f3b0a8e193fa21089e0bf92c486d197910d"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/tempo-delay-v#{version.csv.first}-#{version.csv.second}/StudioZIOTempoDelay-v#{version.csv.first}-macOS-arm64.pkg"
  name "StudioZIO Tempo Delay"
  desc "Tempo-synced stereo delay with independent left and right timing"
  homepage "https://www.tempodelay.tech/"

  livecheck do
    url :url
    regex(/^tempo[._-]delay[._-]v?(\d+(?:\.\d+)+)-(.+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on arch: :arm64
  # The installer declares arm64 only and a 12.0 minimum, so the cask does too;
  # without the arch line Homebrew would offer it to Intel Macs it cannot run on.
  depends_on macos: :monterey

  pkg "StudioZIOTempoDelay-v#{version.csv.first}-macOS-arm64.pkg"

  # Identifiers read from the installer's own PackageInfo files. The mixed case
  # is deliberate -- pkgutil matches these exactly. The AAX receipt belongs
  # here for the same reason it does in the Mastering Suite cask: without it
  # `brew uninstall` leaves the .aaxplugin in place and still loading in
  # Pro Tools.
  uninstall pkgutil: [
    "com.StudioZIO.StudioZIOTempoDelay.aax.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.app.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.component.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.vst3.pkg",
  ]

  # This installer registers no outer product receipt, so the four above are
  # the whole set -- read back from the published 4.1.0 clean-packaging package
  # itself (same four identifiers as the superseded AAX build).
  zap trash: "~/Library/Preferences/StudioZIOTempoDelay.settings"
end
