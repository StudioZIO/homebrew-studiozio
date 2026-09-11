# Homebrew tap — nasıl yayına alınır

Bu klasördeki dosyalar, `StudioZIO/homebrew-studiozio` adında yeni bir GitHub
deposunun tam içeriği. Depo adı **birebir böyle olmalı** — Homebrew `homebrew-`
önekini kendisi ekliyor, kullanıcı sadece `brew tap StudioZIO/studiozio` yazıyor.

## Adımlar

1. GitHub'da `homebrew-studiozio` adında **public** yeni bir depo aç.
   Açıklama olarak: "Homebrew tap for StudioZIO's free macOS audio plug-ins".
   README/lisans ekleme seçeneklerini işaretleme — dosyalar burada hazır.

2. Terminalde:

```sh
cd ~/StudioZIO-SEO-Work/homebrew-tap
git init
git add .
git commit -m "Homebrew tap: Mastering Suite 2.1.1 and Tempo Delay 4.0.1"
git branch -M main
git remote add origin https://github.com/StudioZIO/homebrew-studiozio.git
git push -u origin main
```

3. Kendi makinende dene:

```sh
brew tap StudioZIO/studiozio
brew trust StudioZIO/studiozio
brew info --cask studiozio-mastering-suite
brew install --cask studiozio-mastering-suite
```

`brew trust` satırı Homebrew'un resmî olmayan tap'ler için koyduğu güvenlik
adımı: onsuz buradaki hiçbir cask çalışmıyor, "Refusing to load cask … from
untrusted tap" hatası veriyor. Bir kerelik ve sadece bu tap için geçerli.
Tap'i kullanacak herkesin bu satırı da çalıştırması gerekiyor, o yüzden
README'de kurulum komutlarının arasında duruyor.

Kurulum şifre soracak — eklentiler `/Library/Audio/Plug-Ins` altına yazdığı için
normal installer da aynısını soruyor.

4. Kaldırmayı da bir kez dene, uninstall satırları doğru mu görürsün:

```sh
brew uninstall --cask studiozio-mastering-suite
```

## Dosyalardaki değerler tahmin değil

Paket kimlikleri (`com.studiozio.masteringsuite.pkg.au` vb.) iki `.pkg`
dosyasının içindeki `PackageInfo` dosyalarından okundu. Checksum'lar da
indirilen gerçek dosyalardan hesaplandı ve release notlarındakiyle birebir
tuttu.

## Bilerek eksik bırakılan tek şey

Mastering Suite cask'ında `zap` bölümü yok. `zap`, eklentinin kendi ayar
dosyalarını da silen bölüm; ama o dosyaların gerçek yollarını bir makinede
doğrulamadım ve yanlış yol yazmak, hiç yazmamaktan kötü. Kurulu makinende

```sh
ls ~/Library/Application\ Support | grep -i studiozio
ls ~/Library/Preferences | grep -i studiozio
```

çıktısını bana verirsen doğru `zap` satırını eklerim.

## Sonraki sürümlerde ne değişecek

Her yeni sürümde cask dosyasında genellikle sadece iki satır: `version` ve
`sha256`. Her iki üründe de sürüm iki parçalı yazılıyor
(`"2.1.1,install-fix-2026.09.11"`, `"4.0.1,aax-2026.09.10"`) çünkü release
etiketi sürümden sonra bir de yapım etiketi taşıyor.

Format seti değişirse iki satır yetmez: `uninstall pkgutil:` listesini paketin
kendi `PackageInfo` kimliklerinden okuyup güncelle. Eksik bir makbuz, o formatı
`brew uninstall` sonrasında diskte bırakır — AAX eklendiğinde her iki cask'te
de tam olarak bu oldu.

## Resmî Homebrew listesine ne zaman?

Şimdi değil. Homebrew'un resmî cask deposu yeni başvurulara otomatik bir
tanınırlık testi uyguluyor: kanonik deponun en az 75 yıldızı ya da 30
fork/watcher'ı olmalı — başvuruyu depo sahibi kendisi açarsa eşik 225 yıldıza
çıkıyor. `StudioZIO-Releases` şu an 0/0/0, yani başvuru bir insan okumadan
CI'da kapanır. Bu tap tam olarak Homebrew'un kendi belgelerinin bu durumda
işaret ettiği yol, ve buradaki dosyalar ileride resmî başvuruda aynen
kullanılabilir. Eşik dolduğunda başvuruyu memnun bir kullanıcının açması
mantıklı — o zaman 225 değil 75 yıldız yetiyor.
