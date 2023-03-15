#install.packages('RODBC')

# Load RODBC package
library(RODBC)

# Connect to Access db
channel <- odbcConnectAccess("C:/Databases/NBA2010.mdb")

# Get data
data <- sqlQuery( channel , paste ("select *
                                   from NbaGameTime")
)
thegametime <- data[1,"GameTime"]
thegametime <- '20191022'

setwd("C:/ColdFusion2018/cfusion/wwwroot/NBACode/")

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
  
  #fn <- "c:\\ColdFusion9\\wwwroot\NBACode\"
  #fn2 <- paste(fn,fav,sep="")
  
  filename = paste(fav,und,theday,sep="")
  p1 = paste("https://www.basketball-reference.com/boxscores/", theday, sep="")  
  
  p1 = 'https://www.basketball-reference.com/boxscores/?month=10&day=22&year=2019'
  
  
  
  if (ha == 'H'){
    url = paste(p1, fav,'.html', sep="")  
  }
  if (ha == 'A'){
    url = paste(p1, und,'.html', sep="")  
  }
  
  url = 'https://www.basketball-reference.com/boxscores/?month=10&day=22&year=2019'
  
  url
  
  thepage = readLines(url)
  
  tmtotal = grep('Team Totals',thepage)
  tmtotal
  x = thepage[tmtotal[1]:tmtotal[2]]
  y = thepage[tmtotal[3]:tmtotal[4]]
  write(x, file = filename,
        ncolumns = if(is.character(x)) 1 else 5,
        append = TRUE, sep = " ")
  
  write(y, file = filename,
        ncolumns = if(is.character(x)) 1 else 5,
        append = TRUE, sep = " ")
  
  
  
}









