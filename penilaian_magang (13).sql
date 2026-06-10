-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Jun 2026 pada 10.24
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penilaian_magang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bu_yuni`
--

CREATE TABLE `bu_yuni` (
  `id` int(11) NOT NULL,
  `data_magang_id` int(11) DEFAULT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `angkatan` varchar(20) DEFAULT NULL,
  `email_pribadi` varchar(255) DEFAULT NULL,
  `email_sekolah` varchar(100) DEFAULT NULL,
  `sekolah` varchar(100) DEFAULT NULL,
  `dokumen_penilaian` varchar(255) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tanggal_dinilai` date DEFAULT NULL,
  `unit_penempatan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_magang`
--

CREATE TABLE `data_magang` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `angkatan` varchar(20) DEFAULT NULL,
  `email_pribadi` varchar(255) DEFAULT NULL,
  `email_sekolah` varchar(100) DEFAULT NULL,
  `sekolah` varchar(100) DEFAULT NULL,
  `universitas` varchar(100) DEFAULT NULL,
  `email_universitas` varchar(100) DEFAULT NULL,
  `dokumen_pendaftaran` varchar(255) DEFAULT NULL,
  `dokumen_penilaian` varchar(255) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `tanggal_dinilai` date DEFAULT NULL,
  `unit_penempatan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Trigger `data_magang`
--
DELIMITER $$
CREATE TRIGGER `trg_user_to_data_magang` BEFORE INSERT ON `data_magang` FOR EACH ROW BEGIN
    SET NEW.email_pribadi = (
        SELECT email_pribadi 
        FROM users 
        WHERE id = NEW.user_id
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `logbook`
--

CREATE TABLE `logbook` (
  `id` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `kegiatan` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `status` enum('menunggu','disetujui','ditolak') DEFAULT 'menunggu',
  `data_magang_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pak_hani`
--

CREATE TABLE `pak_hani` (
  `id` int(11) NOT NULL,
  `data_magang_id` int(11) DEFAULT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `angkatan` varchar(20) DEFAULT NULL,
  `email_pribadi` varchar(255) DEFAULT NULL,
  `email_universitas` varchar(100) DEFAULT NULL,
  `universitas` varchar(100) DEFAULT NULL,
  `dokumen_penilaian` varchar(255) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tanggal_dinilai` date DEFAULT NULL,
  `unit_penempatan` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penilaian`
--

CREATE TABLE `penilaian` (
  `id` int(11) NOT NULL,
  `magang_id` int(11) NOT NULL,
  `disiplin` int(11) DEFAULT NULL,
  `kehadiran` int(11) DEFAULT NULL,
  `tanggung_jawab` int(11) DEFAULT NULL,
  `kejujuran` int(11) DEFAULT NULL,
  `kerjasama_tim` int(11) DEFAULT NULL,
  `inisiatif` int(11) DEFAULT NULL,
  `kerapihan_kerja` int(11) DEFAULT NULL,
  `kemampuan_tugas` int(11) DEFAULT NULL,
  `penguasaan_skill` int(11) DEFAULT NULL,
  `komunikasi` int(11) DEFAULT NULL,
  `catatan_pembimbing` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email_pribadi` varchar(100) DEFAULT NULL,
  `instansi` varchar(150) DEFAULT NULL,
  `role` enum('admin','participant') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email_pribadi`, `instansi`, `role`, `created_at`) VALUES
(4, 'admin', 'admin123', 'admin@email.com', NULL, 'admin', '2025-12-15 07:57:23');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bu_yuni`
--
ALTER TABLE `bu_yuni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bu_yuni_data_magang` (`data_magang_id`);

--
-- Indeks untuk tabel `data_magang`
--
ALTER TABLE `data_magang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_data_magang_user` (`user_id`);

--
-- Indeks untuk tabel `logbook`
--
ALTER TABLE `logbook`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logbook_data_magang` (`data_magang_id`);

--
-- Indeks untuk tabel `pak_hani`
--
ALTER TABLE `pak_hani`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pak_hani_data_magang` (`data_magang_id`);

--
-- Indeks untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penilaian_data_magang` (`magang_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bu_yuni`
--
ALTER TABLE `bu_yuni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT untuk tabel `data_magang`
--
ALTER TABLE `data_magang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=495;

--
-- AUTO_INCREMENT untuk tabel `logbook`
--
ALTER TABLE `logbook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT untuk tabel `pak_hani`
--
ALTER TABLE `pak_hani`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bu_yuni`
--
ALTER TABLE `bu_yuni`
  ADD CONSTRAINT `fk_bu_yuni_data_magang` FOREIGN KEY (`data_magang_id`) REFERENCES `data_magang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_magang`
--
ALTER TABLE `data_magang`
  ADD CONSTRAINT `fk_data_magang_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `logbook`
--
ALTER TABLE `logbook`
  ADD CONSTRAINT `fk_logbook_data_magang` FOREIGN KEY (`data_magang_id`) REFERENCES `data_magang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pak_hani`
--
ALTER TABLE `pak_hani`
  ADD CONSTRAINT `fk_pak_hani_data_magang` FOREIGN KEY (`data_magang_id`) REFERENCES `data_magang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD CONSTRAINT `fk_penilaian_data_magang` FOREIGN KEY (`magang_id`) REFERENCES `data_magang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
