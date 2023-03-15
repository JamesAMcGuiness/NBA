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
