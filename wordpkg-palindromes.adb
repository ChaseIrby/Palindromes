-- Name: Chase Irby
-- Date: April 9, 2014
-- Course: ITEC 320 Principles of Procedural Programming

-- Purpose: This is simply a package body that expands upon
--    the specification in wordpkg-palindromes.ads

-- Input: N/A

-- Each procedure/function is fed a word (see wordpkg.ads)

-- Output varies per procedure/function.

-- Parameters passed are assumed to be valid

-- Help received: N/A

-- WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Characters.Handling;

PACKAGE BODY WordPkg.Palindromes IS

   PACKAGE ACH RENAMES Ada.Characters.Handling;

   --------------------------------------------------------
   -- Purpose: Checks if the word passed is a palindrome without
   --    modification
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Returns TRUE or FALSE depending on whether
   --    or not W is a palindrome
   --------------------------------------------------------
   FUNCTION Is_Pal (W : Word) RETURN Boolean IS

      Palindrome_Status: Boolean;
      Counter : Integer := W.Length;

   BEGIN

      FOR I IN 1 .. W.Length LOOP

         IF W.Letters(I) = W.Letters(Counter) THEN
            Palindrome_Status := TRUE;
            Counter := Counter - 1;
         ELSE
            Palindrome_Status := FALSE;
            EXIT;

         END IF;

      END LOOP;

      RETURN Palindrome_Status;

   END Is_Pal;

   --------------------------------------------------------
   -- Purpose: Changes all letters in W to uppercase
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Returns the all uppercase version of the W
   --    passed as "Holder"
   --------------------------------------------------------
   FUNCTION To_Upper (W : Word) RETURN Word IS

      Holder : Word;

   BEGIN

      Holder := W;

      FOR I IN 1 .. Holder.Length LOOP

         Holder.Letters(I) := ACH.To_Upper(W.Letters(I));

      END LOOP;

      RETURN Holder;

   END To_Upper;

   --------------------------------------------------------
   -- Purpose: Removes any nonletter character from the W passed
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Returns a version of W that has had all
   --    nonletters removed as "Holder"
   --------------------------------------------------------
   FUNCTION Remove_NonLetter (W : Word) RETURN Word IS

      Holder : Word;
      What_Index : Integer := 1;

   BEGIN

      FOR I IN 1 .. W.Length LOOP

         IF ACH.Is_Letter(W.Letters(I)) THEN

            Holder.Letters(What_Index) := W.Letters(I);
            Holder.Length := Holder.Length + 1;
            What_Index := What_Index + 1;

         END IF;

      END LOOP;

      RETURN Holder;

   END Remove_NonLetter;

   --------------------------------------------------------
   -- Purpose: Calls the function To_Upper on W
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Modifies W to be uppercase
   --------------------------------------------------------
   PROCEDURE To_Upper (W : IN OUT Word) IS

   BEGIN

      W := To_Upper(W);

   END To_Upper;

   --------------------------------------------------------
   -- Purpose: Calls the function Remove_Nonletter on W
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Modifies W in that it removes nonletters
   --------------------------------------------------------
   PROCEDURE Remove_Nonletter (W : IN OUT Word) IS

   BEGIN

      W := Remove_Nonletter(W);

   END Remove_Nonletter;
--------------------------------------------------------------------------
END WordPkg.Palindromes;