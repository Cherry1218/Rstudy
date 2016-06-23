install.packages("XML")
install.packages("stringr")
library(stringr)
library(XML)
getwd()
setwd("/Users/ysj/R/Data")

datasets <- data.frame()

weather <- function(address='北京',startyear=2015,endyear=2016,startmonth=1,endmonth=12){
  for(j in startyear:endyear){
    for(i in startmonth:endmonth){
      url <- paste0('http://www.aqistudy.cn/historydata/daydata.php?city=',address,'&month=',j,'-',str_pad(i,2,side = 'left',pad='0'))
      url <- htmlParse(url, encoding="UTF-8") #解析文件，需指定encoding为"UTF-8"，否则乱码
      tables <- readHTMLTable(url)
      table <- tables[[1]] #网页中只有一张表，第一张即是
      datasets <- rbind(datasets,table)
    }
  }
  write.csv(datasets,file=paste0(address,startyear,'-',endyear,'.csv'))
}

weather(address='北京',startyear=2015,endyear=2016)
weather(address='上海',startyear=2015,endyear=2016)
weather(address='天津',startyear=2015,endyear=2016)
weather(address='重庆',startyear=2015,endyear=2016)
weather(address='杭州',startyear=2015,endyear=2016)
weather(address='哈尔滨',startyear=2015,endyear=2016)
weather(address='太原',startyear=2015,endyear=2016)
weather(address='西安',startyear=2015,endyear=2016)
weather(address='济南',startyear=2015,endyear=2016)
weather(address='乌鲁木齐',startyear=2015,endyear=2016)
weather(address='拉萨',startyear=2015,endyear=2016)
weather(address='西宁',startyear=2015,endyear=2016)
weather(address='兰州',startyear=2015,endyear=2016)
weather(address='银川',startyear=2015,endyear=2016)
weather(address='郑州',startyear=2015,endyear=2016)
weather(address='南京',startyear=2015,endyear=2016)
weather(address='武汉',startyear=2015,endyear=2016)
weather(address='合肥',startyear=2015,endyear=2016)
weather(address='福州',startyear=2015,endyear=2016)
weather(address='南昌',startyear=2015,endyear=2016)
weather(address='长沙',startyear=2015,endyear=2016)
weather(address='贵阳',startyear=2015,endyear=2016)
weather(address='成都',startyear=2015,endyear=2016)
weather(address='广州',startyear=2015,endyear=2016)
weather(address='昆明',startyear=2015,endyear=2016)
weather(address='南宁',startyear=2015,endyear=2016)
weather(address='深圳',startyear=2015,endyear=2016)

pm2 = data.frame()
pm = function(address="北京"){
  data=read.csv(file=paste0(address,2015,'-',2016,'.csv'))
  head(data[,-1])
  data = cbind("地区"=rep("北京",nrow(data)),data[,-1])
}


pm2 = data.frame()
address= c('北京','上海','天津','重庆','杭州','哈尔滨','太原','西安'
           ,'济南','乌鲁木齐','拉萨','西宁','兰州','银川','郑州','南京',
           '武汉','合肥','福州','南昌','长沙','贵阳','成都',
           '广州','昆明','南宁','深圳')
for(i in address){
  data=read.csv(file=paste0(i,2015,'-',2016,'.csv'))
  data = cbind("地区"=rep(i,nrow(data)),data[,-1])
  pm2 = rbind(pm2,data)
}
nrow(pm2)
class(pm2)
write.csv(pm2,file = "全国pm2015-2016.csv")

channel <- dbConnect(MySQL(), dbname="mysql", username="root", password="1218jin") 
dbListTables(channel)
dbWriteTable(channel,name="pm",value=datasets)
dbDisconnect(channel)


