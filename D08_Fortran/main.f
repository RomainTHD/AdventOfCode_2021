c Main program
        program D08
            print *, "Part 1:"
            call main(1)
            print *, "Part 2:"
            call main(2)
            print *, "OK"

            stop
        endprogram D08
c End main program

c Include part 1 and part 2
        include "part1.f"
        include "part2.f"

c Main subroutine, will call part 1 and part 2
        subroutine main(part)
            implicit none

c           Part 1 or 2
            integer part

c           Line buffer size
            integer, parameter :: BUFSIZE = 100
c           File
            integer, parameter :: f = 10

c           Error status
            integer IO_status
c           Line number
            integer lineno
c           Line buffer
            character line*100
c           Result
            integer res

            integer part1
            integer part2

            res = 0

c           Open file
            open(f, file = "input",
     &              form = "formatted",
     &              access = "sequential",
     &              status = "old",
     &              iostat = IO_status)

            if (IO_Status /= 0) then
                print *, "Error opening file"
                stop
            end if

            lineno = 0

c           Loop through the file
100         continue

c           Read an entire line
            read (f, "(a)", iostat = IO_Status) line

c           Check for error
            if (IO_Status > 0) then
                print *, "Error while reading line"
                stop
            end if

c           Check for EOF
            if (IO_Status < 0) then
                close(f)
                goto 200
            end if

            if (part == 1) then
                res = res + part1(line)
            else
                res = res + part2(line)
            endif

            lineno = lineno + 1
            goto 100

200         print *, res
            return
        endsubroutine main
c End main subroutine
