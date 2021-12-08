c Part 1 function, called for each line
        integer function part1(line)
            implicit none

            character line*100 ! Line buffer

            integer, parameter :: BUFSIZE = 100 ! Line buffer size

            integer i ! Loop index
            character c ! Current char
            integer mode ! Signal or output
            integer wordLength ! Word length
            mode = 0
            wordLength = 0

            part1 = 0

            do i = 1, BUFSIZE
                c = line(i:i)
                if (mode == 0) then
                    if (c == '|') then
                        mode = 1
                    else
                        ! Mode == 0, we skip
                        cycle
                    endif
                endif

                ! Now we know we're in the output mode
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
                    ! Probably out of the buffer
                endif
            enddo

            return
        endfunction part1
c End part 1 function
