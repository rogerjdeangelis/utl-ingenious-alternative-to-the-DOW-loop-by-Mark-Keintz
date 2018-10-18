Ingenious alternative to the DOW loop by Mark Keintz

 TWO SOLUTIONS (this is a dumb example but a elegant useful tool)

    1. Interleave by group two pass solution by (amother tool for complex subsetting)
         Keintz, Mark <mkeintz@wharton.upenn.edu>

    2. Classic DOW Loop

see  github
https://tinyurl.com/ybs8bxkd
https://github.com/rogerjdeangelis/utl-ingenious-alternative-to-the-DOW-loop-by-Mark-Keintz

Problem: select students and their classes who are taking at least on math class

INPUT
=====

 WORK.HAVE total obs=9

  NAME     CLASS

  KEVIN    SHOP
  KEVIN    ART
  KEVIN    SCIENCE

  MARY     MUSIC
  MARY     MATH
  MARY     HISTORY    * only output MARY classes

  ROGER    HISTORY
  ROGER    MUSIC
  ROGER    CIVICS


EXAMPLE OUTPUT
--------------

WORK.WANT total obs=3

   NAME    CLASS      MATH

   MARY    MUSIC        1
   MARY    MATH         1
   MARY    HISTORY      1


PROCESS
=======

 1. Interleave by group two pass solution by (amother tool for complex subsetting)

    data want;
      set have (in=firstpass)  have (in=secondpass);
      by name;
      retain math ;
      if first.name then math=0;
      if class='MATH' then math=1;
      if secondpass and math then output;
    run;quit;

2.  Classic DOW Loop

    data want;
      retain math 0;
      do until (last.name);
        set have;
        by name;
        if class="MATH" then math=1;
      end;
      do until (last.name);
        set have;
        by name;
        if math=1 then output;;
      end;
      math=0;
    run;quit;

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
  input name$ class$;
cards4;
KEVIN SHOP
KEVIN ART
KEVIN SCIENCE
MARY MUSIC
MARY MATH
MARY HISTORY
ROGER HISTORY
ROGER MUSIC
ROGER CIVICS
;;;;
run;quit;

