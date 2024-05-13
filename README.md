# English Image Captioning - Backend Server

Image Captioning có thể cung cấp trải nghiệm tương tác mới mẻ cho người dùng. Nó có thể được sử dụng để tạo ra các mô tả tự động cho các bức ảnh trên các trang web chia sẻ hình ảnh, ứng dụng xem ảnh và các nền tảng mạng xã hội. Điều này giúp người dùng hiểu và tận hưởng nội dung hình ảnh một cách tốt hơn.

## Cài Đặt

Hướng dẫn này giúp bạn cài đặt và chạy dự án trên máy tính của mình.

### Yêu Cầu hệ thống

- [Python](https://www.python.org) đã được cài đặt trên máy tính của bạn.
- Flask
- Window SDK

### Bước 1: Sao chép mã nguồn

Clone dự án từ GitHub bằng lệnh sau:

```shell
git clone https://github.com/khang1010/EIC_Server.git
```

### Bước 2: Cài đặt dependencies

Di chuyển vào thư mục dự án:

```shell
cd EIC_Server
```

Cài đặt các dependencies bằng pip:

```shell
pip install numpy
```
```shell
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
```
```shell
pip install -r requirements.txt
```
Nếu gặp lỗi "Failed to build pycocotools" bạn hãy xử lý như sau:
1. Vào file requirement.txt
2. Xóa thông tin phiên bản sau pycocotools
3. Chạy lại câu lệnh:
```shell
pip install -r requirements.txt
```

```shell
pip install open_clip_torch
```

### Bước 3: Cấu hình

Cấu hình dự án của bạn (nếu có) bằng cách chỉnh sửa các tệp tin cấu hình cần thiết.

### Bước 4: Chạy dự án

Chạy dự án bằng lệnh:

```shell
flask run
```

- Dự án sẽ chạy trên máy tính của bạn và bạn có thể truy cập API với URL: `http://localhost:5000`.
- Để nhận được caption của hình ảnh bạn hãy gọi API với phương thức POST với URL: `http://localhost:5000/predict` và truyền ảnh vào body dưới dạng form-data, thông tin trả về sẽ là đoạn caption dành cho bức ảnh đó.
## Đóng góp

Nếu bạn muốn đóng góp vào dự án, hãy làm theo các bước sau:

1. Fork dự án
2. Tạo một nhánh mới (`git checkout -b feature/your-feature`)
3. Commit các thay đổi của bạn (`git commit -am 'Add some feature'`)
4. Push nhánh của bạn lên GitHub (`git push origin feature/your-feature`)
5. Tạo một yêu cầu kéo mới trên GitHub

## Tác giả

- Tên tác giả: Nguyen Tuan Khang
- Email: 21520963@gm.uit.edu.vn
