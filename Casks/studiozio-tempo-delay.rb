cask "studiozio-tempo-delay" do
  # The release tag carries a build label after the version, as the Mastering
  # Suite cask's does: version.csv.first is the version the plug-in reports,
  # version.csv.second is whatever the tag puts after it. 4.0.1 first shipped
  # without AAX and was republished as "-aax-2026.09.10" with the format added,
  # which is the build the product site and the release truth manifest point at.
  version "4.0.1,aax-2026.09.10"
  sha256 "4e919c509cca196e178a0a991d24c02eb7e1ba81c5890e0f4fce16aba94ec055"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/tempo-delay-v#{version.csv.first}-#{version.csv.second}/StudioZIOTempoDelay-v#{version.csv.first}-macOS-arm64-AAX.pkg"
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

  pkg "StudioZIOTempoDelay-v#{version.csv.first}-macOS-arm64-AAX.pkg"

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
  # the whole set -- read back from the published 4.0.1 AAX package itself.
  zap trash: "~/Library/Preferences/StudioZIOTempoDelay.settings"
end
