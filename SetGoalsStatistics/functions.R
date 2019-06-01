FilterTestAccounts <- function(matrix){
  matrix <- matrix %>% 
    filter(accountId != "myzhtGtYzchuiptvmMNE6ssmfyz1") %>% 
    filter(accountId != "ytguYFSKHCavs5DZMxkkfso3xiS2") %>% 
    filter(accountId != "JUco19TvdCQ6nxqoz1xIHWPmaOS2") %>% 
    filter(accountId != "1HrLGpVK22SShbMtPckV1Ni5Aki2") %>% 
    filter(accountId != "TAsjKP4tUOM0gnNx8sl1uERH27A2")
  return(matrix)
}