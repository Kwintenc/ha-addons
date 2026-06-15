# Bambu Studio – Home Assistant Add-on

Runs [Bambu Studio](https://bambulab.com/en/download/studio) — the official slicer for Bambu Lab printers — in your browser, served directly from Home Assistant via the sidebar.

The container is the [linuxserver.io `bambustudio`](https://docs.linuxserver.io/images/docker-bambustudio/) image wrapped as a native HA add-on with ingress support.

---

## ⚠️ Architecture

**x86-64 (amd64) only.** The upstream linuxserver.io image does not provide an arm64 build. This add-on will not install on Raspberry Pi or other ARM-based HA systems.

---

## Configuration options

| Option      | Default | Description |
|-------------|---------|-------------|
| `dark_mode` | `true`  | Enable dark mode inside Bambu Studio |
| `password`  | *(empty)* | Set a password to enable HTTP Basic Auth (`admin` / `<password>`). Leave empty for no auth. |

---

## Accessing Bambu Studio

After starting the add-on:

- **Sidebar**: click **Bambu Studio** in the left nav (after enabling "Show in sidebar" in the add-on info page).
- **Direct URL**: `https://<your-ha-ip>:8123/api/hassio_ingress/<ingress_token>/`

The ingress uses HTTPS (port 3001) inside the container. HTTPS is required for Bambu Studio's WebCodecs features (video, audio).

---

## File sharing

| Path inside container | Mapped to |
|-----------------------|-----------|
| `/share`              | HA `/share` folder (read/write) |
| `/config`             | HA `/config` folder (read/write) |

To exchange `.3mf` project files with the rest of HA (e.g., from a USB stick or the File Editor add-on), drop them in `/share/bambustudio/` — a convention, not enforced by the add-on.

---

## Security notes

- The web UI has a built-in terminal with `sudo` access inside the container. Keep this behind HA's authentication.
- Setting a `password` enables HTTP Basic Auth as a second layer — useful if you expose HA publicly.
- Do **not** expose port 3001 directly to the internet without a proper reverse proxy and authentication.

---

## Performance / GPU

By default the container uses CPU-based encoding (software renderer). For smoother performance on a capable host you can use the **Docker** add-on or a separate compose stack instead of this add-on, where you can pass `/dev/dri` device mounts. The HA add-on sandbox does not allow arbitrary device passthrough.

---

## Updating

The add-on pulls `lscr.io/linuxserver/bambustudio:latest`. To update Bambu Studio:

1. Go to **Settings → Add-ons → Bambu Studio**.
2. Click **Update** (or re-install if no update button appears and the version hasn't changed).

The `/share` and `/config` mounts persist across updates.
