CREATE DATABASE db_agen_wisata;
USE db_agen_wisata;

CREATE TABLE pelanggan (
    id_pelanggan    INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan  VARCHAR(100) NOT NULL,
    jenis_kelamin   ENUM('Laki-laki', 'Perempuan') NOT NULL,
    no_hp           VARCHAR(20),
    email           VARCHAR(100),
    alamat          TEXT
);

CREATE TABLE destinasi (
    id_destinasi    INT AUTO_INCREMENT PRIMARY KEY,
    nama_destinasi  VARCHAR(100) NOT NULL,
    kota            VARCHAR(100) NOT NULL,
    provinsi        VARCHAR(100) NOT NULL,
    deskripsi       TEXT
);

CREATE TABLE transportasi (
    id_transportasi     INT AUTO_INCREMENT PRIMARY KEY,
    jenis_transportasi  VARCHAR(50)  NOT NULL,
    nama_transportasi   VARCHAR(100) NOT NULL,
    kapasitas           INT NOT NULL
);

CREATE TABLE hotel (
    id_hotel     INT AUTO_INCREMENT PRIMARY KEY,
    nama_hotel   VARCHAR(100) NOT NULL,
    kota         VARCHAR(100) NOT NULL,
    kelas_hotel  VARCHAR(50)
);

CREATE TABLE pemandu_wisata (s
    id_pemandu  INT AUTO_INCREMENT PRIMARY KEY,
    nama        VARCHAR(100) NOT NULL,
    no_hp       VARCHAR(20),
    deskripsi   TEXT
);

CREATE TABLE paket_wisata (
    id_paket        INT AUTO_INCREMENT PRIMARY KEY,
    nama_paket      VARCHAR(100) NOT NULL,
    durasi          VARCHAR(50)  NOT NULL,
    total_harga     DECIMAL(12,2) NOT NULL,
    fasilitas       TEXT,
    id_transportasi INT NOT NULL,
    id_hotel        INT NOT NULL,
    id_pemandu      INT NOT NULL,
    FOREIGN KEY (id_transportasi) REFERENCES transportasi(id_transportasi)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_pemandu) REFERENCES pemandu_wisata(id_pemandu)
);

CREATE TABLE paket_destinasi (
    id_paket        INT NOT NULL,
    id_destinasi    INT NOT NULL,
    PRIMARY KEY (id_paket, id_destinasi),
    FOREIGN KEY (id_paket)      REFERENCES paket_wisata(id_paket)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_destinasi)  REFERENCES destinasi(id_destinasi)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE pemesanan (
    id_pemesanan        INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan        INT NOT NULL,
    id_paket            INT NOT NULL,
    tanggal_pemesanan   DATE NOT NULL,
    tanggal_berangkat   DATE NOT NULL,
    jumlah_peserta      INT NOT NULL,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_paket)     REFERENCES paket_wisata(id_paket)
);

CREATE TABLE pembayaran (
    id_pembayaran       INT AUTO_INCREMENT PRIMARY KEY,
    id_pemesanan        INT NOT NULL,
    tanggal_pembayaran  DATE NOT NULL,
    metode_pembayaran   VARCHAR(50) NOT NULL,
    jumlah_bayar        DECIMAL(12,2) NOT NULL,
    status_pembayaran   ENUM('Belum Lunas', 'Lunas', 'Dibatalkan') DEFAULT 'Belum Lunas',
    FOREIGN KEY (id_pemesanan) REFERENCES pemesanan(id_pemesanan)
);

INSERT INTO pelanggan (nama_pelanggan, jenis_kelamin, no_hp, email, alamat) VALUES
('Malik Ahmad',       'Laki-laki',  '083556785632', 'malikahmad@gmail.com',  'Jakarta'),
('Dewi Candra',       'Perempuan',  '084796576432', 'dewi09@gmail.com',       'Bandung'),
('Citra Lestari',     'Perempuan',  '082334126779', 'citra07@gmail.com',      'Surabaya'),
('Dimas Pratama',     'Laki-laki',  '084991665349', 'dimaspra@gmail.com',     'Yogyakarta'),
('Eka Putri',         'Perempuan',  '087734478907', 'ekaptr@gmail.com',       'Semarang'),
('Fajar Nugroho',     'Laki-laki',  '087556487021', 'fajarnug@gmail.com',     'Medan'),
('Gita Rahayu',       'Perempuan',  '082668936184', 'gitarhy@gmail.com',      'Makassar'),
('Hendra Wijaya',     'Laki-laki',  '082333789650', 'hendraw@gmail.com',      'Palembang'),
('Indah Permata',     'Perempuan',  '087123654987', 'indahpmt@gmail.com',     'Denpasar'),
('Joko Susanto',      'Laki-laki',  '089876783458', 'jokosus@gmail.com',      'Solo'),
('Kartika Dewi',      'Perempuan',  '088888967437', 'kartikadewi@gmail.com',  'Malang'),
('Lukman Hakim',      'Laki-laki',  '081567345987', 'lukmanh@gmail.com',      'Pekanbaru'),
('Maya Anggraini',    'Perempuan',  '084455667788', 'mayaang@gmail.com',      'Balikpapan'),
('Nanda Saputra',     'Laki-laki',  '082444487947', 'nandasap@gmail.com',     'Lampung'),
('Olivia Santoso',    'Perempuan',  '085331256774', 'oliviasan@gmail.com',    'Manado'),
('Pandu Wicaksono',   'Laki-laki',  '086789876543', 'panduwic@gmail.com',     'Samarinda'),
('Qori Nabila',       'Perempuan',  '086789742678', 'qorinab@gmail.com',      'Padang'),
('Raka Setiawan',     'Laki-laki',  '085836754724', 'rakaseti@gmail.com',     'Banjarmasin'),
('Sari Utami',        'Perempuan',  '081694357568', 'sariutami@gmail.com',    'Ambon'),
('Taufik Hidayat',    'Laki-laki',  '089877796543', 'taufikhid@gmail.com',    'Kupang');

INSERT INTO destinasi (nama_destinasi, kota, provinsi, deskripsi) VALUES
('Pantai Kuta',             'Badung',        'Bali',              'Pantai terkenal di Bali dengan pemandangan sunset.'),
('Candi Borobudur',         'Magelang',      'Jawa Tengah',       'Candi Buddha terbesar di Indonesia.'),
('Gunung Bromo',            'Probolinggo',   'Jawa Timur',        'Wisata gunung dengan pemandangan sunrise.'),
('Malioboro',               'Yogyakarta',    'DI Yogyakarta',     'Kawasan wisata belanja dan budaya.'),
('Raja Ampat',              'Waisai',        'Papua Barat Daya',  'Destinasi wisata bahari dengan keindahan bawah laut.'),
('Danau Toba',              'Samosir',       'Sumatera Utara',    'Danau vulkanik terbesar di dunia.'),
('Komodo Island',           'Labuan Bajo',   'NTT',               'Habitat asli komodo dan wisata bahari.'),
('Taman Nasional Baluran',  'Situbondo',     'Jawa Timur',        'Sabana luas yang dijuluki Afrika van Java.'),
('Pantai Pink',             'Lombok Timur',  'NTB',               'Pantai unik dengan pasir berwarna merah muda.'),
('Dieng Plateau',           'Wonosobo',      'Jawa Tengah',       'Dataran tinggi dengan candi dan kawah indah.'),
('Tana Toraja',             'Toraja Utara',  'Sulawesi Selatan',  'Wisata budaya dan pemakaman adat yang unik.'),
('Kepulauan Banda',         'Banda Neira',   'Maluku',            'Surga bahari dengan sejarah rempah-rempah.'),
('Pantai Ora',              'Seram',         'Maluku',            'Pantai tersembunyi dengan air jernih di Seram.'),
('Bukit Lawang',            'Langkat',       'Sumatera Utara',    'Wisata hutan hujan tropis dengan orangutan.'),
('Gili Trawangan',          'Lombok Utara',  'NTB',               'Pulau kecil cantik tanpa kendaraan bermotor.'),
('Pulau Weh',               'Sabang',        'Aceh',              'Ujung barat Indonesia dengan bawah laut memukau.'),
('Lembah Baliem',           'Wamena',        'Papua Pegunungan',  'Lembah budaya suku Dani yang eksotis.'),
('Derawan Island',          'Berau',         'Kalimantan Timur',  'Surga penyu dan ubur-ubur tanpa sengat.'),
('Kawah Ijen',              'Banyuwangi',    'Jawa Timur',        'Kawah dengan api biru fenomenal dan danau asam.'),
('Pulau Pahawang',          'Pesawaran',     'Lampung',           'Pulau cantik dengan snorkeling terbaik di Lampung.');

INSERT INTO transportasi (jenis_transportasi, nama_transportasi, kapasitas) VALUES
('Bus',         'Bus Pariwisata Medium',    30),
('Mobil',       'Toyota Hiace',             14),
('Mobil',       'Avanza Travel',             6),
('Jeep',        'Jeep Bromo',                5),
('Kapal',       'Speedboat Wisata',         10),
('Bus',         'Bus Pariwisata Besar',     45),
('Mobil',       'Innova Reborn',             7),
('Kapal',       'Kapal Ferry Wisata',       60),
('Motor',       'Motor Trail Offroad',       1),
('Mobil',       'Elf Long',                 15),
('Kapal',       'Kapal Layar Phinisi',      20),
('Helikopter',  'Helikopter Wisata',         4),
('Mobil',       'HiAce Premio',             10),
('Bus',         'Bus Mini Wisata',          20),
('Kapal',       'Perahu Tradisional',        8),
('Jeep',        'Jeep Hardtop Offroad',      6),
('Mobil',       'Alphard VIP',               6),
('Kapal',       'Kapal Katamaran',          25),
('Mobil',       'Fortuner 4x4',              7),
('Bus',         'Double Decker Wisata',     50);

INSERT INTO hotel (nama_hotel, kota, kelas_hotel) VALUES
('Hotel Bali Indah',            'Badung',        'Bintang 3'),
('Hotel Borobudur View',        'Magelang',      'Bintang 3'),
('Bromo Homestay',              'Probolinggo',   'Homestay'),
('Jogja Comfort Hotel',         'Yogyakarta',    'Bintang 3'),
('Raja Ampat Resort',           'Waisai',        'Resort'),
('Samosir Lake Hotel',          'Samosir',       'Bintang 3'),
('Labuan Bajo Inn',             'Labuan Bajo',   'Bintang 2'),
('Baluran Camp Lodge',          'Situbondo',     'Homestay'),
('Lombok Beach Resort',         'Lombok Timur',  'Bintang 4'),
('Dieng Mountain Cottage',      'Wonosobo',      'Homestay'),
('Toraja Heritage Hotel',       'Toraja Utara',  'Bintang 3'),
('Bali Kuta Sunrise Hotel',     'Badung',        'Bintang 4'),
('Grand Yogyakarta Hotel',      'Yogyakarta',    'Bintang 4'),
('Banda Neira Guest House',     'Banda Neira',   'Bintang 2'),
('Seram Ora Beach Cottage',     'Seram',         'Cottage'),
('Bukit Lawang Riverside Inn',  'Langkat',       'Homestay'),
('Gili Sunset Bungalow',        'Lombok Utara',  'Bintang 3'),
('Ijen Valley Hotel',           'Banyuwangi',    'Bintang 2'),
('Derawan Dive Lodge',          'Berau',         'Bintang 3'),
('Pahawang Beach Homestay',     'Pesawaran',     'Homestay');

INSERT INTO pemandu_wisata (nama, no_hp, deskripsi) VALUES
('Agus Santoso',     '081311112222', 'Pemandu berpengalaman di Bali dan Lombok.'),
('Budi Hartono',     '082322223333', 'Spesialis wisata gunung dan alam bebas.'),
('Cahya Nugroho',    '083333334444', 'Ahli sejarah candi Jawa Tengah dan DIY.'),
('Dian Puspita',     '084344445555', 'Pemandu budaya dan adat Toraja.'),
('Eko Prasetyo',     '085355556666', 'Guide bahari dan menyelam Raja Ampat.'),
('Fitri Wahyuni',    '086366667777', 'Pemandu wisata Sumatera dan danau vulkanik.'),
('Guntur Wibowo',    '087377778888', 'Spesialis trekking dan wisata petualangan.'),
('Hani Kusuma',      '088388889999', 'Pemandu wisata keluarga dan edukasi.'),
('Irfan Maulana',    '089399990000', 'Ahli wisata bahari Maluku dan Banda.'),
('Juwita Sari',      '081400001111', 'Pemandu foto dan wisata instagrammable.'),
('Kurniawan Adi',    '082411112222', 'Spesialis ekowisata dan konservasi.'),
('Laras Wening',     '083422223333', 'Pemandu wisata Kalimantan dan orangutan.'),
('Mulyadi',          '084433334444', 'Guide senior dengan pengalaman 15 tahun.'),
('Nina Oktavia',     '085444445555', 'Pemandu bilingual Indonesia-Inggris.'),
('Oki Firmansyah',   '086455556666', 'Spesialis wisata bahari NTB dan NTT.'),
('Putri Ayu',        '087466667777', 'Guide wisata kuliner dan budaya lokal.'),
('Rizal Fahmi',      '088477778888', 'Pemandu wisata Papua dan lembah Baliem.'),
('Sinta Dewi',       '089488889999', 'Spesialis wisata kawah dan vulkanologi.'),
('Tri Handoko',      '081499990000', 'Pemandu safari dan taman nasional.'),
('Umar Bakri',       '082500001111', 'Guide wisata bahari Aceh dan Sabang.');

INSERT INTO paket_wisata (nama_paket, durasi, total_harga, fasilitas, id_transportasi, id_hotel, id_pemandu) VALUES
('Paket Liburan Bali',        '3 Hari 2 Malam',  2500000,  'Hotel, transportasi, tiket wisata, makan',		2,   1,  1),
('Paket Bali Premium',        '5 Hari 4 Malam',  5500000,  'Resort, transportasi, tiket wisata, makan, spa',  	2,  12,  1),
('Paket Wisata Borobudur',    '2 Hari 1 Malam',  1500000,  'Hotel, tiket masuk, transportasi',                	3,   2,  3),
('Paket Sunrise Bromo',       '2 Hari 1 Malam',  1800000,  'Jeep, penginapan, tiket masuk',                   	4,   3,  2),
('Paket Jogja Hemat',         '3 Hari 2 Malam',  1700000,  'Hotel, transportasi, makan',                    	1,   4,  3),
('Paket Jogja Lengkap',       '4 Hari 3 Malam',  3200000,  'Hotel bintang 3, transportasi, makan, guide',     	1,  13,  13),
('Paket Eksplor Raja Ampat',  '4 Hari 3 Malam',  6500000,  'Resort, kapal, snorkeling, makan',          	5,   5,  5),
('Paket Danau Toba',          '3 Hari 2 Malam',  2200000,  'Hotel, transportasi, tiket wisata, makan',     	2,   6,  6),
('Paket Komodo Adventure',    '4 Hari 3 Malam',  4800000,  'Hotel, kapal, tiket taman nasional, makan',    	15,   7, 15),
('Paket Baluran Safari',      '2 Hari 1 Malam',  1600000,  'Penginapan, jeep safari, tiket masuk',   		16,   8, 19),
('Paket Lombok Pantai Pink',  '3 Hari 2 Malam',  2800000,  'Hotel, kapal, snorkeling, makan',         		5,   9, 15),
('Paket Dieng Eksplorasi',    '2 Hari 1 Malam',  1400000,  'Homestay, transportasi, tiket wisata',     		3,  10,  3),
('Paket Tana Toraja Cultural','4 Hari 3 Malam',  3900000,  'Hotel, transportasi, guide, makan',           	7,  11,  4),
('Paket Banda Bahari',        '3 Hari 2 Malam',  3500000,  'Penginapan, kapal, snorkeling, makan',       	11,  14,  9),
('Paket Pantai Ora',          '3 Hari 2 Malam',  3100000,  'Cottage, kapal, snorkeling, makan',             	5,  15,  9),
('Paket Bukit Lawang Jungle', '2 Hari 1 Malam',  1900000,  'Homestay, guide, trekking, makan',               	10,  16, 12),
('Paket Gili Trawangan',      '3 Hari 2 Malam',  2600000,  'Hotel, kapal, snorkeling, makan',                	5,  17,  1),
('Paket Bromo & Toraja',      '5 Hari 4 Malam',  4200000,  'Hotel, jeep, transportasi, makan, guide',       	4,   3,  2),
('Paket Bali & Lombok',       '5 Hari 4 Malam',  4900000,  'Hotel, kapal, tiket wisata, makan',        		5,   9,  1),
('Paket Jogja & Borobudur',   '4 Hari 3 Malam',  2900000,  'Hotel, transportasi, tiket masuk, makan',        	1,   4,  3);

INSERT INTO paket_destinasi (id_paket, id_destinasi) VALUES
(1,  1),   
(2,  1),   
(3,  2),   
(4,  3),   
(5,  4),   
(6,  4),   
(6,  2),   
(7,  5),   
(8,  6),   
(9,  7),   
(10, 8),   
(11, 9),   
(11, 15),  
(12, 10),  
(13, 11),  
(14, 12),  
(15, 13),  
(18, 3),   
(18, 11),  
(19, 1),   
(20, 2);  

INSERT INTO pemesanan (id_pelanggan, id_paket, tanggal_pemesanan, tanggal_berangkat, jumlah_peserta) VALUES
(1,  1,  '2026-05-01', '2026-06-10',  4),
(2,  3,  '2026-05-03', '2026-06-15',  2),
(3,  4,  '2026-05-05', '2026-06-20',  3),
(4,  5,  '2026-05-07', '2026-07-01', 10),
(5,  7,  '2026-05-09', '2026-07-10',  5),
(1,  2,  '2026-05-10', '2026-06-25',  2),
(7,  3,  '2026-05-11', '2026-07-05',  6),
(3,  4,  '2026-05-12', '2026-07-15',  2),
(9,  5,  '2026-05-13', '2026-07-20',  4),
(10, 7,  '2026-05-14', '2026-08-01',  3),
(11, 2,  '2026-05-15', '2026-08-05',  5),
(4,  9,  '2026-05-16', '2026-08-10',  2),
(13, 6,  '2026-05-17', '2026-08-15',  3),
(5,  11, '2026-05-18', '2026-08-20',  4),
(2,  8,  '2026-05-19', '2026-09-01',  4),
(6,  13, '2026-05-20', '2026-09-05',  5),
(8,  14, '2026-05-21', '2026-09-10',  6),
(12, 20, '2026-05-22', '2026-09-15',  3),
(14, 18, '2026-05-23', '2026-09-20',  4),
(15, 19, '2026-05-24', '2026-10-01',  2);

INSERT INTO pembayaran (id_pemesanan, tanggal_pembayaran, metode_pembayaran, jumlah_bayar, status_pembayaran) VALUES
(1,  '2026-05-02', 'Transfer Bank', 10000000, 'Lunas'),
(2,  '2026-05-04', 'E-Wallet',       1500000, 'Belum Lunas'),
(3,  '2026-05-06', 'Transfer Bank',  5400000, 'Lunas'),
(4,  '2026-05-08', 'Kartu Kredit',  17000000, 'Lunas'),
(5,  '2026-05-10', 'Transfer Bank', 10000000, 'Belum Lunas'),
(6,  '2026-05-11', 'E-Wallet',       2500000, 'Dibatalkan'),
(7,  '2026-05-12', 'Transfer Bank',  9000000, 'Lunas'),
(8,  '2026-05-13', 'Kartu Kredit',   3600000, 'Lunas'),
(9,  '2026-05-14', 'E-Wallet',       3400000, 'Belum Lunas'),
(10, '2026-05-15', 'Transfer Bank', 19500000, 'Lunas'),
(11, '2026-05-16', 'Kartu Kredit',  27500000, 'Lunas'),
(12, '2026-05-17', 'E-Wallet',       4800000, 'Lunas'),
(13, '2026-05-18', 'Transfer Bank',  5100000, 'Lunas'),
(14, '2026-05-19', 'Kartu Kredit',   5600000, 'Belum Lunas'),
(15, '2026-05-20', 'Transfer Bank',  8800000, 'Lunas'),
(16, '2026-05-21', 'E-Wallet',       7800000, 'Dibatalkan'),
(17, '2026-05-22', 'Kartu Kredit',  10500000, 'Lunas'),
(18, '2026-05-23', 'Transfer Bank',  2900000, 'Belum Lunas'),
(19, '2026-05-24', 'E-Wallet',       4200000, 'Lunas'),
(20, '2026-05-25', 'Kartu Kredit',   9800000, 'Lunas');