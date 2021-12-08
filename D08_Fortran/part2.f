c Part 2 function, called for each line
        integer function part2(line)
            implicit none

c           Line buffer
            character line*100

c           Line buffer size
            integer, parameter :: BUFSIZE = 100

            part2 = 0
            return
        end function part2
c End part 2 function
