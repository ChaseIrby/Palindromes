-- This Ada package body gives the implementation for the word abstract
-- data type.  A word is considered to be any consecutive sequence of
-- non-white-space characters.

WITH Ada.Text_IO; USE Ada.Text_IO;
PACKAGE BODY WordPkg IS

    -- Creates a new word corresponding to the given string.
   FUNCTION New_Word(Item : String) RETURN Word IS

      A_Word : Word;

   BEGIN

      A_Word.Letters(1..Item'Length) := Item;
      A_Word.Length := Item'Length;
      RETURN A_Word;

   END New_Word;

    -- Indicates the number of characters in a word.
   FUNCTION Length (Item : Word) RETURN Natural IS

   BEGIN

      RETURN Item.Length;

   END Length;

    -- Returns the maximum word size supported by this package.
   FUNCTION Max_Word_Size RETURN Positive IS

   BEGIN

      RETURN MaxWordSize;

   END Max_Word_Size;

    -- Word comparison functions.  The dictoinary lexiographic ordering
    -- is used to determine when one word is less than another.

   FUNCTION "="  (X, Y : Word) RETURN Boolean IS

   BEGIN

      RETURN X.Length = Y.Length AND THEN
         X.Letters(1..X.Length) = Y.Letters(1..Y.Length);

   END "=";

   FUNCTION "<="  (X, Y : Word) RETURN Boolean IS

   BEGIN

      FOR I IN 1..Natural'Min (X.Length, Y.Length)  LOOP

         IF X.Letters(I) < Y.Letters(I) THEN
            RETURN True;

         ELSIF X.Letters(I) > Y.Letters(I) THEN
            RETURN False;

         END IF;

      END LOOP;

      RETURN X.Length <= Y.Length;

   END "<=";

   FUNCTION "<" (X, Y : Word) RETURN Boolean IS

   BEGIN

      RETURN X <= Y AND NOT (X = Y);

   END "<";

   FUNCTION ">=" (X, Y : Word) RETURN Boolean IS

   BEGIN

      RETURN NOT (X < Y);

   END ">=";

   FUNCTION ">"  (X, Y : Word) RETURN Boolean IS

   BEGIN

      RETURN NOT (X <= Y);

   END ">";

    -- I/O routines

    -- Skip over any spaces, tabs, or end of line markers in the input to
    -- determine whether or not another word is present.  If another word
    -- is present, then return True, otherwise return False.
   FUNCTION Another_Word (File : File_Type) RETURN Boolean IS

      C : Character;
      End_Line : Boolean;

   BEGIN

      LOOP

         EXIT WHEN End_Of_File (File);
         Look_Ahead (File, C, End_Line);

         IF End_Line THEN
            Skip_Line (File);

         ELSE
            IF C /= ' ' AND C /= ASCII.HT THEN
               RETURN True;
            END IF;

            Get (File, C);

         END IF;

      END LOOP;

      RETURN False;

   END Another_Word;

    -- Skip any white-space that may preceed the word in the input.
    -- If the word is too long to fit in the representation being
    -- used, then raise the WordTooLong exception after the characters
    -- of the word have been read (though not stored).
   PROCEDURE Get (File : File_Type; Item : OUT Word) IS

      C : Character;
      End_Line : Boolean;
      TooLong : Boolean := False;

   BEGIN

      Item.Length := 0;

      IF Another_Word (File) THEN

         LOOP

            EXIT WHEN End_Of_File (File);

            Look_Ahead (File, C, End_Line);

            EXIT WHEN End_Line;

            EXIT WHEN C = ' ' OR ELSE C = ASCII.HT;

            Get (File, C);

                -- Raise an exception if the word won't fit.
            IF Item.Length = MaxWordSize THEN
               TooLong := True;
            END IF;

            IF NOT TooLong THEN
               Item.Length := Item.Length + 1;
               Item.Letters(Item.Length) := C;

            END IF;

         END LOOP;

         IF TooLong THEN
            RAISE WordTooLong;
         END IF;

      END IF;

   END Get;


   PROCEDURE Get (Item : OUT Word) IS

   BEGIN

      Get (Standard_Input, Item);

   END Get;

    -- Write only those characters that make up the word.
   PROCEDURE Put (File : File_Type; Item : Word) IS

   BEGIN

      FOR I IN 1..Length(Item) LOOP
         Put (File, Item.Letters(I));
      END LOOP;

   END Put;

   PROCEDURE Put (Item : Word) IS

   BEGIN

      Put (Standard_Output, Item);

   END Put;

END WordPkg;
