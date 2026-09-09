cask "studiozio-mastering-suite" do
  # The release tag carries a build label after the version, and that label is
  # not fixed -- 2.1.1 has shipped as both "-signed-2026.09.07" and
  # "-flicker-hold-2026.09.08". So the version string holds both parts:
  # version.csv.first is the version the plug-in reports, version.csv.second is
  # whatever the tag puts after it.
  version "2.1.1,flicker-hold-2026.09.08"
  sha256 "2345deeb3d9cf97e80ca12109de120af9b2896f14799f4e67825e148a1feb7b1"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/mastering-suite-v#{version.csv.first}-#{version.csv.second}/StudioZIO-Mastering-Suite-#{version.csv.first}.pkg",
      verified: "github.com/StudioZIO/StudioZIO-Releases/"
  name "StudioZIO Mastering Suite"
  desc "Nine-stage mastering console with always-visible metering"
  homepage "https://studioziomasteringsuite.vercel.app/"

  livecheck do
    url :url
    regex(/^mastering[._-]suite[._-]v?(\d+(?:\.\d+)+)-(.+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: :big_sur

  pkg "StudioZIO-Mastering-Suite-#{version.csv.first}.pkg"

  # Read from the installer itself, not guessed: the three component packages
  # install to /Applications, /Library/Audio/Plug-Ins/Components and
  # /Library/Audio/Plug-Ins/VST3 respectively.
  # The three component receipts, plus the outer product receipt the installer
  # registers alongside them -- without that last one an uninstall leaves
  # com.studiozio.masteringsuite.pkg behind in `pkgutil --pkgs`.
  uninstall pkgutil: [
    "com.studiozio.masteringsuite.pkg",
    "com.studiozio.masteringsuite.pkg.au",
    "com.studiozio.masteringsuite.pkg.standalone",
    "com.studiozio.masteringsuite.pkg.vst3",
  ]

  # Confirmed on a machine with the plug-in installed, not guessed. The shared
  # ~/Library/Application Support/StudioZIO folder is deliberately not listed:
  # both products write there, so removing it with either cask would take the
  # other one's data with it.
  zap trash: "~/Library/Preferences/StudioZIO Mastering Suite.settings"
end
