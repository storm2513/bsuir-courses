require 'curses'

class Car
  def initialize
    @image = [ '                             $$$$$$$$$$$$$$$$$$$$$$$        ',
               '                            $$$$$_____$$_____$$____$$       ',
               '                          $$$$$_______$$______$$____$$      ',
               '                        $$$$$_________$$_______$$____$$     ',
               '                     $$$$$____________$$________$$____$$    ',
               '               $$$$$$$$$$$$$$$$$$$$$$$$$_________$$____$$   ',
               '         $$$$$$________$$_____________$$__________$$$$$$$$  ',
               '    $$$$$$_____________$$_____________$$_________________$$ ',
               '  $$___________________$$_____________$$_________________$$ ',
               '  $$________$$$$$______$$_____________$$________$$$$$____$$ ',
               '  $$______$$$$$$$$$____$$_____________$$______$$$$$$$$$___$$',
               '  $$$$$_$$$$_____$$$_$$$$$$$$$$$$$$$$$$$$$$__$$$$____$$$__$$',
               '        $$$$_____$$$                         $$$$____$$$$   ',
               '        $$$$____$$$                          $$$$$___$$$$   ',
               '          $$$$$_$$$                           $$$$$$_$$$    ',
               '            $$$$$$                               $$$$$$     ']
    @particle = ' *'
  end

  def print(y, x)
    k = 0
    prng = Random.new

    while k < @image.length
      Curses.setpos(y + k, x)
      if k.between?(9, 12)
        temp_Str = String.new(' ')
        rand_Val = prng.rand(0..4)
        i = 1
        temp_Str.concat(@image[k])
        if i < rand_Val
          i += 3
          temp_Str.concat(' ')
        end

        while i > rand_Val
          temp_Str.concat(@particle)
          i -= 1
        end

        Curses.addstr(temp_Str)
      else
        Curses.addstr(@image[k])
      end

      k += 1
    end

    Curses.refresh
  end
end

class Animator
  def initialize
    @car = Car.new
    Curses.init_screen
    Curses.nl
    Curses.noecho
    Curses.curs_set(0)
  end

  def animate
    shift_coord = 0
    y = Curses.lines / 2
    x = Curses.cols / 2

    while shift_coord < 70
      if  x - shift_coord > 0
        @car.print(y, x - shift_coord)
        sleep(0.05)
        Curses.clear
      end

      shift_coord += 1
    end
  end
end

Animator.new.animate
