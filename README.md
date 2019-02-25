# SoalShift_modul1_E08

#### Bagas Yanuar Sudrajad - 05111740000074 <br> Octavianus Giovanni Yaunatan - 05111740000113

<ol>
  <li>Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh  file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
  <br>Hint: Base64, Hexdump
  <br><br>Jawaban:
	  
```bash
#!/bin/bash

unzip /home/siung2/Documents/soalshift1/1/nature.zip -d /home/siung2/Documents/soalshift1/1/
a=0
for photo in /home/siung2/Documents/soalshift1/1/nature/*.jpg
do
	`base64 -d $photo > /home/siung2/Documents/soalshift1/1/nature/$a.jpg`
	`xxd -r /home/siung2/Documents/soalshift1/1/nature/$a.jpg > /home/siung2/Documents/soalshift1/1/nature/hasil$a.jpg`
	`rm /home/siung2/Documents/soalshift1/1/nature/$a.jpg $photo`
	a=$(($a+1))
done
```

Source Code: <a href="/Jawaban/1/soal1.sh">soal1.sh</a>

File nature.zip awalnya diextract dengan command unzip. Kemudian untuk setiap file di dalam folder nature, didecode dengan menggunakan base64, menyimpan hasil decode file tersebut ke folder yang sama (nature.zip), lalu menghapus file yang terenkripsi sebelumnya. Perintah ini dijalankan di crontab dengan syntax `14 14 14 2 5 /bin/bash /bin/bash /home/siung2/Documents/soalshift1/1/soal1.sh`, artinya setiap jam 14:14 pada tanggal 14 bulan Februari atau hari Jumat di bulan Februari, akan dijalankan script soal1.sh
  </li>
  
  <li>Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
  Laporan yang diminta berupa:
  <ol>
    <li>Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.</li>
    <li>Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin i.</li>
    <li>Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin ii.</li>
  </ol>
  <br>Jawaban:

```bash
#!/bin/bash
`cat "$1"|awk 'BEGIN{FS=","}{if($7==2012)arr[$1]+=$10}END{for(a in arr)print arr[a]","a}'| sort -rg | awk 'NR==1'|awk 'BEGIN{FS=","}{print $2}' > soal2.txt` < "$1"

ans=`cat soal2.txt`

`cat WA_Sales_Products_2012-14.csv| awk -v var="$ans" 'FS=","{if($7==2012 && $1==var)print $1","$7","$4","$10}' | awk 'FS=","{arr[$3]+=$4} END {for(a in arr) print arr[a]","a}' | sort -rg |awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' > soal2b.txt`

ans1=`cat soal2b.txt | awk NR==1`
ans2=`cat soal2b.txt | awk NR==2`
ans3=`cat soal2b.txt | awk NR==3`

`cat WA_Sales_Products_2012-14.csv| awk -v var="$ans" -v var1="$ans1" -v var2="$ans2" -v var3="$ans3" 'BEGIN {FS=","}{if($7==2012 && $1==var && ($4 == var1|| $4==var2 || $4 ==var3))print $1","$7","$6","$10}' |  awk 'FS=","{arr[$3]+=$4} END {for(a in arr) print arr[a]","a}' | sort -rg|awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' > soal2c.txt`
```

Source Code: <a href="/Jawaban/2/soal2.sh">soal2.sh</a>

Pada soal (i), script ini dijalankan untuk mencari semua produk yang dibuat pada tahun 2012 (kolom ke-7, kolom dipisahkan dengan tanda "," dan dibaca mulai dari kiri), total penjualannya (di kolom-10) dikelompokkan berdasarkan nama negara (kolom ke-1), lalu diurutkan berdasarkan jumlah penjualan dimulai dari yang paling banyak. Hasil tadi kemudian dicari lagi yang memiliki penjualan terbanyak, yaitu United States/Amerika Serikat (karena sudah diurutkan, maka hanya dicari baris teratas NR==1) lalu diprint nama negara tersebut dan jumlah penjualannya dan disimpan di `soal2.txt`.
<br>Pada soal (ii), script awk dijalankan dengan memfilter produk-produk yang dijual pada tahun 2012 oleh negara Amerika Serikat. Hasilnya berupa tabel dengan kolom Nama Negara (kolom ke-1), Tahun (kolom ke-7), Product Line (kolom ke-4), dan jumlah penjualannya (kolom ke-10), lalu diurutkan berdasarkan jumlah penjualan dari yang paling banyak. Kemudian dicari tiga Product Line teratas (dengan penjualan terbanyak) lalu disimpan di `soal2b.txt`.
<br>Pada soal (iii), script awk dijalankan untuk memfilter produk-produk dengan krieria yang ada pada soal (ii). Dihasilkan tabel baru dengan kolom nama negara, tahun, nama produk (kolom ke-6), dan jumlah penjualan, lalu diurukan berdasarkan jumlah penjualan mulai dari yang terbesar. Lalu dicari tiga produk terbanyak (tiga baris teratas dari tabel baru) lalu disimpan di `soal2c.txt`.
  </li>
  
  <li>Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:
  <ol>
    <li>Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt</li>
    <li>Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.</li>
    <li>Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.</li>
    <li>Password yang dihasilkan tidak boleh sama.</li>
  </ol>
  
  Jawaban:
	
```bash
#!/bin/bash
s1="password"
s2=1
s3=".txt"

while [ true ]
do

p="$s1$s2$s3"
if [ ! -e "$p" ]
then
	break
fi
s2=$((s2+1))

done

function generate(){

len=12
digits=({0..9})
low=({a..z})
up=({A..Z})
arr=(${digits[*]} ${low[*]} ${up[*]})
arrLen=${#arr[*]}
password=""

d=0
l=0
u=0

id=-1
il=-1
iu=-1

for i in `seq 1 $len`
do
	index=$(($RANDOM%$arrLen))
	char=${arr[$index]}
	password=${password}${char}

	if [ $index -le 9 ]
	then
		d=$((d+1))
		if [ $id -eq -1 ]
		then
			id=$i
		fi
	elif [ $index -le 35 ]
	then
		l=$((l+1))
		if [ $il -eq -1 ]
		then
			il=$i
		fi
	else
		u=$((u+1))
		if [ $iu -eq -1 ]
		then
			iu=$i
		fi
	fi
done

if [ $id -eq -1 ]
then
	index=$(($RANDOM%10))
	char=${arr[$index]}
	if [ $l -gt 1 ]
	then
	password[$((il-1))]=$char
	il=$((il+1))
	l=$((l-1))
	else
	password[$((iu-1))]=$char
	iu=$((iu+1))
	u=$((u-1))
	fi
fi

if [ $il -eq -1 ]
then
	index=$(($RANDOM%26))
	char=${arr[$index+10]}
	if [ $d -gt 1 ]
	then
	password[$((id-1))]=$char
        id=$((id+1))
        d=$((d-1))
        else
        password[$((iu-1))]=$char
        iu=$((iu+1))
        u=$((u-1))
        fi
fi

if [ $iu -eq -1 ]
then
	index=$(($RANDOM%26))
	char=${arr[$index+36]}
	if [ $l -gt 1 ]
	then
	password[$((il-1))]=$char
        il=$((il+1))
        l=$((l-1))
        else
        password[$((id-1))]=$char
        id=$((id+1))
        d=$((d-1))
        fi
fi

echo "$password"
}

hasil=generate
`$hasil >> $p`
```

Source Code: <a href="/Jawaban/3/soal3.sh">soal3.sh</a>

Script ini awalnya akan membuat file `password1.txt` yang berisi password random 12 karakter yang mengandung angka, huruf kecil dan huruf besar. Apabila script ini dijalankan lagi, maka script ini akan mencari `password1.txt`, karena sudah ada file dengan nama tersebut, maka perintah akan membuat file `password2.txt`, dan begitu seterusnya. Apabila suatu file dihapus, maka saat script ini dijalankan, perintah ini akan membuat file baru dengan nama file yang sebelumnya bukan dengan nama file setelah file terbaru, agar urutan nama file tidak ada yang terlewatkan meski filenya dihapus.
  </li>
  
  <li>Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:
  <ol>
    <li>Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.</li>
    <li>Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.</li>
    <li>Setelah huruf z akan kembali ke huruf a</li>
    <li>Backup file syslog setiap jam.</li>
    <li>dan buatkan juga bash script untuk dekripsinya.</li>
  </ol>
  
  Jawaban:

```bash
#!/bin/bash
key=`date +"%H"`
temp1=( {a..z} )
cipher1=()
cipher1+=( ${temp1[@]:(-(26-$key))} )
cipher1+=( ${temp1[@]:0:$(($key))} )
temp2=( {A..Z} )
cipher2=()
cipher2+=( ${temp2[@]:(-(26-$key))} )
cipher2+=( ${temp2[@]:0:$(($key))} )
temp1+=( ${temp2[@]} )
cipher1+=( ${cipher2[@]} )
NOW=$(date +"%H:%M %d-%m-%Y") < /var/log/syslog > "$NOW" tr "${temp1[*]}" "${cipher1[*]}"


#!/bin/bash
read NOW
len=${#NOW}
len=$((len-2))
NOW=${NOW:1:$len}
key=${NOW:0:2}
key=$(($key+0))

temp1=( {a..z} )
cipher1=()
cipher1+=( ${temp1[@]:(-(26-$key))} )
cipher1+=( ${temp1[@]:0:$(($key))} )
temp2=( {A..Z} )
cipher2=()
cipher2+=( ${temp2[@]:(-(26-$key))} )
cipher2+=( ${temp2[@]:0:$(($key))} )
temp1+=( ${temp2[@]} )
cipher1+=( ${cipher2[@]} )
tr "${cipher1[*]}" "${temp1[*]}" <"$NOW"> "$NOW".decrypted
```

Source Code: <a href="/Jawaban/4/soal4.sh">soal4.sh</a> dan <a href="/Jawaban/4/soal4e.sh">soal4e.sh</a>

Script ini dijalankan di crontab dengan syntax `0 * * * * /bin/bash /bin/bash /home/siung2/Documents/soalshift1/4/soal4.sh`, artinya script ini akan dijalankan setiap jam. Script untuk poin (i) sampai (iv) dijalankan dengan mengambil variabel dari jam, kemudian digunakan untuk membuat dua array berisi cipher code, satu untuk huruf kecil dan satu untuk huruf besar, yang digeser maju sesuai dengan jam pada saat itu, misalnya apabila jam 10 maka huruf-huruf pada array cipher akan digeser 10 ke kiri, dan sisa huruf lainnya akan ditaruh di array belakang. Dengan berdasarkan pada array cipher itu, file syslog kemudian dibackup dengan menyesuaikan urutan abjad pada file dengan urutan abjad pada array cipher. Lalu hasilnya disimpan ke file dengan format `jam:menit tanggal-bulan-tahun` mengikuti waktu saat itu.<br>
Untuk script pada poin (v), file yang sebelumnya telah dibackup akan dibuatkan array cipher untuk decrypt, dengan menggeser huruf mundur sebanyak Jam yang terdapat pada nama file, sisa huruf kemudian ditaruh di array bagian depan. Dengan berdasarkan array tersebut, file backup tadi kemudian didecode dengan menyesuaikan posisi abjad dengan abjad di array cipher, hingga didapatkan file semula.
  </li>
  
  <li>Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
  <ol>
    <li>Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.</li>
    <li>Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.</li>
    <li>Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.</li>
    <li>Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.</li>
  </ol>
	
  Jawaban:
  
  ```bash
  #!/bin/bash
  `awk '(!(/[sS][uU][dD][oO]/) && (/[cC][rR][oO][nN]/) && (NF<13))' /var/log/syslog >> modul1`
  ```
  
  Source Code: <a href="/Jawaban/5/soal5.sh">soal5.sh</a>
  
  Jalankan perintah awk untuk mencari record dalam syslog yang tidak mengandung string "sudo" tapi mengandung string "cron" dengan cara `(/[cC][rR][oO][nN]/)`. Maksud dari potongan kode tersebut adalah dicari string dengan urutan "cron", dan bersifat tidak case-sensitive. Kemudian hasil tersebut ditambah dengan kondisi jumlah fieldnya kurang dari 13 (NF<13). Script ini kemudian dijalankan di crontab dengan syntax `2-30/6 * * * * /bin/bash /bin/bash /home/siung2/Documents/soalshift1/5/soal5.sh`, maksudnya setiap 6 menit dari menit ke-2 sampai 30, script ini akan dijalankan (menit ke-2, 8, 14, dst.), lalu akan disimpan hasilnya di modul1.
  </li>
</ol>

<a href="/Jawaban/Perintah crontab.txt">Perintah crontab untuk soal 1, 4, dan 5 ada di sini<a>
