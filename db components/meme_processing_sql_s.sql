CREATE OR REPLACE PACKAGE SYSTEM.MEME_PROCESSING_SQL 
AS
   --
----------------------------------------------------------------------------------
-- Function Name : USER_AUTHENTICATE
-- Purpose       : This function is used to authenticate the existing user or 
--                 insert new users into meme_users
----------------------------------------------------------------------------------
FUNCTION USER_AUTHENTICATE(O_error_message  IN OUT  VARCHAR2,
                           I_username       IN      VARCHAR2,
                           I_password       IN      VARCHAR2,
                           I_new_user       IN      VARCHAR2,
                           I_first_name     IN      VARCHAR2,
                           I_last_name      IN      VARCHAR2,
                           I_email_id       IN      VARCHAR2,
                           O_user_id           OUT  NUMBER)
RETURN BOOLEAN;

END MEME_PROCESSING_SQL;
/

SHOW ERRORS;

CREATE OR REPLACE PUBLIC SYNONYM MEME_PROCESSING_SQL FOR SYSTEM.MEME_PROCESSING_SQL;