CREATE OR REPLACE PACKAGE BODY SYSTEM.MEME_PROCESSING_SQL
AS

----------------------------------------------------------------------------------
-- Function Name : USER_AUTHENTICATE
-- Purpose       : This function is used to authenticate the existing user or 
--                 insert new users into meme_users
----------------------------------------------------------------------------------
FUNCTION USER_AUTHENTICATE(O_error_message   IN OUT   VARCHAR2,
                           I_username        IN       VARCHAR2,
                           I_password        IN       VARCHAR2,
                           I_new_user        IN       VARCHAR2,
                           I_first_name      IN       VARCHAR2,
                           I_last_name       IN       VARCHAR2,
                           I_email_id        IN       VARCHAR2,
                           O_user_id            OUT   NUMBER)
RETURN BOOLEAN AS
  --
  L_user_id     NUMBER(30)   := USER_ID_SEQ.NEXTVAL;
  L_user_exists VARCHAR2(10) := NULL;
  --
  CURSOR C_USER_AUTENTICATE IS
    SELECT 'X'
      FROM MEME_USERS
     WHERE UPPER(USER_NAME) = UPPER(I_USERNAME)
       AND SYS.UTL_RAW.CAST_TO_VARCHAR2(PASSWORD) = I_password;
  --
BEGIN

   IF I_new_user = 'Y' THEN
      --
      INSERT INTO MEME_USERS(USER_ID,
                             USER_NAME,
                             PASSWORD,
                             FIRST_NAME,
                             LAST_NAME,
                             EMAIL_ID,
                             CREATE_ID,
                             CREATE_DATETIME,
                             UPDATE_ID,
                             UPDATE_DATETIME)
                      VALUES(L_user_id,
                             I_username,
                             UTL_RAW.CAST_TO_RAW(I_password),
                             I_first_name,
                             I_last_name,
                             I_email_id,
                             USER,
                             SYSDATE,
                             USER,
                             SYSDATE);
      --
  ELSE
      --
      OPEN  C_USER_AUTENTICATE;
      FETCH C_USER_AUTENTICATE INTO L_user_exists;
      CLOSE C_USER_AUTENTICATE;
      --
      IF L_user_exists IS NULL THEN
         --
         O_error_message := 'Invalid Username and Password';
         RETURN FALSE;
         --
      END IF;
      --
  END IF;
  --
  COMMIT;
  RETURN TRUE;
EXCEPTION
WHEN OTHERS THEN
   O_error_message := 'PACKAGE_ERROR'||'-'||SQLERRM||TO_CHAR(SQLCODE);
   RETURN FALSE;
END USER_AUTHENTICATE;

END;
/

SHOW ERRORS;