NerdKit - The Paranoid CyberSec Swiss Army Knife
For when you don't trust anything, but still need to get work done

What's This?
A single batch file packed with essential cyber security tools for:

Finding tampered files (like malware replacing your EXEs)

Cleaning your tracks (Windows logs, recent files, etc.)

Basic anonymity (DNS flushing, telemetry "disabling")

USB device checks (catch those shady "free gift" thumb drives)

No installs. No bloat. Just pure Windows CMD that works even on ancient systems.

Quick Start
Copy the script below into Notepad

Save as NerdKit.bat (must be .bat, not .txt!)

Right-click and select "Run as administrator" (for full access)

Pick your tool from the menu

Tools Breakdown
1. Scan ALL Files
What it does: Recursively checks every file in a folder (including subfolders)
Checks: File sizes, modification dates, and MD5 hashes
Output: scan_report.txt (compare over time to spot changes)
Use case:

"Did my Windows system files get replaced?"

"Has that malware infected my project folder?"

2. Nuke Windows Logs
What it nukes:

System/Application/Security event logs

Windows temp files

Various .log files scattered around
Use case:

Basic OpSec cleanup (not for serious forensics)

When you need to "reset" a system's log state

3. Anonymity Tools
Options:

Flush DNS: Clear local DNS cache

"Disable" Telemetry: (Sets registry key)

Clear Recent Files: Delete Explorer's "Recent Files" history
Use case:

Quick privacy cleanup on shared PCs

When you want slightly less tracking

4. USB Ninja Scanner
What it checks:

USB drive properties (size vs. reported capacity)

Suspicious files (autorun.inf, .vbs, .bat)

Folder structure anomalies
Output: usb_scan.txt
Use case:

"Is this USB safe to plug in?"

Basic BadUSB detection

Limitations
Not magic: Won't catch advanced malware (but great for basic checks)

MD5 only: For SHA-256, you'd need extra tools

Admin needed: Some features require elevated rights

Customizing
Add more file types to scan:
Edit the for /r line in :SCAN_ALL to include extensions like .ps1, .js, etc.

Add MAC randomization:
Drop NirSoft's macchange.exe in the same folder and add a menu option

License
WTFPL - Do whatever you want. If it breaks something, that's on you.

Why This Exists
Because sometimes you need:

A tool that works offline

No installs or dependencies

To see exactly what it's doing (no hidden "AI" nonsense)

Pro Tip: Run this from a USB drive for portable paranoia.
