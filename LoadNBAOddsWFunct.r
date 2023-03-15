    
    library(RODBC)
    library(stringr)
    library(rvest)
    library(tidyr)
    library(Hmisc)
    
    # Connect to Access db
    #channel <- odbcConnectAccess("C:/Databases/NBA2010.mdb")
    channel <- odbcConnectAccess2007("C:/Databases/NBA2010.mdb")
    
    #subset(sqlTables(channel),TABLE_TYPE== "TABLE")
    data <- sqlFetch( channel , "NbaGameTime")
    
    
    # Get data
    #data <- sqlQuery( channel , paste ("select *
    #                                   from NbaGameTime")
    
    #data <- sqlFetch( channel , paste ("select *
    #                                   from NbaGameTime")
    
    
    thegametime <- data[1,"GameTime"]
    #thegametime <- "20181114"
    
    
    thestr = paste ("Delete from nbaschedule where gametime ='",thegametime,sep="")
    data <- sqlQuery( channel , thestr 
    )
    
    
    
    
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
    
    webpage <- read_html(url)
    
    filename = "NBAOdds.txt"
    Debugfile = "Debug.txt"
    
    tbls_ls <- webpage %>%
      html_nodes("table") %>%
      html_table(fill = TRUE)
    
    
    for(j in 1:19) {
      
      # Always start at row 3
      gamect <- j + 2
      
      # Gives us game 1
      theteamsplaying <- tbls_ls[[1]][gamect,3]
      
      write("theteamsplaying", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(theteamsplaying, file = Debugfile,
            append = TRUE, sep = " ")
      
      
      skipteam = ""
      
      #Loop for 2 until the end of nbateams
      for(i in 1:length(nbatms))
      {
        
        #Loop for all the NBA teams until we find a match for Home Team
        Teampos1 = regexpr(nbatms[i], theteamsplaying) 
        
        
        if (Teampos1 > -1)
        {
          
          FoundPosTm1 = Teampos1
          
          
          write(Teampos1, file = Debugfile,
                append = TRUE, sep = " ")
          
          skipteam = nbatms[i]
          
          write("Skip Team", file = Debugfile,
                append = TRUE, sep = " ")
          
          
          write(skipteam, file = Debugfile,
                append = TRUE, sep = " ")
          
          
          #Loop for 2 until the end of nbateams
          for(i in 1:length(nbatms))
          {
            
            if (nbatms[i] != skipteam)
            {
              #Loop for all the NBA teams until we find a match for Home Team
              Teampos2 = regexpr(nbatms[i], theteamsplaying) 
              
              
              if (Teampos2 > -1)
              {
                
                FoundPosTm2 = Teampos2
                
                write("Found Tm2", file = Debugfile,
                      append = TRUE, sep = " ")
                
                
                write(Teampos2, file = Debugfile,
                      append = TRUE, sep = " ")
                
                
                Tm1  = skipteam
                Tm2  = nbatms[i]
                
              }
            }        
            
          }
          
          
        }
      }
      write("Tm1 is", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(Tm1, file = Debugfile,
            append = TRUE, sep = " ")
      
      write("Tm2 is", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(Tm2, file = Debugfile,
            append = TRUE, sep = " ")
      
      
      AwayTm=Tm2
      HomeTm=Tm1  
      
      if (FoundPosTm1 == 1)
      {
        
        write("Teampos1 is 1 so Tm1 is Away", file = Debugfile,
              append = TRUE, sep = " ")
        
        AwayTm=Tm1
        HomeTm=Tm2  
        
        write("Away Team is Team1", file = Debugfile,
              append = TRUE, sep = " ")
        
        
      }  
      else
      {
        
        write("Teampos1 is NOT 1 so Tm1 is Home", file = Debugfile,
              append = TRUE, sep = " ")
        
        AwayTm=Tm2
        HomeTm=Tm1  
        
      }  
      
      write("At line 246 AwayTm is", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(AwayTm, file = Debugfile,
            append = TRUE, sep = " ")
      
      write("At line 246 HomeTm is", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(HomeTm, file = Debugfile,
            append = TRUE, sep = " ")
      
      
      
      
      #write("Comapring", file = filename,
      #      append = TRUE, sep = " ")
      
      #write(substr(Tm1,1,4), file = filename,
      #      append = TRUE, sep = " ")
      
      #write(substr(theteamsplaying,1,4), file = filename,
      #      append = TRUE, sep = " ")
      
      
      openline        <- tbls_ls[[1]][gamect,2]
      currentline     <- tbls_ls[[1]][gamect,10]
      alllines        <- tbls_ls[[1]][gamect,8:21]
      thestr <- currentline
      
      checkthis = substr(thestr,1,3)
      
      write("checkthis is", file = Debugfile,
            append = TRUE, sep = " ")
      
      write(checkthis, file = Debugfile,
            append = TRUE, sep = " ")
      
      if(checkthis > '100') {
        
        
        write("checkthis is gt 100", file = Debugfile,
              append = TRUE, sep = " ")
        
        checksign = substr(thestr,6,6)
        
        write("checksign is", file = Debugfile,
              append = TRUE, sep = " ")
        
        write(checksign, file = Debugfile,
              append = TRUE, sep = " ")
        
        
        if (checksign == '-') {
          
          write("checksign is -", file = Debugfile,
                append = TRUE, sep = " ")
          
          fav=HomeTm
          und=AwayTm
          
          ha <- "H"
          
        }
        else {
          
          write("checksign is NOT -", file = Debugfile,
                append = TRUE, sep = " ")
          
          fav=AwayTm
          und=HomeTm
          ha <- "A"
          
        }
        
        
        spd <- substr(thestr,7,11)
        tot <- substr(thestr,1,5) 
        
      } else {
        
        
        write("checkthis is NOT gt 100", file = Debugfile,
              append = TRUE, sep = " ")
        
        checksign = substr(thestr,1,1)
        
        
        write("checksign is", file = Debugfile,
              append = TRUE, sep = " ")
        
        write(checksign, file = Debugfile,
              append = TRUE, sep = " ")
        
        
        
        periodfind = gregexpr("\\.", thestr)
        periodpos = periodfind[[1]][1]
        
        
        if (checksign == '-') {
          fav=AwayTm
          und=HomeTm
          
          ha  <- "A"
          
          write("checksign is - (else)", file = Debugfile,
                append = TRUE, sep = " ")
          
          
        }
        else {
          
          
          ha <- "H"
          fav=HomeTm
          und=AwayTm
          
          
          write("checksign is NOT - (else)", file = Debugfile,
                append = TRUE, sep = " ")
          
          
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
      
      
      
      write("--------------------------------------", file = filename,
            append = TRUE, sep = " ")
      
      write(fav, file = filename,
            append = TRUE, sep = " ")
      write(ha, file = filename,
            append = TRUE, sep = " ")
      
      write(spd, file = filename,
            append = TRUE, sep = " ")
      
      write(tot, file = filename,
            append = TRUE, sep = " ")
      
      write(und, file = filename,
            append = TRUE, sep = " ")
      
    }
    
    
    df_Spreads <- data.frame(v_GAMETIME,v_Fav,v_HA,v_SPD,v_Und,v_ou)
    #df_Spreads <- data.frame(v_Fav,v_HA,v_SPD,v_Und,v_ou)
    
    
    sqlSave(channel, df_Spreads[2:20,1:6], tablename = "nbaschedule", append = TRUE, fast = F, rownames=FALSE)
    #length(df_Spreads[2,])
    
    
    # team playing tbls_ls[[1]][3,3]
    # spreads tbls_ls[[1]][3,10]
    
    
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
    
    
    
    
    
