<p align="center"><img src="keshiki.png" width="339"></p>

<p align="center">**un gestor de fondos de pantalla animados liviano para Linux escrito en Bash.** </p>

# Keshiki ー景色ー

Si te gusta mi proyecto, ¡por favor no olvides hacer clic en el botón de estrella! 🌟 ¡Tu apoyo es muy valioso!

[![GitHub estrellas](https://img.shields.io/github/stars/Konqi0139/Keshiki?style=flat-square)](https://github.com/Konqi0139/Keshiki/stargazers)
[![GitHub licencia](https://img.shields.io/github/license/Konqi0139/Keshiki?style=flat-square)](https://github.com/Konqi0139/Keshiki)
[![GitHub último commit](https://img.shields.io/github/last-commit/Konqi0139/Keshiki?style=flat-square)](https://github.com/Konqi0139/Keshiki/commits)



---

## Características 🔥

Existen varias soluciones para lograr tener un video como fondo de pantalla en Linux (como el propio Hidamari o Komorebi). Keshiki ofrece una alternativa ultra-liviana construida sobre scripts nativos, con las siguientes funciones:

- [x] **100% Bash:** Sin pesados entornos de ejecución, inicio instantáneo y mínimo impacto en el sistema.
- [x] **Renderizado nativo:** Utiliza `xwinwrap` para incrustar el contenido directamente detrás de tus ventanas e íconos.
- [x] **Reproducción fluida:** Soporte multiformato delegando la tarea en el potente motor de `mpv`.
- [x] **Interfaz Gráfica nativa (GUI):** Ventanas de diálogo intuitivas creadas gracias a `yad` para gestionar tus fondos.
- [x] **Detección de ventanas maximizadas y pantalla completa!** <sup>1</sup>
- [x] **Control del reproductor en segundo plano:** Comunicación bidireccional mediante sockets IPC. <sup>2</sup>
- [x] **Extracción automática de miniaturas:** Genera vistas previas de tus videos al agregarlos. <sup>3</sup>
- [x] **Bandeja del sistema (Systray):** Control total de pausa, reproducción y apagado con solo dos clics desde tu barra de tareas.

<sup>**1**</sup> Pausa automáticamente la reproducción del video de fondo al detectar ventanas maximizadas (horizontal + vertical) o juegos en pantalla completa para priorizar los recursos de hardware (Actualmente exclusivo de X11).
<sup>**2**</sup> Utiliza `socat` para enviar comandos limpios a `mpv` (como mutear, pausar o cerrar), evitando matar procesos a la fuerza y previniendo conflictos si estás reproduciendo otro video de forma externa.
<sup>**3**</sup> Utiliza `ffmpeg` o `ffmpegthumbnailer` para extraer fotogramas exactos y `imagemagick` para el reescalado óptimo dentro de la interfaz gráfica.

---

## Instalación ⏬

Keshiki incluye un script que verificará automáticamente que tengas todas las dependencias necesarias instaladas en tu distribución y configurará el lanzador global junto al acceso directo en tu menú de aplicaciones:

### Instrucciones de consola

```bash
# 1. Clonar el repositorio
git clone https://github.com
cd Keshiki

# 2. Otorgar permisos y ejecutar el instalador
chmod +x install.sh
./install.sh
```

### Tabla de Dependencias Verificadas

| Herramienta | Función en Keshiki | Estado en el instalador |
| :--- | :--- | :---: |
| `bash` | Intérprete principal del script | Requerido |
| `yad` / `yadsystray` | Ventanas de interfaz y menú en barra de tareas | Requerido |
| `mpv` | Renderizado multimedia fluido | Requerido |
| `xwinwrap` | Dibujado de video en la Root Window (X11) | Requerido |
| `socat` | Sockets de comunicación IPC con mpv | Requerido |
| `xdotool` / `wmctrl` | Monitoreo y detección de estado de ventanas | Requerido |
| `ffmpeg` | Captura de fotogramas para recursos | Requerido |
| `imagemagick` | Tratamiento y redimensión de miniaturas | Requerido |

---

## Screenshots 📸

| Interfaz Principal | Selección de Wallpapers |
| :---: | :---: |
| ![Keshiki GUI](screenshots/main_gui.png) | ![Selector de archivos](screenshots/file_selector.png) |

| Bandeja del Sistema (Systray) | Opciones y Configuración |
| :---: | :---: |
| ![Keshiki Systray](screenshots/systray.png) | ![Configuración de Opacidad](screenshots/options.png) |

---

## ¡Por favor! 🙏

¡La colaboración es más que bienvenida! Hagamos este script cada vez mejor y más optimizado. 

Si encontrás algún error, tenés sugerencias sobre el consumo de recursos o querés proponer una nueva característica, sentite libre de abrir un **Issue** o enviar un **Pull Request** 🤗

## Contribuidores ✨

* **S.Konqi0139** (Creador y desarrollador principal)
* **Monstercat Guy Ü** (Arte de iconos / Recursos gráficos)
