# Load RODBC package
library(RODBC)

filename = paste('NBAPBP','.txt',sep="")


# Connect to Access db
channel <- odbcConnectAccess("C:/Databases/NBA2010.mdb")

# Get data
data <- sqlQuery( channel , paste ("select *
                                   from NbaGameTime")
)
thegametime <- data[1,"GameTime"]


setwd("C:/ColdFusion9/wwwroot/NBACode/Data")

thestr = paste ("select * from nbaschedule where gametime ='",thegametime,sep="")
thestr = paste (thestr,"'",sep="")


# Get data
data <- sqlQuery( channel , thestr 
)
#theday = '201711110'
theday = paste(thegametime,'0',sep="")


for (row in 1:nrow(data)) {
  fav <- data[row, "fav"]
  und  <- data[row, "und"]
  ha  <- data[row, "ha"]
  
  
  if(ha == 'H') {
    
    if (fav == 'PHX') {
      
      fav = 'PHO'
    }
    
    if (und == 'PHX') {
      
      und = 'PHO'
    }
    
    if (fav == 'CHA') {
      
      fav = 'CHO'
    }
    
    if (und == 'CHA') {
      
      und = 'CHO'
    }
    
    
    if (fav == 'BKN') {
      
      fav = 'BRK'
    }
    
    if (und == 'BKN') {
      
      und = 'BRK'
    }
    
    
    
  }
  
  
  
  if(ha == 'A') {
    
    
    if (fav == 'PHX') {
      
      fav = 'PHO'
    }
    
    if (und == 'PHX') {
      
      und = 'PHO'
    }
    
    if (fav == 'CHA') {
      
      fav = 'CHO'
    }
    
    if (und == 'CHA') {
      
      und = 'CHO'
    }
    
    
    if (fav == 'BKN') {
      
      fav = 'BRK'
    }
    
    if (und == 'BKN') {
      
      und = 'BRK'
    }
    
  }
  
 
  
  filename = paste(fav,und,theday,sep="")
  p1 = paste("https://www.basketball-reference.com/boxscores/pbp/",theday, sep="")

  if (ha == 'H'){
    url = paste(p1, fav,'.html', sep="")  
  }
  if (ha == 'A'){
    url = paste(p1, und,'.html', sep="")  
  }
  url
  
  thepage = readLines(url)

start = grep('Start of 1st quarter',thepage)
end   = grep('<div id="bottom_nav"',thepage)


x = thepage[start:end]

write(x, file = filename,
      ncolumns = if(is.character(x)) 1 else 5,
      append = TRUE, sep = " ")

}