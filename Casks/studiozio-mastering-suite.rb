cask "studiozio-mastering-suite" do
  # The release tag carries a signing date after the version, so the version
  # string holds both: version.csv.first is the product version the plug-in
  # reports, version.csv.second is the date in the tag.
  version "2.1.1,2026.09.07"
  sha256 "68e7abb87458bcf8e331f435c7bec7792d33e67fe5c9a5e834195676c11bad7b"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/mastering-suite-v#{version.csv.first}-signed-#{version.csv.second}/StudioZIO-Mastering-Suite-#{version.csv.first}.pkg",
      verified: "github.com/StudioZIO/StudioZIO-Releases/"
  name "StudioZIO Mastering Suite"
  desc "Nine-stage mastering console with always-visible metering"
  homepage "https://studioziomasteringsuite.vercel.app/"

  livecheck do
    url :url
    regex(/^mastering[._-]suite[._-]v?(\d+(?:\.\d+)+)-signed-([\d.]+)$/i)
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
  uninstall pkgutil: [
    "com.studiozio.masteringsuite.pkg.au",
    "com.studiozio.masteringsuite.pkg.standalone",
    "com.studiozio.masteringsuite.pkg.vst3",
  ]

  # No zap stanza: the paths the plug-in uses for its own preferences have not
  # been confirmed on a machine, and a zap that deletes the wrong thing is
  # worse than no zap at all. Add it once those paths are known.
end
