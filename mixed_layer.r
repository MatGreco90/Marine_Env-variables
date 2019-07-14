#function to calculate MIXED LAYER DEPTH (MLD), defined as the depth where
#in situ water density varied by more than 0.03 kg/m3 from the surface reference (first 10 meters)
#argument is a dataframe (single CTD station/profile) containing the columns: water depth (col1) and sigma-theta (col2)
MLD_calc<- function (df, col1,col2) {
  thrs=0.03
  my.pos.surface.depth=which.max(df[[col1]]>=9.9 & df[[col1]]<11)
  my.surface.depth=df[[col1]][my.pos.surface.depth]
  my.sigma.surface.value=df[[col2]][my.pos.surface.depth]
  my.pos= which.max(df[[col1]]>(my.surface.depth) & df[[col2]]>(my.sigma.surface.value+thrs))
  my.mixedlayerdepht=df[[col1]][my.pos]
  my.mixedlayerdepht
  
}
