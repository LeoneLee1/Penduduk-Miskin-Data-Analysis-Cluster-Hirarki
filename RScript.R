#import data dari excel ke R studio
table1=read.delim("clipboard")
table1
#melihat deskripsi data
summary(table1)
#melihat struktur data
str(table1)
#melakukan transformasi
# 1. scale 2. min max
tablefix=scale(table1[,2:3])
#melihat table fix
View(tablefix)
#menghitung jarak
jarak=dist(tablefix)
#melihat hasil perhitungan jarak
jarak
#melakukan proses clustering menggunakan metode hirarki
hirarkisingle=hclust(jarak,method = "single")
hirarkisingle
#melihat dendogram
plot(hirarkisingle,table1$Provinsi)
#membentuk hasil menyimpulkan membuat dua cluster
rect.hclust(hirarkisingle,2)
#melihat deskripsi hirarki dalam bentuk tabel
anggotasingle3=data.frame(id=table1$Provinsi,cutree(hirarkisingle,k=3))
anggotasingle3
View(anggotasingle3)
#instal dplyr
install.packages("dplyr")
library(dplyr)
#melihat deskripsi data setelah berhasil di cluster
table1[,1:3]%>%
  mutate(cluster=anggotasingle3[,2])%>%
group_by(cluster)%>%
  summarise_all("mean")
