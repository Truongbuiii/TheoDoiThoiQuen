CREATE DATABASE HabitTracker;
USE HabitTracker;
-- Bảng Người Dùng
-- Bảng Người Dùng
-- Bảng người dùng
CREATE TABLE nguoidung (
  tennguoidung VARCHAR(50) PRIMARY KEY,
  email VARCHAR(100) UNIQUE,
  matkhau VARCHAR(255),
  ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thói quen
CREATE TABLE thoiquen (
  mathoiquen SERIAL PRIMARY KEY,
  tieude VARCHAR(100),
  mota TEXT,
  nguoitao VARCHAR(50) REFERENCES nguoidung(tennguoidung),
  ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng người dùng - thói quen (nhiều-nhiều)
CREATE TABLE nguoidung_thoiquen (
  tennguoidung VARCHAR(50),
  mathoiquen INT,
  ngaybatdau DATE,
  muctieuhangngay INT,
  donvi VARCHAR(50),
  PRIMARY KEY (tennguoidung, mathoiquen),
  FOREIGN KEY (tennguoidung) REFERENCES nguoidung(tennguoidung),
  FOREIGN KEY (mathoiquen) REFERENCES thoiquen(mathoiquen)
);

-- Bảng theo dõi tiến độ
CREATE TABLE theodoithoiquen (
  maghinhan SERIAL PRIMARY KEY,
  tennguoidung VARCHAR(50),
  mathoiquen INT,
  ngay DATE,
  trangthai BOOLEAN,
  giatridatduoc INT,
  UNIQUE (tennguoidung, mathoiquen, ngay),
  FOREIGN KEY (tennguoidung) REFERENCES nguoidung(tennguoidung),
  FOREIGN KEY (mathoiquen) REFERENCES thoiquen(mathoiquen)
);



INSERT INTO NguoiDung (TenNguoiDung, Email, MatKhau)
VALUES 
('truongbd', 'truong@example.com', '$2y$10$vQXhYYq3iR9I5u7nMGO7r.fYhFx6YiBJzYHJKo3VVUFMM5EVQUVgC'),
('ngocanh', 'ngocanh@example.com', '$2y$10$DME2co1U1QRC2on3lGBOzOg9kTJ8Q8FNYw3Ksp8XxWwsX.5cKZGVy'),
('admin', 'admin@habit.com', '$2y$10$e9j2cZCFAhzmrQb0Hq8DC.tEcPC6LUAGC4FTLuF2X2sFoaxEp1.zG');


INSERT INTO ThoiQuen (TieuDe, MoTa, NguoiTao)
VALUES 
('Uống nước', 'Uống đủ 2 lít nước mỗi ngày', NULL),  -- Thói quen do hệ thống tạo
('Chạy bộ', 'Chạy 30 phút mỗi sáng', 'truongbd'),
('Đọc sách', 'Đọc 20 trang sách mỗi ngày', 'ngocanh');


-- Giả sử các ID thói quen tương ứng là 1: Uống nước, 2: Chạy bộ, 3: Đọc sách
INSERT INTO NguoiDung_ThoiQuen (TenNguoiDung, MaThoiQuen, NgayBatDau, MucTieuHangNgay, DonVi)
VALUES 
('truongbd', 1, '2025-06-01', 2000, 'ml'),
('truongbd', 2, '2025-06-10', 30, 'phút'),
('ngocanh', 1, '2025-06-05', 1500, 'ml'),
('ngocanh', 3, '2025-06-15', 20, 'trang');


INSERT INTO TheoDoiThoiQuen (TenNguoiDung, MaThoiQuen, Ngay, TrangThai, GiaTriDatDuoc)
VALUES 
('truongbd', 1, '2025-06-28', 1, 2100),
('truongbd', 2, '2025-06-28', 1, 35),
('ngocanh', 1, '2025-06-28', 1, 1600),
('ngocanh', 3, '2025-06-28', 1, 22),
('truongbd', 1, '2025-06-29', 0, 1000);
