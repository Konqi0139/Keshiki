#!/bin/bash
# Realizado por: S.Konqi0139
#
# Eres libre de modificarlo a tu gusto, solo te pido
# nombrarme como autor del script

export HERE="$(dirname "$(readlink -f "${0}")")" DIRCONFIG="$HOME/.config/keshiki/" Color="color='#31E6F0'"
export CONFIG="${DIRCONFIG}keshiki.cfg" PATH="${HERE}/bin:${PATH}" ICON="${HERE}/keshiki.png" sc=${0##*/}

export script=${sc%.bash}

if [ -f "${CONFIG}" ]; then
    source "${CONFIG}"
else
    mkdir -p ${DIRCONFIG}desktops
    echo -e "# configuration of keshiki\n\nview=(TRUE )\naudio=(TRUE --no-audio 100)\nsystemtray=TRUE\nbelow_desk=FALSE\nopacity=1" > "${CONFIG}"
    source "${CONFIG}"
fi

restart(){ 
    kill -USR1 "$YAD_PID"
    "${HERE}/${sc}"
}
export -f restart

if [[ $LANG == es* ]]; then 
    Lan=("Añadir" "Quitar" "Detener" "Opacidad" "Opciones" "Gestor de Live Wallpapers")
else 
    Lan=("Add" "Remove" "Stop" "Opacity" "Options" "Live Wallpaper Manager")
fi

keshiki --no-escape "${view[1]}" --center --always-print-result \
--title="Keshiki" --width=970 --height=531 --text-align=center --dialog-sep \
--window-icon="$ICON" --buttons-layout=center --icons --monitor \
--single-click --item-width=39 --read-dir="${DIRCONFIG}desktops" --borders=10 \
--text="<span font='11' $Color><b><big>${Lan[5]}</big></b></span>" \
--button="<span $Color>${Lan[0]}</span>!gtk-add: ${HERE}/keshiki-adding" \
--button="<span $Color>${Lan[1]}</span>!gtk-remove: ${HERE}/keshiki-remove" \
--button="<span $Color>${Lan[2]}</span>!gtk-media-stop:${HERE}/keshiki-cli -f" \
--button="<span $Color>${Lan[3]}</span>!edit-opacity:${HERE}/keshiki-options -o" \
--button="<span $Color>${Lan[4]}</span>!cm_options: ${HERE}/keshiki-options" &
YAD_MAIN_PID=$!

if [ "$systemtray" = "TRUE" ]; then 
    pidof yadsystray >/dev/null || "${HERE}/keshiki-systray" &
else 
    killall -q yadsystray
fi

wait "$YAD_MAIN_PID" 2>/dev/null
