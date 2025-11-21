# Task_4

# **Automated Backup System**

---

## **A. Project Overview**

This project provides an automated backup script that creates compressed backups of important folders, verifies them, and manages old backups to save storage space. It ensures that your files are safely archived and that only the most relevant backups are kept.

---

### **What the Script Does**

- Takes a folder as input and creates a `.tar.gz` compressed backup file.
- Generates a checksum to ensure that the backup is valid and not corrupted.
- Skips unwanted folders like `.git`, `node_modules`, and temporary cache folders.
- Automatically deletes older backups while keeping recent daily, weekly, and monthly backups.
- Logs every action to a `backup.log` file.
- Supports a **dry-run mode** to preview actions without making changes.

---

### **Why It Is Useful**

Manually backing up files can be time-consuming and easy to forget.  
This script automates the entire backup process, ensures data safety, and avoids wasted storage due to too many old backups.

---

## **B. How to Use It**

---

### **1. Installation**

1. Place the script files `backup.sh` and `backup.conf` in the same folder.  
2. Make the script executable:

```bash
chmod +x backup.sh
```

3. (Optional) Edit `backup.conf` to customize:

```bash
BACKUP_DESTINATION=/home/backups
EXCLUDE_PATTERNS=".git,node_modules,.cache"
DAILY_KEEP=7
WEEKLY_KEEP=4
MONTHLY_KEEP=3
```

---

### **2. Basic Usage Examples**

## **Purpose / Command Example**

| **Purpose**                     | **Command Example**                                                                 |
|--------------------------------|---------------------------------------------------------------------------------------|
| Run backup normally            | `./backup.sh /path/to/folder`                                                         |
| Test without changing anything | `./backup.sh --dry-run /path/to/folder`                                              |
| List existing backups          | `./backup.sh --list`                                                                  |
| Restore from a backup         | `./backup.sh --restore backup-YYYY-MM-DD-HHMM.tar.gz --to /path/to/restore/`          |

---

### **3. Command Options**

## **Command Options**

| **Option**                       | **Meaning**                                                  |
|----------------------------------|--------------------------------------------------------------|
| `--dry-run`                      | Shows what the script *would* do without making changes      |
| `--list`                         | Displays all available backups                               |
| `--restore <file> --to <path>`   | Extracts backup contents into a destination folder           |

---

## **C. How It Works**

---

### **Backup Naming Format**

```
backup-YYYY-MM-DD-HHMM.tar.gz
```

**Example:**

```
backup-2025-11-21-1549.tar.gz
```
<img width="1142" height="295" alt="Image" src="https://github.com/user-attachments/assets/aac7e46a-efa8-4fe7-853a-f23a65390016" />
---

### **Excluding Unnecessary Files**

The script reads patterns from `EXCLUDE_PATTERNS` and passes them to `tar`.

Common skipped folders:

- `.git`
- `node_modules`
- `.cache`

---

### **Checksum Verification**

- After backup, a checksum (SHA256 by default) is generated.  
- The checksum is stored in a `.md5` file.  
- During verification, the script recomputes and compares the two checksums.

---

### **Backup Rotation Rules**

The script keeps:

- **7 daily** backups  
- **4 weekly** backups  
- **3 monthly** backups  

Backups older than these are deleted.

---

### **Folder Structure**

```
backups/
 ├── backup-2025-11-21-1549.tar.gz
 ├── backup-2025-11-21-1549.tar.gz.md5
 └── ...
```

---

## **D. Design Decisions**

---

### **Why This Approach?**

- `tar` and `gzip` provide fast and widely supported compression.  
- SHA256 checksums are reliable for detecting corruption.  
- Rotation by date ensures predictable backup retention.

---

### **Challenges Faced**

| **Challenge**                                   | **Solution**                                 |
|-------------------------------------------------|-----------------------------------------------|
| Preventing two backup runs at the same time     | Added a lock file `/tmp/backup.lock`          |
| Avoiding unnecessary data in backups            | User-configurable exclude patterns            |
| Saving storage space                             | Implemented daily/weekly/monthly rotation     |

---

## **E. Testing**

---

### **Testing Steps**

- Ran the script in `--dry-run` mode to confirm actions.  
- Created real backups and verified checksum validation.  
- Deleted and restored sample test folders.

---

### **Example Output**

```
[2025-11-21 15:49:03] INFO: Starting backup of /c/Users/harip/Desktop/projects
[2025-11-21 15:49:03] SUCCESS: Backup created: backup-2025-11-21-1549.tar.gz
[2025-11-21 15:49:03] INFO: Checksum created: backup-2025-11-21-1549.tar.gz.md5
[2025-11-21 15:49:04] INFO: Archive integrity OK
[2025-11-21 15:49:04] INFO: Applying retention policy
[2025-11-21-1549.tar.gz
[2025-11-21 15:49:04] SUCCESS: Backup job completed for /c/Users/harip/Desktop/projects
```


## **F. Known Limitations**

| **Limitation**                       | **Explanation**                                           |
|--------------------------------------|-----------------------------------------------------------|
| Incremental backups not supported    | Script currently backs up full folder every time          |
| Email notifications simulated only   | Real email sending requires configuring mail server       |
| Date processing uses GNU date        | On macOS, may require installing `coreutils`              |

---

### **Future Improvements**

- Add incremental backup support  
- Add real email alerts  
- Add GUI or web interface  

---

## **G. Conclusion**

This automated backup system helps ensure your important files are safely archived and managed.  
It simplifies the entire backup process — from creating compressed backups to verifying them and cleaning up old files.  
While there is room for improvement, the script provides a strong foundation for reliable and efficient backups.
