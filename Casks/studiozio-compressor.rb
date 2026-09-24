cask "studiozio-compressor" do
  # The current release tag carries a build label after the version: the
  # 16 September clean-packaging release supersedes the plain "compressor-v1.0.0"
  # package. version.csv.first is the version the plug-in reports,
  # version.csv.second is whatever the tag puts after it.
  version "1.0.0,clean-packaging-2026.09.16"
  sha256 "96c9d4cccefc918ffef47b094464da901be742778b4fc6e97145ddcfa11d37bc"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/compressor-v#{version.csv.first}-#{version.csv.second}/StudioZIO-Compressor-#{version.csv.first}.pkg"
  name "StudioZIO Compressor"
  desc "Two-mode compressor with its own gain-reduction meter"
  homepage "https://www.studiozio.tech/products/compressor/"

  livecheck do
    url :url
    regex(/^compressor[._-]v?(\d+(?:\.\d+)+)-(.+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  # The installer declares a macOS 11.0 minimum and hostArchitectures
  # x86_64,arm64: every format is Universal.
  depends_on macos: :big_sur

  pkg "StudioZIO-Compressor-#{version.csv.first}.pkg"

  # Read from the published installer's own Distribution and PackageInfo
  # files, not guessed: the outer product receipt plus one component package
  # per format. Leaving the AAX receipt out would keep the .aaxplugin loading
  # in Pro Tools after `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.compressor.pkg",
    "com.studiozio.compressor.pkg.aax",
    "com.studiozio.compressor.pkg.au",
    "com.studiozio.compressor.pkg.standalone",
    "com.studiozio.compressor.pkg.vst3",
  ]

  # No zap stanza yet: the settings paths have not been confirmed on a machine
  # with the plug-in installed, and a wrong path is worse than none.
end
