install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggplot2)

# leaflet 객체 보여지는 지도의 설정과 오픈스트리트 맵 재단에서 제공하는 지도타일 추가
m = leaflet() %>%
  setView(lng=126.996542, lat=37.5290615, zoom = 15) %>%
  addTiles()

m

# 지도 중심에 마커 출력하는 방법
m = leaflet() %>%
  addTiles() %>%
  addMarkers(lng=126.996542, lat=37.5290615, label = "한국폴리텍대학", popup ="서울정수캠퍼스 인공지능소프트웨어")

m

# 오늘 내가 수업 끝난 후 갈 장소를 지도에 출력하고 장소이름은 라벨로 표시 주소는 팝업으로 표시
m = leaflet() %>%
  addTiles() %>%
  addMarkers(lng=126.977557, lat=37.533830, label = "국방부", popup ="차타는곳")

m

quakes

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~mag, stroke = TRUE, weight = 1, color = "black", fillColor = "red",fillOpacity = 0.3)
m

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag>=6, 10, 1), stroke = TRUE, weight = 1, color = "black", fillColor = "red",fillOpacity = 0.3)
m

# mag(지진규모가) 5.5 이상이면 반지름 10 아니면 0
# mag가 5.5 이상이면 테두리선의 굵기 1 아님 0
#mag 가 5.5이상이면 불투명도 0.3 아님 0

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 5.5, 10, 0), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = "black", 
    fillColor = "red", 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)
  )
m

#mag 6이상 반지름10, 5.5 이상이면 5, 아니면 0
#mag 가 5.5이상 테두리 굵기 1 아님 0
#mag 5.5이상이면 불투명도 0.3 아님 0
#mag 6이상이면 배경색 red, 5.5이상이면 green, 아니면 색이 없이

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 6, 10, ifelse(mag >= 5.5, 5, 0)), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = "black", 
    fillColor = ~ifelse(mag >= 6, "red", ifelse(mag >= 5.5, "green", "transparent")), 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)
  )
m


install.packages("sf")
library(sf)

map = st_read("D:/ljb/R_Data/Z_NGII_N3A_G0010000.shp")
map

ggplot(data = df_map) +
  geom_sf(fill="white", color="black")

if(!"id"%in%names(df_map)){
  df_map$id = 1:nrow(df_map)
}

ggplot(data = df_map) +
  geom_sf(aes(fill-id), alpha=0.3, color="black")+
  theme(legend.position="none")+
  labs(x="경도", y="위도")

install.packages("openxlsx")
library(openxlsx)

df = read.xlsx("D:/ljb/R_Data/국내지진목록.xlsx", sheet=1, startRow=4, colNames=FALSE)
head(df)

idx = grep("^북한", df$X8)

df[idx, 'X8']

df=df[-idx,]

df[, 6] = gsub("N", "", df[,6])
df[, 7] = gsub("E", "", df[,7])

df[,6] = as.numeric(df[,6])
df[,7] = as.numeric(df[,7])

# shapefile  읽어오기
map = st_read("D:/ljb/R_Data/Z_NGII_N3A_G0010000.shp")

#WGS84 좌표계로 변환
map = st_transform(map, crs=4326)

#포인트 데이터를 sf 객체로 변환
df_sf = df%>%st_as_sf(coords = c("X7", "X6"), crs = 4326)

df

# 행정경계지도 출력

ggplot() +
  geom_sf(data=map, fill="white", alpha=0.5, color="black")+
  geom_sf(data=df_sf, aes(size=X3), shape=21, fill="red", alpha=0.3, color="black")+
  theme(legend.position="none")+
  labs(title="지진분포", x="경도", y="위도")