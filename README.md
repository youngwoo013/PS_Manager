# PS_Manager
Project Schedule Manager

made by Jonathan, Youngwoo, Seyoung
---
19.07.18 pm 08:00
현재 회원가입 기능을 임시적으로 만들어봄

부트스트랩을 이용해 디자인을 넣어보고 웹 페이지 경로를 어떻게할지 상의해야할 듯


---
2019.07.31 수요일 실시간 익명 채팅방 설명

현재 실시간 익명 채팅 기능을 기본적으로 구현함

이미지는 db가 나와야 할 수 있음

chat 데이터 베이스의 구조는 다음과 같다

create table chat(

  chatID number,
  
  chatName varchar(20),
  
  chatContent varchar(100),
  
  chatTime date
  
  );
  
그리고 내용을 보면 seq_chatID.NEXTVAL 이 부분이 있는데 sequence를 만들어줘야함

1. system 계정으로 grant create sequence to USERNAME 으로 권한을 준 다

2. CREATE SEQUENCE SEQ_ID INCREMENT BY 1 START WITH 1; 이렇게 만들어 준다.

---
