c Part 1 function, called for each line
        integer function part1(line)
            implicit none

c           Line buffer
            character line*100

c           Line buffer size
            integer, parameter :: BUFSIZE = 100

c           Loop index
            integer i
c           Current char
            character c
c           Signal or output
            integer mode
c           Word length
            integer wordLength

            mode = 0
            wordLength = 0
            part1 = 0

            do i = 1, BUFSIZE
                c = line(i:i)
                if (mode == 0) then
                    if (c == '|') then
                        mode = 1
                    else
c                       Mode == 0, we skip
                        cycle
                    endif
                endif

c               Now we know we're in the output mode
                if (c >= "a" .and. c <= "g") then
                    wordLength = wordLength + 1
                else if (c == " ") then
                    if (     wordLength == 2
     &              .or. wordLength == 3
     &              .or. wordLength == 4
     &              .or. wordLength == 7
     &          ) then
                        part1 = part1 + 1
                    endif
                    wordLength = 0
                else
c                   Probably out of the buffer
                endif
            enddo

            return
        endfunction part1
c End part 1 function
