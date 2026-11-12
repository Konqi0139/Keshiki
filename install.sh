#!/bin/bash
# Realizado por: S.Konqi0139
#
# Eres libre de modificarlo a tu gusto, solo te pido
# nombrarme como autor del script

HERE="$(dirname "$(readlink -f "${0}")")"
INSTALL_DIR="/opt/keshiki"
DESKTOP_FILE="/usr/share/applications/keshiki.desktop"
BIN_LINK="/usr/local/bin/keshiki"

CReset='\e[m'
BRed='\e[1;31m' BGreen='\e[1;32m' BYellow='\e[1;33m' BCyan='\e[1;36m'
PRed='\e[5;01m\e[1;31m' PGreen='\e[5;01m\e[1;32m' PYellow='\e[5;01m\e[1;33m'

if [ "$EUID" -ne 0 ]; then
    echo -e "\n${BRed}Error:${CReset} Por favor ejecuta este script como root (usa ${BYellow}sudo ./install.sh${CReset}).\n"
    exit 1
fi

if [[ "$1" == "--remove" ]]; then
    rm -f "$DESKTOP_FILE" "$BIN_LINK"
    rm -rf "$INSTALL_DIR"
    echo -e "\n${PYellow}Keshiki ha sido removido exitosamente.${CReset}\n"
    exit 0
fi

tput civis
trap "tput cnorm" EXIT

clear
echo -e "${BCyan}Revisando dependencias de Keshiki...${CReset}\n"
sleep 0.5

dep=(yad mpv xwinwrap socat xdotool wmctrl ffmpeg convert)
opt_dep=(yt-dlp ffmpegthumbnailer)
missing=0

for prog in "${dep[@]}"; do
    if command -v "$prog" >/dev/null 2>&1; then
        echo -e "${PYellow}[*]${CReset} ${BCyan}${prog}${CReset} ${BGreen}Instalado.${CReset}"
    else
        echo -e "${PYellow}[*]${CReset} ${BCyan}${prog}${CReset} ${BRed}No está instalado (Requerido).${CReset}"
        missing=1
    fi
    sleep 0.2
done

echo ""
for prog in "${opt_dep[@]}"; do
    if command -v "$prog" >/dev/null 2>&1; then
        echo -e "${PYellow}[+]${CReset} ${BCyan}${prog}${CReset} ${BGreen}Instalado (Opcional).${CReset}"
    else
        echo -e "${PYellow}[+]${CReset} ${BCyan}${prog}${CReset} ${BYellow}No instalado (Opcional para YouTube/miniaturas rápidas).${CReset}"
    fi
    sleep 0.2
done

if [ "$missing" -eq 1 ]; then
    echo -e "\n${BRed}Aviso:${CReset} Faltan dependencias requeridas. Keshiki podría no funcionar bien hasta que las instales.\n"
fi

echo -e "\n${BCyan}Continuando con la instalación...${CReset}"

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/bin"

cp -r "${HERE}/"* "$INSTALL_DIR/" 2>/dev/null
rm -f "$INSTALL_DIR/install.sh" "$INSTALL_DIR/README.md" "$INSTALL_DIR/LICENSE"
rm -rf "$INSTALL_DIR/screenshots" "$INSTALL_DIR/.git"

ln -sf "$(command -v yad)" "$INSTALL_DIR/bin/keshiki"
ln -sf "$(command -v yad)" "$INSTALL_DIR/bin/yadsystray"
echo -e '#!/bin/bash\n\nsource ${DIRCONFIG}keshiki.cfg\nmpv "$@"' >"$INSTALL_DIR/bin/mpv.bash"

chmod +x "$INSTALL_DIR/bin/mpv.bash"
chmod +x "$INSTALL_DIR/keshiki.bash" "$INSTALL_DIR/keshiki-"*

ln -sf "$INSTALL_DIR/keshiki.bash" "$BIN_LINK"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.3
Name=Keshiki
Comment=Gestor de Live Wallpapers para compositores basados en X11
Exec=/opt/Keshiki/keshiki.bash
Icon=/opt/Keshiki/keshiki.png
Type=Application
Categories=AudioVideo;Video;GTK;Utility;
Terminal=false
StartupNotify=false
StartupWMClass=Keshiki
Keywords=wallpaper;utility;live;background;
EOF
sleep 1s

sudo update-desktop-database /usr/share/applications/ 2>/dev/null

if [ -d "$INSTALL_DIR" ] && [ -f "$DESKTOP_FILE" ]; then
    echo -e "\n${PGreen}Instalación Completa${CReset}"
    echo -e "Puedes iniciar el programa desde tu menú de aplicaciones o escribiendo ${BCyan}keshiki${CReset} en la terminal.\n"
else
    echo -e "\n${PRed}Instalación Fallida${CReset}\n"
    exit 1
fi
