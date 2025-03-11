# NVIDIA Driver & CUDA Toolkit Installation Script
# Script Cài đặt NVIDIA Driver & CUDA Toolkit

## Table of Contents / Mục lục
- [English](#english)
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Notes](#notes)
- [Tiếng Việt](#tiếng-việt)
  - [Tính năng](#tính-năng)
  - [Cài đặt](#cài-đặt)
  - [Sử dụng](#sử-dụng)
  - [Lưu ý](#lưu-ý)

## English

### Features
- Automatic system updates before installation
- Installation verification
- Colored output for better progress tracking
- Automatic CUDA environment variables configuration
- Optional reboot after installation
- Auto-update functionality for the script itself

### Installation
```bash
# Download script from GitHub
wget https://raw.githubusercontent.com/fat-murphy/script-nvidia-smi/main/script-nvidia-smi.sh

# Make script executable
chmod +x script-nvidia-smi.sh
```

### Usage
1. Run the script with sudo:
```bash
sudo ./script-nvidia-smi.sh
```

2. Choose one of the following options:
   - `1`: Auto Driver Installation (Recommended)
   - `2`: Manual Driver Installation (You need to know the driver name, e.g., nvidia-driver-535)
   - `3`: Install CUDA Toolkit

### Notes
- Root privileges are required to run the script
- After driver installation, you can choose whether to reboot immediately
- For CUDA Toolkit, the script will automatically add environment variables to ~/.bashrc

## Tiếng Việt

### Tính năng
- Tự động cập nhật hệ thống trước khi cài đặt
- Kiểm tra và xác minh cài đặt
- Hiển thị thông báo màu sắc để dễ theo dõi tiến trình
- Tự động cấu hình biến môi trường CUDA
- Tùy chọn khởi động lại sau khi cài đặt
- Tự động cập nhật script khi có phiên bản mới

### Cài đặt
```bash
# Tải script từ GitHub
wget https://raw.githubusercontent.com/fat-murphy/script-nvidia-smi/main/script-nvidia-smi.sh

# Cấp quyền thực thi cho script
chmod +x script-nvidia-smi.sh
```

### Sử dụng
1. Chạy script với quyền sudo:
```bash
sudo ./script-nvidia-smi.sh
```

2. Chọn một trong các tùy chọn sau:
   - `1`: Cài đặt driver tự động (Khuyến nghị)
   - `2`: Cài đặt driver thủ công (Bạn cần biết tên driver, ví dụ: nvidia-driver-535)
   - `3`: Cài đặt CUDA Toolkit

### Lưu ý
- Script yêu cầu quyền root để chạy
- Sau khi cài đặt driver, bạn có thể chọn có khởi động lại ngay hay không
- Đối với CUDA Toolkit, script sẽ tự động thêm các biến môi trường vào ~/.bashrc
