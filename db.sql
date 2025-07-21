CREATE DATABASE HabitTracker;
USE HabitTracker;
-- Bảng Người Dùng
-- Bảng Người Dùng
CREATE TABLE NguoiDung (
  TenNguoiDung VARCHAR(50) PRIMARY KEY,
  Email VARCHAR(100) UNIQUE,
  MatKhau VARCHAR(255),
  NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Thói Quen
CREATE TABLE ThoiQuen (
  MaThoiQuen SERIAL PRIMARY KEY,
  TieuDe VARCHAR(100),
  MoTa TEXT,
  NguoiTao VARCHAR(50) REFERENCES NguoiDung(TenNguoiDung),
  NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng Người Dùng - Thói Quen (nhiều-nhiều)
CREATE TABLE NguoiDung_ThoiQuen (
  TenNguoiDung VARCHAR(50),
  MaThoiQuen INT,
  NgayBatDau DATE,
  MucTieuHangNgay INT,
  DonVi VARCHAR(50),
  PRIMARY KEY (TenNguoiDung, MaThoiQuen),
  FOREIGN KEY (TenNguoiDung) REFERENCES NguoiDung(TenNguoiDung),
  FOREIGN KEY (MaThoiQuen) REFERENCES ThoiQuen(MaThoiQuen)
);

-- Bảng theo dõi tiến độ
CREATE TABLE TheoDoiThoiQuen (
  MaGhiNhan SERIAL PRIMARY KEY,
  TenNguoiDung VARCHAR(50),
  MaThoiQuen INT,
  Ngay DATE,
  TrangThai BOOLEAN,
  GiaTriDatDuoc INT,
  UNIQUE (TenNguoiDung, MaThoiQuen, Ngay),
  FOREIGN KEY (TenNguoiDung) REFERENCES NguoiDung(TenNguoiDung),
  FOREIGN KEY (MaThoiQuen) REFERENCES ThoiQuen(MaThoiQuen)
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
