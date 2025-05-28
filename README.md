<!--LxaNce-->
<p align="center">
  <img src=".img/samba.png">
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Version-2.0-green?style=for-the-badge">
  <img src="https://img.shields.io/badge/License-GPL--3.0-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Purpose-Network%20Administration-orange?style=for-the-badge">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Bash-cyan?style=flat-square">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-cyan?style=flat-square">
  <img src="https://img.shields.io/badge/Open%20Source-Yes-cyan?style=flat-square">
</p>

## Overview

A professional SMB (Server Message Block) client tool designed for network administrators and IT professionals. This tool facilitates legitimate network administration tasks including authorized file sharing, network diagnostics, and system administration.

## ⚖️ Legal Usage Requirements

**IMPORTANT**: This tool is designed exclusively for legitimate network administration purposes. Users must ensure they have proper authorization before using this tool.

### Authorized Use Cases:
- ✅ Network administration on your own systems
- ✅ Authorized penetration testing with written permission
- ✅ Educational purposes in controlled environments
- ✅ IT support with proper organizational approval
- ✅ Forensic analysis with legal authorization

### Prohibited Use Cases:
- ❌ Unauthorized access to systems you don't own
- ❌ Malicious activities or data theft
- ❌ Violating organizational IT policies
- ❌ Any illegal or unethical activities

## 🚀 Features

- **User-Friendly Interface**: Clean, professional command-line interface
- **Input Validation**: Robust error handling and input validation
- **Cross-Platform**: Works on Linux, macOS, and Android (Termux)
- **Security Focused**: Includes legal compliance checks
- **Professional Logging**: Clear status messages and error reporting
- **Flexible Connection Options**: Supports various SMB connection scenarios

## 📋 Prerequisites

- `smbclient` package installed
- Basic understanding of SMB/CIFS protocols
- Appropriate network permissions

## 🛠️ Installation

### Linux (Ubuntu/Debian)
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install smbclient git

# Clone repository
git clone https://github.com/LxaNce-Hacker/samba
cd samba

# Make executable
chmod +x connect.sh
```

### CentOS/RHEL
```bash
sudo yum install samba-client git
# Then follow clone steps above
```

### Android (Termux)
```bash
pkg update
pkg install samba git
# Then follow clone steps above
```

## 🎯 Usage

```bash
./connect.sh
```

The tool will guide you through:
1. Legal authorization confirmation
2. Target IP address input
3. Workgroup specification (optional)
4. Username authentication
5. Share listing and connection

### Example Session
```
Enter target IP address: 192.168.1.100
Enter workgroup (press Enter for default): WORKGROUP
Enter username: administrator
```

## 🔧 Technical Details

### SMB Protocol Support
- SMB 1.0, 2.0, 2.1, 3.0, 3.1.1
- Both anonymous and authenticated connections
- Workgroup and domain authentication

### Network Requirements
- TCP port 445 (SMB over TCP)
- TCP port 139 (NetBIOS Session Service) - legacy
- Proper network routing to target

## 🛡️ Security Considerations

- Always use strong authentication credentials
- Implement proper network segmentation
- Monitor and log all SMB connections
- Regular security assessments
- Follow organizational IT policies

## 🤝 Contributing

Contributions are welcome! Please ensure all contributions maintain the professional and ethical standards of this project.

### Development Guidelines
- Follow bash scripting best practices
- Include proper error handling
- Maintain legal compliance features
- Test across multiple platforms
- Document all changes

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This tool is provided for educational and authorized network administration purposes only. Users are solely responsible for ensuring compliance with applicable laws and regulations. The developers assume no responsibility for misuse of this tool.

## 📞 Support

For legitimate business inquiries and support:
- Create an issue in this repository
- Provide detailed information about your use case
- Include relevant system information

## 🔗 Related Projects

- [Samba Project](https://www.samba.org/)
- [SMB Protocol Documentation](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/)
- [Network Security Best Practices](https://www.nist.gov/cybersecurity)

---

**Remember**: Always obtain proper authorization before testing network security tools.
