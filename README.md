# Hướng dẫn cài đặt NVIDIA Driver và CUDA Toolkit

## Tải script

```bash
# Tải script từ GitHub
wget https://raw.githubusercontent.com/fat-murphy/script-nvidia-smi/main/script-nvidia-smi.sh

# Cấp quyền thực thi cho script
chmod +x script-nvidia-smi.sh
```

## Sử dụng

1. Chạy script với quyền sudo:
```bash
sudo ./script-nvidia-smi.sh
```

2. Chọn một trong các tùy chọn sau:
   - `1`: Cài đặt driver tự động (Khuyến nghị)
   - `2`: Cài đặt driver thủ công (Bạn cần biết tên driver, ví dụ: nvidia-driver-535)
   - `3`: Cài đặt CUDA Toolkit

## Lưu ý

- Script yêu cầu quyền root để chạy
- Sau khi cài đặt driver, bạn có thể chọn có khởi động lại ngay hay không
- Đối với CUDA Toolkit, script sẽ tự động thêm các biến môi trường vào ~/.bashrc

## Tính năng

- Tự động cập nhật hệ thống trước khi cài đặt
- Kiểm tra và xác minh cài đặt
- Hiển thị thông báo màu sắc để dễ theo dõi tiến trình
- Tự động cấu hình CUDA environment variables
- Tùy chọn khởi động lại sau khi cài đặt
