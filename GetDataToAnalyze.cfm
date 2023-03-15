<cfquery datasource="NBA" name="GetIt">
Select 
    fp.Fav, fp.spd, fp.ha, fp.WhoCovered, fp.und, fp.FavPlayedYest, fp.FavOffLoss, fp.UndPlayedYest, fp.UndOffLoss, fp.favLatestCovCt, fp.undLatestCovCt,
    bta.Team, bta.PowerReb,bta.PowerInside,bta.PowerOutside,bta.PowerPts,
    gp.Team, gp.FGPct,gp.Rebounding,gp.Scoring,gp.FGAtt,gp.TPAtt, gp.TpPct, gp.FTAtt,
    eff.Team, eff.Gametime, eff.toteffl2,eff.toteffl3,eff.toteffl4,eff.conseqgood,eff.conseqbad 
