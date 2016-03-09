library(jsonlite)

marcas <- fromJSON(readLines("https://fipeapi.appspot.com/api/1/carros/marcas.json"))

modelos <- data.frame()
for(i in 1:length(marcas$id)){
  url_temp <- paste("https://fipeapi.appspot.com/api/1/carros/veiculos/",marcas$id[i],".json", collapse="",sep="")
  modelos_temp <- fromJSON(readLines(url_temp))
  modelos_temp$id_marca <- marcas$id[i]
  modelos <- rbind(modelos, modelos_temp)
}

length(modelos$id)
carros <- data.frame()
for(i in 1:100){
  url_temp <- paste("https://fipeapi.appspot.com/api/1/carros/veiculo/",modelos$id_marca[i],
                    "/", modelos$id[i],".json", collapse="",sep="")
  carros_temp <- fromJSON(readLines(url_temp,warn=F))
  carros_temp$id_marca <- modelos$id_marca[i]
  carros_temp$id_modelo <- modelos$id[i]
  carros <- rbind(carros, carros_temp)
}

length(carros$id)
fipe <- data.frame()
for(i in 1:100){
  url_temp <- paste("https://fipeapi.appspot.com/api/1/carros/veiculo/",
                    carros$id_marca[i],"/", 
                    carros$id_modelo[i],"/",
                    carros$key[i],".json", collapse="",sep="")
  fipe_temp <- fromJSON(readLines(url_temp,warn=F))
  fipe <- rbind(fipe, fipe_temp)
}
