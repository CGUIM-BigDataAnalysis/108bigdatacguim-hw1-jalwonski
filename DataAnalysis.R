library(jsonlite)
library(dplyr)
library(knitr)
library(readr)
x104educate <- read_csv("http://ipgod.nchc.org.tw/dataset/b6f36b72-0c4a-4b60-9254-1904e180ddb1/resource/98d5094d-7481-44b5-876a-715a496f922c/download/")
View(x104educate)


X107educate <- read_csv("C:/Users/alpachino/Downloads/4133da254dbcdba28a2097de48d8d606_csv/107educate.csv")
View(X107educate)

x104educate$大職業別<-NULL
x104educate$大職業別<-X107educate$大職業別
Sal104107<-inner_join(x104educate,X107educate,by=c("大職業別"))
View(Sal104107)
is.numeric(Sal104107$`大學-薪資.x`)
is.numeric(Sal104107$`大學-薪資.y`)
Sal104107$`大學-薪資.x`<-gsub("—|…","",Sal104107$`大學-薪資.x`)
Sal104107$`大學-薪資.y`<-gsub("—|…","",Sal104107$`大學-薪資.y`)
Sal104107$`大學-薪資.x`<-as.numeric(Sal104107$`大學-薪資.x`)
Sal104107$`大學-薪資.y`<-as.numeric(Sal104107$`大學-薪資.y`)
#1-1
Salary_up<-filter(Sal104107,`大學-薪資.x`<`大學-薪資.y`)
View(Salary_up) 
#1-2
Salary_up$`107年度大學畢業薪資 / 104年度大學畢業薪資`<-Salary_up$`大學-薪資.y`/ Salary_up$`大學-薪資.x`
Salary_up_top10<-head(Salary_up[order(Salary_up$`107年度大學畢業薪資 / 104年度大學畢業薪資`,decreasing = T),],10)
View(Salary_up_top10)  

#1-3
Salary_up_5percent<-filter(Salary_up,`107年度大學畢業薪資 / 104年度大學畢業薪資`>1.05)
View(Salary_up_5percent)  
Salary_up_5percent_kind<-table(sapply(strsplit(Salary_up_5percent$大職業別,"-"),"[",1))
View(Salary_up_5percent_kind)  
#2
#男
is.numeric(x104educate$`大學-女/男`)
x104educate$`大學-女/男`<-gsub("—|…","",x104educate$`大學-女/男`)
x104educate$`大學-女/男`<-as.numeric(x104educate$`大學-女/男`)
is.numeric(X107educate$`大學-女/男`)
X107educate$`大學-女/男`<-gsub("—|…","",X107educate$`大學-女/男`)
X107educate$`大學-女/男`<-as.numeric(X107educate$`大學-女/男`)
x104_male_higher<-filter(x104educate,`大學-女/男`<100)
View(x104_male_higher) 
x104_male_higher<-x104_male_higher[order(x104_male_higher$`大學-女/男`),]
x104_male_higher_top10<-head(x104_male_higher,10)
View(x104_male_higher_top10)

x107_male_higher<-filter(X107educate,`大學-女/男`<100)
View(x107_male_higher) 
x107_male_higher<-x107_male_higher[order(x107_male_higher$`大學-女/男`),]
x107_male_higher_top10<-head(x107_male_higher,10)
View(x107_male_higher_top10)

#女
x104_female_higher<-filter(x104educate,`大學-女/男`>100)
View(x104_female_higher) 
x104_female_higher<-x104_female_higher[order(x104_female_higher$`大學-女/男`),]
x104_female_higher_top10<-head(x104_female_higher,10)
View(x104_female_higher_top10)

x107_female_higher<-filter(X107educate,`大學-女/男`>100)
View(x107_female_higher) 
x107_female_higher<-x107_female_higher[order(x107_female_higher$`大學-女/男`),]
x107_female_higher_top10<-head(x107_female_higher,10)
View(x107_female_higher_top10)

#3
is.numeric(X107educate$`研究所-薪資`)
X107educate$`研究所-薪資`<-gsub("—|…","",X107educate$`研究所-薪資`)
X107educate$`研究所-薪資`<-as.numeric(X107educate$`研究所-薪資`)
is.numeric(X107educate$`大學-薪資`)
X107educate$`大學-薪資`<-gsub("—|…","",X107educate$`大學-薪資`)
X107educate$`大學-薪資`<-as.numeric(X107educate$`大學-薪資`)
X107educate$`研究所-薪資/大學-薪資`<-X107educate$`研究所-薪資`/X107educate$`大學-薪資`
x107_gra_higher<-filter(X107educate,`研究所-薪資/大學-薪資`>1)
View(x107_gra_higher)
x107_gra_higher_top10<-head(x107_gra_higher[order(x107_gra_higher$`研究所-薪資/大學-薪資`,decreasing = T),],10)
View(x107_gra_higher_top10)

#4
JobLike<-X107educate[grep("出版、影音製作、傳播及資通訊服務業",X107educate$大職業別),]
JobLike<-select(JobLike,大職業別,`大學-薪資`,`研究所-薪資`)
View(JobLike)
JobLike$"研究所薪資與大學薪資差"<-JobLike$`研究所-薪資`-JobLike$`大學-薪資`
View(JobLike)
