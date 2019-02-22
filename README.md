# SoalShift_modul1_E08

#### Bagas Yanuar - 05111740000074 <br> Octavianus Giovanni Yaunatan - 05111740000113

<ol>
  <li>Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh  file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
  <br>Hint: Base64, Hexdump
  <br><br>Jawaban:<br>File nature.zip awalnya diextract dengan command unzip. Kemudian untuk setiap file di dalam folder nature, didecode dengan menggunakan base64, menyimpan hasil decode file tersebut ke folder yang sama (nature.zip), lalu menghapus file yang terenkripsi sebelumnya. <a href="/Jawaban/1/soal1.sh">Perintah ini</a> dijalankan di crontab dengan kode waktu "14 14 14 2 5", artinya setiap jam 14:14 pada tanggal 14 bulan Februari atau hari Jumat di bulan Februari, akan dijalankan perintah soal1.sh <br> Source Code: <a href="/Jawaban/1/soal1.sh">soal1.sh</a>
  </li>
  <br>  
  <li>Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
  Laporan yang diminta berupa:
  <ol>
    <li>Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.</li>
    <li>Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin i.</li>
    <li>Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin ii.</li>
  </ol>
  <br>Jawaban:<br>Pada soal (i), script ini dijalankan untuk mencari semua produk yang dibuat pada tahun 2012 (kolom ke-7, kolom dipisahkan dengan tanda "," dan dibaca mulai dari kiri), total penjualannya (di kolom-10) dikelompokkan berdasarkan nama negara (kolom ke-1), lalu diurutkan berdasarkan jumlah penjualan dimulai dari yang paling banyak. Hasil tadi kemudian dicari lagi yang memiliki penjualan terbanyak, yaitu United States/Amerika Serikat (karena sudah diurutkan, maka hanya dicari baris teratas NR==1) lalu diprint nama negara tersebut dan jumlah penjualannya dan disimpan di "soal2.txt".
<br>Pada soal (ii), script awk dijalankan dengan memfilter produk-produk yang dijual pada tahun 2012 oleh negara Amerika Serikat. Hasilnya berupa tabel dengan kolom Nama Negara (kolom ke-1), Tahun (kolom ke-7), Product Line (kolom ke-4), dan jumlah penjualannya (kolom ke-10), lalu diurutkan berdasarkan jumlah penjualan dari yang paling banyak. Kemudian dicari tiga Product Line teratas (dengan penjualan terbanyak) lalu disimpan di "soal2b.txt".
<br>Pada soal (iii), script awk dijalankan untuk memfilter produk-produk dengan krieria yang ada pada soal (ii). Dihasilkan tabel baru dengan kolom nama negara, tahun, nama produk (kolom ke-6), dan jumlah penjualan, lalu diurukan berdasarkan jumlah penjualan mulai dari yang terbesar. Lalu dicari tiga produk terbanyak (tiga baris teratas dari tabel baru) lalu disimpan di "soal2c.txt".
  <br> Source Code: <a href="/Jawaban/2/soal2.sh">soal2.sh</a>
  </li><br>
  <li>Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:
  <ol>
    <li>Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt</li>
    <li>Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.</li>
    <li>Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.</li>
    <li>Password yang dihasilkan tidak boleh sama.</li>
  </ol>
  <br>Jawaban:<br>Script ini awalnya akan membuat file "password1.txt" yang berisi password random 12 karakter yang mengandung angka, huruf kecil dan huruf besar. Apabila script ini dijalankan lagi, maka script ini akan mencari "password1.txt", karena sudah ada file dengan nama tersebut, maka perintah akan membuat file "password2.txt", dan begitu seterusnya. Apabila suatu file dihapus, maka saat script ini dijalankan, perintah ini akan membuat file baru dengan nama file yang sebelumnya bukan dengan nama file setelah file terbaru, agar urutan nama file tidak ada yang terlewatkan meski filenya dihapus.
  <br> Source Code: <a href="/Jawaban/3/soal3.sh">soal3.sh</a>
  </li><br>
  <li>Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:
  <ol>
    <li>Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.</li>
    <li>Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.</li>
    <li>Setelah huruf z akan kembali ke huruf a</li>
    <li>Backup file syslog setiap jam.</li>
    <li>dan buatkan juga bash script untuk dekripsinya.</li>
  </ol>
  <br>Jawaban:
  <br> Source Code: <a href="/Jawaban/4/soal4.sh">soal4.sh</a> dan <a href="/Jawaban/4/soal4e.sh">soal4e.sh</a>
  </li><br>
  <li>Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
  <ol>
    <li>Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.</li>
    <li>Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.</li>
    <li>Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.</li>
    <li>Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.</li>
  </ol>
  <br>Jawaban:<br>Jalankan perintah awk untuk mencari record dalam syslog yang tidak mengandung string "sudo" tapi mengandung string "cron" dengan cara (/[cC][rR][oO][nN]/). Maksud dari potongan kode tersebut adalah dicari string dengan urutan "cron", dan bersifat tidak case-sensitive. Kemudian hasil tersebut ditambah dengan kondisi jumlah fieldnya kurang dari 13 (NF<13). Perintah ini kemudian dijalankan di crontab dengan kode waktunya "2-30/6 * * * *", maksudnya setiap 6 menit dari menit ke-2 sampai 30 perintah ini akan dijalankan (menit ke-2, 8, 14, dst.), lalu akan disimpan hasilnya di modul1.
  <br> Source Code: <a href="/Jawaban/5/soal5.sh">soal5.sh</a>
  </li>
</ol>

<a href="/Jawaban/Perintah crontab.txt">Perintah crontab untuk soal tertentu ada di sini<a>
