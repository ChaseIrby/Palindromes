-- Name: Chase Irby
-- Date: April 9, 2014
-- Course: ITEC 320 Principles of Procedural Programming

-- Purpose: This program demonstrates the cooperation between generic
--    parent/child packages and the client. The catalyst for this
--    demonstration is palindrome evaluation

-- Input: A series of words until end of file (see wordpkg.ads) for
--    information on "word" type

-- Output: Original word, palindrome status of a given word,
--    and the word after any changes to become a palindrome

-- Input is assumed to be valid

-- Sample input:
--  b   madamimadam   Madam-I-madaM
-- madamImAdam      maDamI'maDam!
--
--          !madam.I'm.Adam?
--     randomstring

-- Sample output (one of each type):
-- String: Madam-I-madaM
-- Status: Palindrome as is

-- String: madamImAdam
-- Status: Palindrome when converted to upper case
-- PalStr: MADAMIMADAM

-- String: maDamI'maDam!
-- Status: Palindrome when non-letters are removed
-- PalStr: maDamImaDam

-- String: !madam.I'm.Adam?
-- Status: Palindrome when converted to upper case and non-letters are removed
-- PalStr: MADAMIMADAM

-- String: randomstring
-- Status: Never a palindrome

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Wordpkg.Palindromes;
WITH Ada.Command_Line;

PROCEDURE PALS IS

   PACKAGE Pals_Pckg IS NEW Wordpkg(80); USE Pals_Pckg;
   PACKAGE Pals_Child IS NEW Pals_Pckg.Palindromes;

   PACKAGE ACL RENAMES Ada.Command_Line;
   PACKAGE PC RENAMES Pals_Child;

   --------------------------------------------------------
   -- Purpose: Calls the various procedures and functions within
   --    Pals_Child to determine if the word passed can ever be
   --    a palindrome
   -- Parameters: W : Word
   -- Precondition: Word has length of 1 or greater and is an
   --    array of characters
   -- Postcondition: Outputs results of palindrome checking
   --------------------------------------------------------
   PROCEDURE Pal_Checker (W : IN Word) IS

      Holder : Word;

   BEGIN

      Holder := W;

      IF Pals_Child.Is_Pal(Holder) THEN
         Put("String: "); Put(W); New_Line;
         Put("Status: Palindrome as is"); New_Line;
         New_Line;

      ELSIF PC.Is_Pal(PC.To_Upper(W)) THEN
         Put("String: "); Put(W); New_Line;
         Put("Status: Palindrome when converted to upper case"); New_Line;
         Put("PalStr: "); Put(PC.To_Upper(Holder)); New_Line;
         New_Line;

      ELSIF PC.Is_Pal(PC.Remove_NonLetter(W)) THEN
         Put("String: "); Put(W); New_Line;
         Put("Status: Palindrome when non-letters are removed"); New_Line;
         Put("PalStr: "); Put(PC.Remove_NonLetter(Holder)); New_Line;
         New_Line;

      ELSIF PC.Is_Pal(PC.To_Upper(PC.Remove_NonLetter(W))) THEN
         Put("String: "); Put(W); New_Line;
         Put("Status: Palindrome when converted to upper case");
         Put(" and non-letters are removed"); New_Line;
         Put("PalStr: "); Put(PC.To_Upper(PC.Remove_NonLetter(Holder)));
         New_Line; New_Line;

      ELSE
         Put("String: "); Put(W); New_Line;
         Put("Status: Never a palindrome");
         New_Line; New_Line;

      END IF;

   END Pal_Checker;

   Wrd : Word;

BEGIN

   IF ACL.Argument_Count > 0 THEN
      FOR I IN 1 .. ACL.Argument_Count LOOP

         Wrd := New_Word(ACL.Argument(I));
         Pal_Checker(Wrd);

      END LOOP;

   ELSE
      WHILE NOT End_Of_File LOOP

         Get(Wrd);
         Pal_Checker(Wrd);

      END LOOP;
   END IF;

END PALS;

