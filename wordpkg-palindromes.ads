-- This Ada package specification adds palindrome checking,
-- removal of non-letters, and transforming to upper and lower case
-- to the word package.
WITH Ada.Text_IO; USE Ada.Text_IO;

GENERIC

PACKAGE WordPkg.Palindromes IS

   FUNCTION Is_Pal (W : Word)
     RETURN Boolean;

   FUNCTION To_Upper (W : Word)
      RETURN Word;

   FUNCTION Remove_NonLetter (W : Word)
     RETURN Word;

   PROCEDURE To_Upper (W : IN OUT Word);

   PROCEDURE Remove_Nonletter (W : IN OUT Word);

END WordPkg.Palindromes;
