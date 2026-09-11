cask "studiozio-mastering-suite" do
  # The release tag carries a build label after the version, and that label is
  # not fixed -- 2.1.1 has shipped as both "-signed-2026.09.07" and
  # "-flicker-hold-2026.09.08". So the version string holds both parts:
  # version.csv.first is the version the plug-in reports, version.csv.second is
  # whatever the tag puts after it.
  version "2.1.1,install-fix-2026.09.11"
  sha256 "b054098c4f6565e5e469efd41554425d468830a001c9d4c531e72ab8c50f4cf1"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/mastering-suite-v#{version.csv.first}-#{version.csv.second}/StudioZIO-Mastering-Suite-#{version.csv.first}.pkg"
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

  # Read from the installer itself, not guessed: the four component packages
  # install to /Applications, /Library/Audio/Plug-Ins/Components,
  # /Library/Audio/Plug-Ins/VST3 and
  # /Library/Application Support/Avid/Audio/Plug-Ins respectively.
  # The four component receipts, plus the outer product receipt the installer
  # registers alongside them -- without that last one an uninstall leaves
  # com.studiozio.masteringsuite.pkg behind in `pkgutil --pkgs`.
  # AAX joined the package in the 2026.09.10 release; omitting its receipt here
  # would leave the .aaxplugin installed and still loading in Pro Tools after
  # `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.masteringsuite.pkg",
    "com.studiozio.masteringsuite.pkg.aax",
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
