# BYOE — AV Evasion & Post-Exploitation (English)

<p align="center"> <strong>Made with ❤️ by CHOUBIK Houssam</strong></p>


---

> **Warning:** For *educational use only* in isolated lab environments. Unauthorized use is prohibited.

---

## Table of Contents

1. Project Overview
2. Repository Structure
3. File Descriptions
4. High-level Usage
5. Findings
6. Detection & Mitigation
7. Lab Best Practices
8. Limitations & Ethics
9. Contact

---

## 1. Project Overview

A concise, lab-focused proof-of-concept demonstrating a BYOE (Bring-Your-Own-Environment) chain: payload generation, integration into a Python in-memory loader, observation of artifacts, and recommended defensive rules. Intended for defenders and researchers to understand and detect such techniques.

---

## 2. Repository Structure

* `malware.py` — demonstrative Python loader (PoC). **Educational only.**
* `gen_shellcode.sh` — helper Bash script to generate a Python-formatted payload.
* `msfconsole.txt` — example Metasploit handler template for lab use.

---

## 3. File Descriptions

### `gen_shellcode.sh`

**Purpose:** Automates payload generation by calling an external tool to emit a Python-formatted byte array.
**Notes:** Prompts for LHOST, LPORT, and output filename. Use only inside a controlled lab with required tooling installed.

### `msfconsole.txt`

**Purpose:** Template for starting a Metasploit multi/handler listener in your lab.
**Notes:** Replace placeholders with lab addresses. For validation and post-exploit interaction only.

### `malware.py`

**Purpose:** PoC loader showing how an interpreter can allocate executable memory, write a byte blob, and invoke it.
**Notes:** Uses `ctypes` to call Windows APIs. **Do not run outside an isolated VM.**

---

## 4. High-level Usage

1. Prepare an isolated lab (VMs, isolated network).
2. Generate payload with `gen_shellcode.sh` (external tools required).
3. Insert payload into `malware.py` locally for observation.
4. Start monitoring (EDR, Sysmon, packet capture) and a listener in the lab.
5. Run PoC only to collect artifacts and tune detections.

---

## 5. Findings

* **In-memory execution** may evade static checks but produces behavioral artifacts: RWX allocations, memory writes, thread creation/execution, and outbound C2 connections.
* **Privilege escalation** is not guaranteed—UAC and up-to-date patches can block attempts.

---

## 6. Detection & Mitigation (prioritized)

**High priority**

* **Interpreter memory injection:** Alert when interpreters (e.g., `python.exe`) allocate RWX memory, write large binary blobs, and execute them. Capture memory and start incident response.

**Medium priority**

* **Unusual outbound C2:** Alert on HTTPS to non-approved hosts/ports initiated by unsigned or user-space binaries.
* **Abnormal process behavior:** Alert when non-privileged processes control UI components or spawn interactive binaries.

**Mitigations**

* Implement allow-listing (WDAC), egress filtering, DNS/IP reputation checks.
* Enable Sysmon with API call logging and automatic memory capture for suspicious processes.

---

## 7. Lab Best Practices

* Operate in isolated VMs with dedicated networking.
* Use snapshots and restore between tests.
* Log all actions and obtain written authorization.
* Destroy and sanitize artifacts after testing.

---

## 8. Limitations & Ethics

Results are lab-specific: EDR vendor, OS version, patch level, and network configuration strongly affect detectability.
This project exists to improve defensive capability—not to facilitate malicious activity.

---
