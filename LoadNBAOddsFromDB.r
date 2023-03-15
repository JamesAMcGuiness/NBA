#install.packages('devtools', repos="http://cran.rstudio.com/")
#require(devtools)
#install_version("tidyr", version = "3.0.1", repos = "http://cran.us.r-project.org")


if (!require("RODBC")) {
  
  #install.packages('rvest', repos="http://cran.rstudio.com/")
  #install.packages('stringr', repos="http://cran.rstudio.com/")
  #install.packages('tidyr', repos="http://cran.rstudio.com/")
  install.packages('RODBC', repos="http://cran.rstudio.com/")
  
  #library(rvest)
  #library(stringr)
  #library(tidyr)
  
  # Load RODBC package
  
  
}


#install.versions('tidyr', '3.0.1')



if (!require("stringr")) {
  install.packages('stringr', repos="http://cran.rstudio.com/")
  
  
  
}

if (!require("Hmisc")) {
  install.packages('Hmisc', repos="http://cran.rstudio.com/")
}


library(RODBC)
library(stringr)
library(rvest)
library(tidyr)

#library(Hmisc)

# Connect to Access db
channel <- odbcConnectAccess("C:/Databases/NBA2010.mdb")


# Get data
data <- sqlQuery( channel , paste ("select *
                                   from NbaGameTime")
)


# Get data



thegametime <- data[1,"GameTime"]

thestr = paste ("DELETE from nbaschedule where gametime ='",thegametime,sep="")
thestr = paste (thestr,"'",sep="")
data2 <- sqlQuery( channel , thestr )


#thegametime <- "20181101"
setwd("C:/ColdFusion9/wwwroot/NBACode/")


tmshort <- ""
nbatms <- ""

#Create an array of NBA team names
nbatms <- "Boston Celtics"
nbatms <- c(nbatms,"New York Knicks")
nbatms <- c(nbatms,"Brooklyn Nets")
nbatms <- c(nbatms,"Orlando Magic")
nbatms <- c(nbatms,"Chicago Bulls")
nbatms <- c(nbatms,"Cleveland Cavaliers")
nbatms <- c(nbatms,"Indiana Pacers")
nbatms <- c(nbatms,"Minnesota Timberwolves")
nbatms <- c(nbatms,"New Orleans Pelicans")
nbatms <- c(nbatms,"Portland Trail Blazers")
nbatms <- c(nbatms,"Utah Jazz")
nbatms <- c(nbatms,"Los Angeles Clippers")
nbatms <- c(nbatms,"Houston Rockets")
nbatms <- c(nbatms,"Los Angeles Lakers")
nbatms <- c(nbatms,"Golden State Warriors")
nbatms <- c(nbatms,"San Antonio Spurs")
nbatms <- c(nbatms,"Dallas Mavericks")
nbatms <- c(nbatms,"Washington Wizards")
nbatms <- c(nbatms,"Milwaukee Bucks")
nbatms <- c(nbatms,"Miami Heat")
nbatms <- c(nbatms,"Atlanta Hawks")
nbatms <- c(nbatms,"Oklahoma City Thunder")
nbatms <- c(nbatms,"Sacramento Kings")
nbatms <- c(nbatms,"Charlotte Hornets")
nbatms <- c(nbatms,"Memphis Grizzlies")
nbatms <- c(nbatms,"Toronto Raptors")
nbatms <- c(nbatms,"Detroit Pistons")
nbatms <- c(nbatms,"Phoenix Suns")
nbatms <- c(nbatms,"Philadelphia 76ers")
nbatms <- c(nbatms,"Denver Nuggets")

v_GAMETIME <- ""
v_Fav      <- ""
v_Und      <- ""
v_HA       <- ""
v_SPD      <- 0
v_ou       <- 0

#url <- 'http://127.0.0.1:8500/NBACode/NBAodds.htm'

url = "http://www.donbest.com/nba/odds/"

webpage <- html(url)

filename = "donbest.htm"

tbls_ls <- webpage %>%
  html_nodes("table") %>%
  html_table(fill = TRUE)

printct <- 1

for(j in 1:19) {
  
  # Always start at row 3
  gamect <- j + 2
  
  # Gives us game 1
  theteamsplaying <- tbls_ls[[1]][gamect,3]
  
  #Loop for 2 until the end of nbateams
  for(i in 1:length(nbatms)) {
    
    #Loop for all the NBA teams until we find a match for Home Team
    homepos = regexpr(nbatms[i], theteamsplaying)
    
    if (homepos > 1) {
      hometm  = substr(theteamsplaying,homepos,100)
    }  
  }
  
  
  #Loop for 2 until the end of nbateams
  for(k in 1:length(nbatms)) {
    
    #Loop for all the NBA teams until we find a match for Home Team
    if(nbatms[k] != hometm) {
      
      awaypos = regexpr(nbatms[k], theteamsplaying)
      
      if (awaypos > -1) {
        awaytm  = nbatms[k]
      }  
    }
    
  }
  
  openline        <- tbls_ls[[1]][gamect,2]
  currentline     <- tbls_ls[[1]][gamect,10]
  alllines        <- tbls_ls[[1]][gamect,8:21]
  thestr <- currentline
  
  checkthis = substr(thestr,1,3)
  
  if(checkthis > '100') {
    
    checksign = substr(thestr,6,6)
    
    
    if (checksign == '-') {
      
      fav <- hometm
      und <- awaytm  
      ha <- "H"
    }
    else {
      
      und <- hometm  
      fav <- awaytm
      ha <- "A"
      
    }
    
    spd <- substr(thestr,7,11)
    tot <- substr(thestr,1,5)
    
  } else {
    
    checksign = substr(thestr,1,1)
    periodfind = gregexpr("\\.", thestr)
    periodpos = periodfind[[1]][1]
    
    
    if (checksign == '-') {
      
      fav <- awaytm   
      und <-  hometm
      ha  <- "A"
    }
    else {
      
      und <- awaytm
      fav <- hometm
      ha <- "H"
      
    }
    
    spd <- substr(thestr,2,periodpos+1)
    tot <- substr(thestr,periodpos+2,10)   
    
    
  }
  
  v_GAMETIME <- c(v_GAMETIME,thegametime)
  tmshort <- fav
  fav <- chkTeams(tmshort)
  fav <- tmshort
  
  
  tmshort <- und
  und <- chkTeams(tmshort)
  und <- tmshort
  
  
  v_Fav <- c(v_Fav,fav)
  v_Und <- c(v_Und,und)
  v_HA  <- c(v_HA,ha)
  
  spd <- as.numeric(as.character(spd))
  v_SPD <- c(v_SPD,spd)
  
  tot <- as.numeric(as.character(tot))
  v_ou <- c(v_ou,tot)
  
  
  
  prtthis1 <- paste(printct ,sep="")
  
  #write 1
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  
  prtthis1 <- paste(printct ,sep="")
  
  #Write Gametime
  write(thegametime, file = filename,
        append = TRUE, sep = " ")
  
  #Line 2
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #write 2
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #Line3
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #write 3
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #write Fav
  write(fav, file = filename,
        append = TRUE, sep = " ")
  
  #Line 4
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #write 4
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #Line 5
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 5
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #Ha
  write(ha, file = filename,
        append = TRUE, sep = " ")
  
  #Line 6
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 6
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #Line 7
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 7
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #spd
  write(spd, file = filename,
        append = TRUE, sep = " ")
  
  
  #Line 8
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 8
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  
  
  
  #Line 9
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 9
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  
  #write Und
  write(und, file = filename,
        append = TRUE, sep = " ")
  
  
  #Line 10
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 10
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #Line 11
  printct <- printct + 1
  prtthis1 <- paste(printct ,sep="")
  
  #Write 11
  write(prtthis1, file = filename,
        append = TRUE, sep = " ")
  
  #tot
  write(tot, file = filename,
        append = TRUE, sep = " ")
  
  
  write("*****************************************************************************************", file = filename,
        append = TRUE, sep = " ")
  
  printct <- printct + 1
  
  #df[nrow(df) + 1,] = list("v1","v2")
  
  
}




df_Spreads <- data.frame(v_GAMETIME,v_Fav,v_HA,v_SPD,v_Und,v_ou)
#df_Spreads <- data.frame(v_Fav,v_HA,v_SPD,v_Und,v_ou)


sqlSave(channel, df_Spreads, tablename = "nbaschedule", append = TRUE, fast = F, rownames=FALSE)
#length(df_Spreads[2,])

inc <- function(x)
{
  eval.parent(substitute(x <- x + 1))
}

chkTeams <- function (tmshort)
{
  
  tm<- tmshort
  
  if(tm == 'Denver Nuggets')
  {
    eval.parent(substitute(tmshort <- 'DEN'))
  }
  
  
  if(tm == 'Philadelphia 76ers')
  {
    eval.parent(substitute(tmshort <- 'PHI'))
  }
  
  
  if(tm == 'Phoenix Suns')
  {
    eval.parent(substitute(tmshort <- 'PHX'))
  }
  
  
  if(tm == 'Detroit Pistons')
  {
    eval.parent(substitute(tmshort <- 'DET'))
  }
  
  
  if(tm == 'Toronto Raptors')
  {
    eval.parent(substitute(tmshort <- 'TOR'))
  }
  
  
  if(tm == 'Memphis Grizzlies')
  {
    eval.parent(substitute(tmshort <- 'MEM'))
  }
  
  
  
  if(tm == 'Charlotte Hornets')
  {
    eval.parent(substitute(tmshort <- 'CHA'))
  }
  
  
  if(tm == 'Sacramento Kings')
  {
    eval.parent(substitute(tmshort <- 'SAC'))
  }
  
  
  
  if(tm == 'Oklahoma City Thunder')
  {
    eval.parent(substitute(tmshort <- 'OKC'))
  }
  
  
  
  if(tm == 'Atlanta Hawks')
  {
    eval.parent(substitute(tmshort <- 'ATL'))
  }
  
  
  if(tm == 'Miami Heat')
  {
    eval.parent(substitute(tmshort <- 'MIA'))
  }
  
  
  
  if(tm == 'Milwaukee Bucks')
  {
    eval.parent(substitute(tmshort <- 'MIL'))
  }
  
  
  if(tm == 'Washington Wizards')
  {
    eval.parent(substitute(tmshort <- 'WAS'))
  }
  
  
  
  if(tm == 'San Antonio Spurs')
  {
    eval.parent(substitute(tmshort <- 'SAS'))
  }
  
  
  if(tm == 'Dallas Mavericks')
  {
    eval.parent(substitute(tmshort <- 'DAL'))
  }
  
  
  
  if(tm == 'Golden State Warriors')
  {
    eval.parent(substitute(tmshort <- 'GSW'))
  }
  
  
  
  if(tm == 'Boston Celtics')
  {
    eval.parent(substitute(tmshort <- 'BOS'))
  }
  
  if(tm == 'New York Knicks')
  {
    eval.parent(substitute(tmshort <- 'NYK'))
  }
  
  if(tm == 'Brooklyn Nets')
  {
    eval.parent(substitute(tmshort <- 'BKN'))
  }
  
  if(tm == 'Orlando Magic')
  {
    eval.parent(substitute(tmshort <- 'ORL'))
  }
  
  if(tm == 'Chicago Bulls')
  {
    eval.parent(substitute(tmshort <- 'CHI'))
  }
  
  if(tm == 'Cleveland Cavaliers')
  {
    eval.parent(substitute(tmshort <- 'CLE'))
  }
  
  if(tm == 'Indiana Pacers')
  {
    eval.parent(substitute(tmshort <- 'IND'))
  }
  
  if(tm == 'Minnesota Timberwolves')
  {
    eval.parent(substitute(tmshort <- 'MIN'))
  }
  
  
  if(tm == 'New Orleans Pelicans')
  {
    eval.parent(substitute(tmshort <- 'NOP'))
  }
  
  
  if(tm == 'Portland Trail Blazers')
  {
    eval.parent(substitute(tmshort <- 'POR'))
  }
  
  if(tm == 'Utah Jazz')
  {
    eval.parent(substitute(tmshort <- 'UTA'))
  }    
  
  if(tm == 'Utah Jazz')
  {
    eval.parent(substitute(tmshort <- 'UTA'))
  }    
  
  
  if(tm == 'Los Angeles Clippers')
  {
    eval.parent(substitute(tmshort <- 'LAC'))
  }    
  
  
  if(tm == 'Houston Rockets')
  {
    eval.parent(substitute(tmshort <- 'HOU'))
  }    
  
  
  if(tm == 'Los Angeles Lakers')
  {
    eval.parent(substitute(tmshort <- 'LAL'))
  }    
  
  
  
}




# team playing tbls_ls[[1]][3,3]
# spreads tbls_ls[[1]][3,10]
