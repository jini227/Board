/* 회원 */
CREATE TABLE MEMBER (
	SEQ NUMBER NOT NULL, /* SEQ */
	ID VARCHAR2(20) NOT NULL, /* ID */
	PASSWORD VARCHAR2(20) NOT NULL, /* PASSWORD */
	NAME VARCHAR2(20), /* NAME */
	PHONE VARCHAR2(20), /* PHONE */
	EMAIL VARCHAR2(20), /* EMAIL */
	ROLE VARCHAR2(20) NOT NULL /* ROLE */
);

COMMENT ON TABLE MEMBER IS '회원';

COMMENT ON COLUMN MEMBER.SEQ IS 'SEQ';

COMMENT ON COLUMN MEMBER.ID IS 'ID';

COMMENT ON COLUMN MEMBER.PASSWORD IS 'PASSWORD';

COMMENT ON COLUMN MEMBER.NAME IS 'NAME';

COMMENT ON COLUMN MEMBER.PHONE IS 'PHONE';

COMMENT ON COLUMN MEMBER.EMAIL IS 'EMAIL';

COMMENT ON COLUMN MEMBER.ROLE IS '일반/관리자 구분';

CREATE UNIQUE INDEX PK_MEMBER
	ON MEMBER (
		SEQ ASC
	);

ALTER TABLE MEMBER
	ADD
		CONSTRAINT PK_MEMBER
		PRIMARY KEY (
			SEQ
		);

/* 게시판 */
CREATE TABLE BOARD (
	SEQ NUMBER NOT NULL, /* SEQ */
	MEMBER_SEQ NUMBER NOT NULL, /* MEMBER_SEQ */
	CONTENTS_TYPE VARCHAR2(20) NOT NULL, /* CONTENTS_TYPE */
	TITLE VARCHAR2(50) NOT NULL, /* TITLE */
	PET_LOCATION VARCHAR2(50), /* PET_LOCATION */
	PET_TIME VARCHAR2(50), /* PET_TIME */
	PET_TYPE VARCHAR2(50), /* PET_TYPE */
	PET_NAME VARCHAR2(50), /* PET_NAME */
	PET_GENDER VARCHAR2(50), /* PET_GENDER */
	PET_MEMO VARCHAR2(2000), /* PET_MEMO */
	REVIEW VARCHAR2(2000), /* REVIEW */
	HIT NUMBER, /* HIT */
	REG_DATE VARCHAR2(100) NOT NULL /* REG_DATE */
);

COMMENT ON TABLE BOARD IS '게시판';

COMMENT ON COLUMN BOARD.SEQ IS 'SEQ';

COMMENT ON COLUMN BOARD.MEMBER_SEQ IS 'MEMBER_SEQ';

COMMENT ON COLUMN BOARD.CONTENTS_TYPE IS 'lost/find 게시판 구분';

COMMENT ON COLUMN BOARD.TITLE IS 'TITLE';

COMMENT ON COLUMN BOARD.PET_LOCATION IS 'PET_LOCATION';

COMMENT ON COLUMN BOARD.PET_TIME IS 'PET_TIME';

COMMENT ON COLUMN BOARD.PET_TYPE IS 'PET_TYPE';

COMMENT ON COLUMN BOARD.PET_NAME IS 'PET_NAME';

COMMENT ON COLUMN BOARD.PET_GENDER IS 'PET_GENDER';

COMMENT ON COLUMN BOARD.PET_MEMO IS 'PET_MEMO';

COMMENT ON COLUMN BOARD.REVIEW IS 'REVIEW';

COMMENT ON COLUMN BOARD.HIT IS 'HIT';

COMMENT ON COLUMN BOARD.REG_DATE IS 'REG_DATE';

CREATE UNIQUE INDEX PK_BOARD
	ON BOARD (
		SEQ ASC
	);

ALTER TABLE BOARD
	ADD
		CONSTRAINT PK_BOARD
		PRIMARY KEY (
			SEQ
		);

/* 댓글 */
CREATE TABLE COMMENTS (
	SEQ NUMBER NOT NULL, /* SEQ */
	BOARD_SEQ NUMBER NOT NULL, /* BOARD_SEQ */
	MEMBER_SEQ NUMBER NOT NULL, /* MEMBER_SEQ */
	MEMO VARCHAR2(1000) NOT NULL, /* MEMO */
	REG_DATE VARCHAR2(100) NOT NULL /* REG_DATE */
);

COMMENT ON TABLE COMMENTS IS '댓글';

COMMENT ON COLUMN COMMENTS.SEQ IS 'SEQ';

COMMENT ON COLUMN COMMENTS.BOARD_SEQ IS 'BOARD_SEQ';

COMMENT ON COLUMN COMMENTS.MEMBER_SEQ IS 'MEMBER_SEQ';

COMMENT ON COLUMN COMMENTS.MEMO IS 'MEMO';

COMMENT ON COLUMN COMMENTS.REG_DATE IS 'REG_DATE';

CREATE UNIQUE INDEX PK_COMMENTS
	ON COMMENTS (
		SEQ ASC
	);

ALTER TABLE COMMENTS
	ADD
		CONSTRAINT PK_COMMENTS
		PRIMARY KEY (
			SEQ
		);

/* 이미지 */
CREATE TABLE IMAGE (
	SEQ NUMBER NOT NULL, /* SEQ */
	BOARD_SEQ NUMBER NOT NULL, /* BOARD_SEQ */
	ORIGINAL_FILE VARCHAR2(100), /* ORIGINAL_FILE */
	ORIGINAL_FILE_EXTENSION VARCHAR2(100), /* ORIGINAL_FILE_EXTENSION */
	STORED_FILE_NAME VARCHAR2(100) /* STORED_FILE_NAME */
);

COMMENT ON TABLE IMAGE IS '이미지';

COMMENT ON COLUMN IMAGE.SEQ IS 'SEQ';

COMMENT ON COLUMN IMAGE.BOARD_SEQ IS 'BOARD_SEQ';

COMMENT ON COLUMN IMAGE.ORIGINAL_FILE IS '파일 등록 이름';

COMMENT ON COLUMN IMAGE.ORIGINAL_FILE_EXTENSION IS '파일 확장자';

COMMENT ON COLUMN IMAGE.STORED_FILE_NAME IS '저장된 파일 이름';

CREATE UNIQUE INDEX PK_IMAGE
	ON IMAGE (
		SEQ ASC
	);

ALTER TABLE IMAGE
	ADD
		CONSTRAINT PK_IMAGE
		PRIMARY KEY (
			SEQ
		);

ALTER TABLE BOARD
	ADD
		CONSTRAINT FK_MEMBER_TO_BOARD
		FOREIGN KEY (
			MEMBER_SEQ
		)
		REFERENCES MEMBER (
			SEQ
		);

ALTER TABLE COMMENTS
	ADD
		CONSTRAINT FK_BOARD_TO_COMMENTS
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES BOARD (
			SEQ
		);

ALTER TABLE COMMENTS
	ADD
		CONSTRAINT FK_MEMBER_TO_COMMENTS
		FOREIGN KEY (
			MEMBER_SEQ
		)
		REFERENCES MEMBER (
			SEQ
		);

ALTER TABLE IMAGE
	ADD
		CONSTRAINT FK_BOARD_TO_IMAGE
		FOREIGN KEY (
			BOARD_SEQ
		)
		REFERENCES BOARD (
			SEQ
		);

CREATE SEQUENCE MEMBER_SEQ
NOCACHE;

CREATE SEQUENCE BOARD_SEQ
NOCACHE;

CREATE SEQUENCE COMMENTS_SEQ
NOCACHE;

CREATE SEQUENCE IMAGE_SEQ
NOCACHE;

ALTER TABLE BOARD ADD PET_MEET NUMBER;
ALTER TABLE BOARD ADD PHONE_PUBLIC VARCHAR2(10);
ALTER TABLE BOARD ADD EMAIL_PUBLIC VARCHAR2(10);
