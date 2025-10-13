pkgdir=/tmp/mnt/disk/pkgs
remote=https://mirrors.tuna.tsinghua.edu.cn/openwrt/releases/23.05.5


[ "$1" = "update" ] && {
  test -d $pkgdir || mkdir $pkgdir
  test -d $pkgdir/cache && rm -rf $pkgdir/cache
  mkdir $pkgdir/cache
  mkdir $pkgdir/cache/temp
}
[ "$1" = "update" ] && {
  echo $remote
  cd $pkgdir/cache
  curl -k $remote/targets/ath79/generic/packages/Packages > core.txt
  grep -e Filename -H core.txt | cut -d: -f1,3
  curl -k $remote/packages/mips_24kc/base/Packages > base.txt
  grep -e Filename -H base.txt | cut -d: -f1,3
  curl -k $remote/packages/mips_24kc/packages/Packages > packages.txt
  grep -e Filename -H packages.txt | cut -d: -f1,3
}

[ "$1" = "search" ] && {
  cd $pkgdir/cache
  grep -e $2 -H core.txt | grep Filename | cut -d: -f1,3
  grep -e $2 -H base.txt | grep Filename | cut -d: -f1,3
  grep -e $2 -H packages.txt | grep Filename | cut -d: -f1,3
}

[ "$1" = "core" ] && {
  cd $pkgdir/cache
  txt=core.txt
  url=$remote/targets/ath79/generic/packages/$2
}
[ "$1" = "base" ] && {
  cd $pkgdir/cache
  txt=base.txt
  url=$remote/packages/mips_24kc/base/$2
}
[ "$1" = "packages" ] && {
  cd $pkgdir/cache
  txt=packages.txt
  url=$remote/packages/mips_24kc/packages/$2
}

[ "$url" != "" ] && {
  echo $txt:$2
  echo $url
}
[ "$url" != "" ] && {
  cd $pkgdir/cache/temp
  curl -k $url -o $2
  tar -xzf $2
  tar -xzvf data.tar.gz
  test -d usr && cp -rf usr $pkgdir
  test -d lib && cp -rf lib $pkgdir
  test -d etc && cp -rf etc $pkgdir
  rm -r *
}
