pkg=installed.packages()
pkg

.libPaths()
data(package="dataset")

#직사각형의 면적을 구하는 함수 정의
getRectangleArea = function(w, h) {
  area = w * h
  return(area)
}

w = 20
h = 35

getRectangleArea(w, h)

chck = function(a, b, c) {
  area = a+b-c
  return(area)
}

a = 10

b = 6

c = 5

chck(a, b, c)

# 3장 데이터구조
# 벡터: 선형으로 1개 이상의 숫자 또는 문자열들을 저장가능
# 인덱스는 1부터 시작

score = 80
score

score=c(95, 78, 92)
score #print(score)

score[2]=88
score[4]=100
score

name = c ("장발장", "팡 틴", "코제트")
name

name[4] = "자베르"

name

# 연속적인 값들을 벡터에 저장
x1=seq(10, 100, by=10)
x1

x2=1:10
seq(1, 10, by=1)
x2

x3=10:1
seq(1, 10, by=1)
x3

x4=seq(0,10, length.out=5)
x4

#반복(repeat) 함수: rep(), times,each 속성
x5 = c(1, 2, 3)
y1 = rep(x5, times=3)
y1

x6 = c(1, 2, 3)
y2 = rep(x6, each=3)
y2


# 연산자
# 산술연산자

10^3

a=5
b=5

r1 = a^b
r1

x=c(10, 20, 30, 40)
y=c(1, 6, 11, 16)
w=c(100, 200)

x+5
x+y
x+w

a=7
b=10

a>b

x=c(10, 20, 30)
x <= 10

any(x<=10)
all(x<=10)

#벡터에서 20이상인 요소를 반환
x[x>=20]

x=c(TRUE, TRUE, FALSE, FALSE)
y=c(TRUE, TRUE, FALSE, FALSE)

x | y
x & y
xor(x, y)

# NA(Not Available(결측치): 누락된 경우)
# NULL(변수를 선언하고 초기화하지 않았을 때)
# INF(Infinity: 0이 아닌 숫자를 0으로 나누었을 때)
# NaN(Not a Number: 0을 0으로 나누었을 때)

z = NULL
z

is.null(z)

k
is.null(k) # k를 초기화하지 않음, 값을 넣지 않을 때는 NULL을 대입해야함

y = c(1, 2, 3, NA, 5)
y

z = 5/0
z

t = 0/0
t

# 요인(factor)
# 벡터에 저장된 동일한 값들을 요인으로 찾아내서 대표값들만 분류해서 반환 + 기존 벡터값도 함께 반환 

gender = c("여", "남", "남", "여", "여", "남")
gender

gender.factor = factor(gender)
gender.factor