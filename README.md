
# Cysic Testnet Installation Guide

### This guide will help you install and set up the necessary components using the provided install.sh script.


## Overview
#### The install.sh script automates the setup process for the Cysic Testnet. Follow these steps to install and configure everything needed to get started.


### Prerequisites
#### Before running the script, ensure you have the following:

- A Unix-based Operating System (Linux, macOS, etc.) or Windows.

- Curl: Used to download the script.

- A terminal or command-line interface.

### System Requirements
#### Ensure your device meets the following minimum specifications for a smooth installation:

- CPU: Single Core 

- Memory: 512 MB

- Disk: 10 GB

- Bandwidth: 100 KB/s upload/download


## Installation

### 1. Download the Script
#### Open your terminal and execute the following command to download the install.sh script:


```bash
curl -O https://raw.githubusercontent.com/smdbngkt/cysic/main/install.sh
```
    
### 2. Make the Script Executable

#### After downloading the script, you need to make it executable. Run:

```bash
chmod +x install.sh
```

### 3. Run the Script

#### Execute the script to start the installation process:

```bash
./install.sh
```

### 4. Using screen to Keep the Process Running

#### To ensure the installation and setup process continues running even if you disconnect from your terminal, you can use the screen utility. Follow these steps:

##### **a. Install screen (if not already installed)**

*For Ubuntu/Debian:*

```bash
sudo apt-get install screen
```
*For CentOS/RHEL:*

```bash
sudo yum install screen
```
##### **b. Start a screen session**

```bash
screen -S cysic-installation
```
##### **c. Run the installation script within the screen session**

```bash
./install.sh
```
##### **d. Detach from the screen sessio**

*Press Ctrl+a followed by d to detach from the session while keeping it running in the background.*

##### **e. Reattach to the screen session**

*To reattach to your screen session, use:*

```bash
screen -r cysic-installation
```

### Additional Resources

For more information, refer to the [official Cysic Testnet Documentation](https://medium.com/@cysic/join-the-cysic-testnet-as-a-verifier-7b9f31674b41) or join our community [discord](https://discord.gg/9vxGzxSV) for support.
