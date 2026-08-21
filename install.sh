#!/bin/zsh
# gideon — Homebrew PATH kurulumu
emulate zsh
set -e

here=${0:A:h}
gideon=$here/gideon

if [[ ! -f "$gideon" ]]; then
  print -u2 "gideon bulunamadı: $gideon"
  exit 1
fi

chmod +x "$gideon"

prefix=""
if (( $+commands[brew] )); then
  prefix=$(brew --prefix 2>/dev/null) || prefix=""
fi

if [[ -z $prefix ]]; then
  print -u2 "Homebrew prefix bulunamadı; symlink atlanıyor."
  print "gideon çalıştırılabilir: $gideon"
  print "PATH için: ln -sf \"$gideon\" /usr/local/bin/gideon"
  exit 0
fi

bindir=$prefix/bin
if [[ ! -d "$bindir" ]]; then
  if ! mkdir -p "$bindir" 2>/dev/null; then
    print -u2 "brew bin dizini yok ve oluşturulamadı: $bindir"
    print "gideon çalıştırılabilir: $gideon"
    exit 1
  fi
fi

ln -sf "$gideon" "$bindir/gideon"
hash -r 2>/dev/null || true
print "gideon hazır → $bindir/gideon"
print "Çalıştırmak için: gideon"
