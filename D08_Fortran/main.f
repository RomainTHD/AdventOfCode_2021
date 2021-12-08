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

            integer part ! Part 1 or 2

            integer, parameter :: BUFSIZE = 100 ! Line buffer size
            integer, parameter :: f = 10 ! File

            integer IO_status ! Error status
            integer lineno ! Line number
            character line*100 ! Line buffer
            integer res ! Result

            integer part1
            integer part2

            res = 0

            ! Open file
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

            ! Loop through the file
100         continue

            ! Read an entire line
            read (f, "(a)", iostat = IO_Status) line

            ! Check for error
            if (IO_Status > 0) then
                print *, "Error while reading line"
                stop
            end if

            ! Check for EOF
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
