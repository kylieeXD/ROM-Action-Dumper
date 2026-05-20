# ROM Dumper

A GitHub Actions tool to extract specific files from MIUI/HyperOS ROMs — built for
collecting proprietary blobs needed when building a custom ROM or device tree for a device.

> **This is not a mass ROM downloader.** It is designed specifically to extract files
> listed in `proprietary-files.txt`, such as camera libs, proprietary APKs, and vendor blobs.

## Use Case

- Extract proprietary blobs for a device tree
- Grab files listed in `proprietary-files.txt`
- Update camera libs from the latest ROM without manual flashing
- Diff files between ROM versions

## Setup

1. Fork or clone this repo
2. Go to **Settings** → **Secrets and variables** → **Actions**
3. Add a new secret:
   - **Name:** `PIXELDRAIN_KEY`
   - **Secret:** Your Pixeldrain API key

## Usage

1. Open the **Actions** tab
2. Select the **ROM Dumper** workflow
3. Click **Run workflow**
4. Fill in the form:

| Field | Description | Example |
|-------|-------------|---------|
| Device codename | The device codename | `ruby` |
| ROM download URL | Direct download link to the ROM (.zip) | `https://cdnorg.d.miui.com/.../ruby.zip` |
| Files to upload | Files to extract and upload to Pixeldrain | See examples below |

## File Input Examples

### Single file
```
out/product/priv-app/MiuiCamera/MiuiCamera.apk
```

### Multiple files using brace expansion
```
out/system_ext/lib64/{libcamera_algoup_jni.xiaomi.so,libcamera_mianode_jni.xiaomi.so,libcamera_ispinterface_jni.xiaomi.so}
```

### Multiple files from different paths
```
out/product/priv-app/MiuiCamera/MiuiCamera.apk out/system_ext/lib64/libcamera_algoup_jni.xiaomi.so
```

## Examples

### Ruby — Extract MiuiCamera
| Field | Value |
|-------|-------|
| Device codename | `ruby` |
| ROM download URL | `https://cdnorg.d.miui.com/OS2.0.3.0.UMOCNXM/ruby-ota_full-OS2.0.3.0.UMOCNXM-user-14.0-b33670e0c9.zip` |
| Files to upload | `out/product/priv-app/MiuiCamera/MiuiCamera.apk` |

### Plato — Extract Camera Libs
| Field | Value |
|-------|-------|
| Device codename | `plato` |
| ROM download URL | `https://cdnorg.d.miui.com/OS2.0.5.0.VLQMIXM/plato_global-ota_full-OS2.0.5.0.VLQMIXM-user-15.0-0f809b9ff6.zip` |
| Files to upload | `out/system_ext/lib64/{libcamera_algoup_jni.xiaomi.so,libcamera_mianode_jni.xiaomi.so,libcamera_ispinterface_jni.xiaomi.so,libmtkisp_metadata_sys.so,vendor.mediatek.hardware.camera.isphal@1.0.so,vendor.mediatek.hardware.camera.isphal-V1-ndk.so}` |

## Credits

- [DumprX](https://github.com/DumprX/DumprX) — used for extracting files from ROM images
