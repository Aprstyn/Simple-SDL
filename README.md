# Simple-SDL
## Usage
1. Save the script as `SDL.sh`.
2. Make it executable:
   ```bash
   chmod +x SDL.sh
   ```
3. Run:
   ```bash
   ./SDL.sh /path/to/directory
   ```
   If no argument is given, the script will use the current directory (`.`).

---

## Key parts explained
- `stat -c "  Access: %x" "$1"` & `stat -c "  Modify: %y" "$1"` — print human-readable access and modification times.
- `stat -c %X` & `stat -c %Y` — retrieve epoch seconds for atime/mtime to store them.
- `ls -la "$dir"` — list directory contents with details.
- `touch -a -d "@$original_atime" "$dir"` & `touch -m -d "@$original_mtime" "$dir"` — restore the directory's access and modification times.

---

## Technical limitations
- Restoring a directory's timestamps **does not** remove all traces of activity. Kernel logs, auditd, filesystem journals, or other metadata may still record access.
- The script does **not** modify timestamps of files inside the directory; only the directory's own timestamps are restored.
- On certain filesystems (e.g., network mounts like NFS/SMB or filesystems with restricted attributes), `touch` may fail or behave differently.
- Appropriate permissions are required to modify timestamps; if lacking, the restoration will fail.

---
